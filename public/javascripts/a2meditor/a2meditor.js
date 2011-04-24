/**
 * @author kirillova
 */

 var A2mEditor = new Class({
 	
	Implements: [Events, Options],
	
	options:{
		toolbar: true,
		cleanup: true,
		actions: '| bold italic | bold italic',
	},
	
	initialize: function(el, options){
		this.setOptions(options);
		//Устанавливаем родительский textarea (с которым будет вестисть работа)
		this.textarea = $(el);
		this.textarea.store('A2mEditor', this);
		this.actions = this.options.actions.clean().split(' ');
		this.keys = {};
		this.dialogs = {};
		this.actions.each(function(action){
			var act = A2mEditor.Actions[action];
			if (!act) return;
			if (act.options){
				var key = act.options.shortcut;
				if (key) this.keys[key] = action;
			}
			if (act.dialogs){
				$each(act.dialogs, function(dialog, name){
					dialog = dialog.attempt(this);
					dialog.name = action + ':' + name;
					if ($type(this.dialogs[action]) != 'object') this.dialogs[action] = {};
					this.dialogs[action][name] = dialog;
				}, this);
			}
			if (act.events){
				$each(act.events, function(fn, event){
					this.addEvent(event, fn);
				}, this);
			}
		}.bind(this));
		this.render();
	},
	
	render: function(){
		
		var self = this;
		
		// Dimensions
		var dimensions = this.textarea.getSize();
		
		// Build the container
		this.container = new Element('div', {
			id: 'editor',
			'class': 'f-row'
		});
		
		this.toolbar = new A2mEditor.UI.Toolbar({
			onItemAction: function(){
				var args = $splat(arguments);
				var item = args[0];
				self.action(item.name, args);
			}
		});
		
		this.attach();
		
		this.fireEvent('render', this);
	},
	
	attach: function(){
		var self = this;
		
		// Assign view mode
		this.mode = 'inline';
		
		// Dimensions
		var dimensions = this.textarea.getSize();
		
		// Editor iframe state
		this.editorDisabled = false;

		// Put textarea inside container
		this.container.wraps(this.textarea);
		
		// Bind keyboard shortcuts
		this.textarea.addEvents({
			keypress: this.editorKeyPress.bind(this),
			keyup: this.editorKeyUp.bind(this),
			keydown: this.editorKeyDown.bind(this)
		});
		
		if (this.options.toolbar){
			$(this.toolbar).inject(this.container, 'top');
			this.toolbar.render(this.actions);
		}
		
		this.selection=new A2mEditor.Selection(this.textarea);
	},
	
	editorKeyPress: function(e){
		if (this.editorDisabled){
			e.stop();
			return;
		}
		
		this.keyListener(e);
		
		this.fireEvent('editorKeyPress', e);
	},
	
	keyListener: function(e){
		if (!e.control || !this.keys[e.key]) return;
		e.preventDefault();
		var item = this.toolbar.getItem(this.keys[e.key]);
		item.action(e);
	},
	
	editorKeyUp: function(e){
		if (this.editorDisabled){
			e.stop();
			return;
		}
		
		if (this.options.toolbar) this.checkStates();
		
		this.fireEvent('editorKeyUp', e);
	},
	
	editorKeyDown: function(e){
		if (this.editorDisabled){
			e.stop();
			return;
		}
		
		if (e.key == 'enter'){
			//this.execute('newline');
		}
		
		this.fireEvent('editorKeyDown', e);
	},
	
	focus: function(){
		// needs the delay to get focus working
		(function(){ 
			this.textarea.focus();
			this.fireEvent('focus', this);
		}).bind(this).delay(10);
		return this;
	},
	
	action: function(command, args){
		var action = A2mEditor.Actions[command];
		if (action.command && $type(action.command) == 'function'){
			action.command.run(args, this);
		} else {
			this.focus();
			this.execute(command, false, args);
			if (this.mode == 'iframe') this.checkStates();
		}
	},
	
	execute: function(command, param1, param2){
		if (this.busy) return;
		this.busy = true;
		var action = A2mEditor.Actions[command];
		if (action){
			var is_symetric=(action.options.sym) ? action.options.sym:false;	
		}else{
			var is_symetric=false;
		}
		if (is_symetric){
			this.selection.around(action.states.tags);
		}else{
			this.selection.pre(action.states.tags);
		}
		this.busy = false;
		return false;
	},
	
	checkStates: function(){
	}
 });
 
 A2mEditor.Selection=new Class({
 	initialize: function(win){
		this.win = win;
	},
	
	getSelection: function(){
		this.win.focus();
		var ttt=this.win.getSelectedText();
		//this.win.insertAtCursor("<br />");
		return ttt;
		//return this.win.getSelected();
	},
	
	getText : function(){
		var s = this.getSelection();
		return s.toString();
	},
	
	around: function(tags){
		if (!tags) return;
		
		this.win.focus();
		tags.each(function(tag){
			this.win.insertAroundCursor({before: tag, after: tag, defaultMiddle: ""});
		}.bind(this));
	},
	
	pre: function(tags){
		if (!tags) return;
		
		this.win.focus();
		tags.each(function(tag){
			this.win.insertAtCursor(tag+this.getText());
		}.bind(this));
	},
	
	newline: function(tag){
		if (!tag) return;
		//var start_pos=this.win.getSelectionStart();
		//var end_pos=this.win.getSelectionEnd();
		//this.win.setCaretPosition(start_pos);
		//this.win.insertAtCursor('\n'+tag);
		
		var before_tag=(this.win.getSelectionStart()>0) ? "\n\n"+tag : "\n"+tag
		this.win.insertAroundCursor({before: before_tag, after: "", defaultMiddle: ""}); 
	}
 });
 
 A2mEditor.UI = {};
 
 A2mEditor.UI.Toolbar = new Class({
 	
 	Implements: [Events, Options],

	options: {
		/*
		onItemAction: $empty,
		*/
		'class': ''
	},
    
	initialize: function(options){
		this.setOptions(options);
		this.el = new Element('div', {'class': 'editpanel corners corners-5 ' + this.options['class']});
		this.items = {};
		this.content = null;
		this.bar=new Element('ul',{'class':'menu-h'});
		this.bar.inject(this.el);
	},
	
	toElement: function(){
		return this.el;
	},
	
	render: function(actions){
		if (this.content){
			this.el.adopt(this.content);
		} else {
			this.content = actions.map(function(action){
				return (action == '|') ? this.addSeparator() : this.addItem(action);
			}.bind(this));
		}
		return this;
	},
	
	addItem: function(action){
		var self = this;
		var act = A2mEditor.Actions[action];
		if (!act) return;
		var type = act.type || 'button';
		var options = act.options || {};
		var item = new A2mEditor.UI[type.camelCase().capitalize()]($extend(options, {
			name: action,
			title: act.title,
			onAction: self.itemAction.bind(self)
		}));
		this.items[action] = item;
		$(item).inject(this.bar);
		return item;
	},
	
	getItem: function(action){
		return this.items[action];
	},
	
	addSeparator: function(){
		return new Element('li', {'class': 'empty', html:'&nbsp;'}).inject(this.bar);
	},
	
	itemAction: function(){
		this.fireEvent('itemAction', arguments);
	},

	disable: function(except){
		$each(this.items, function(item){
			(item.name == except) ? item.activate() : item.deactivate().disable();
		});
		return this;
	},

	enable: function(){
		$each(this.items, function(item){
			item.enable();
		});
		return this;
	},
	
	show: function(){
		this.el.setStyle('display', '');
		return this;
	},
	
	hide: function(){
		this.el.setStyle('display', 'none');
		return this;
	}
 });
 
 
 
 
 A2mEditor.UI.Button = new Class({

	Implements: [Events, Options],

	options: {
		/*
		onAction: $empty,
		*/
		title: '',
		name: '',
		text: 'Button',
		'class': '',
		shortcut: '',
		mode: 'icon'
	},

	initialize: function(options){
		this.setOptions(options);
		this.name = this.options.name;
		this.render();
	},
	
	toElement: function(){
		return this.el;
	},
	
	render: function(){
		var self = this;
		var shortcut = (this.options.shortcut) ? ' ( Ctrl+' + this.options.shortcut.toUpperCase() + ' )' : '';
		var text = this.options.title || name;
		var title = text + shortcut;
		var self_class = (this.options.selfclass) ? this.options.selfclass : '';
		this.el = new Element('li', {
			title: title,
			html:'<a class="'+self_class+'" href="#"/>',
			events: {
				click: self.click.bind(self),
				mousedown: function(e){ e.preventDefault(); }
			}
		});
		if (this.options.mode != 'icon') this.el.addClass('mooeditable-ui-button-' + this.options.mode);
		
		this.active = false;
		this.disabled = false;

		// add hover effect for IE
		if (Browser.Engine.trident) this.el.addEvents({
			mouseenter: function(e){ this.addClass('hover'); },
			mouseleave: function(e){ this.removeClass('hover'); }
		});
		
		return this;
	},
	
	click: function(e){
		e.preventDefault();
		if (this.disabled) return;
		this.action(e);
	},
	
	action: function(){
		this.fireEvent('action', [this].concat($A(arguments)));
	},
	
	enable: function(){
		if (this.active) this.el.removeClass('onActive');
		if (!this.disabled) return;
		this.disabled = false;
		this.el.removeClass('disabled').set({
			disabled: false,
			opacity: 1
		});
		return this;
	},
	
	disable: function(){
		if (this.disabled) return;
		this.disabled = true;
		this.el.addClass('disabled').set({
			disabled: true,
			opacity: 0.4
		});
		return this;
	},
	
	activate: function(){
		if (this.disabled) return;
		this.active = true;
		this.el.addClass('onActive');
		return this;
	},
	
	deactivate: function(){
		this.active = false;
		this.el.removeClass('onActive');
		return this;
	}
	
});
 
 
 Element.Properties.a2meditable = {

	set: function(options){
		return this.eliminate('a2meditable').store('a2meditable:options', options);
	},

	get: function(options){
		if (options || !this.retrieve('a2meditable')){
			if (options || !this.retrieve('a2meditable:options')) this.set('a2meditable', options);
			this.store('a2meditable', new A2mEditor(this, this.retrieve('a2meditable:options')));
		}
		return this.retrieve('a2meditable');
	}

};
 
 Element.implement({

	a2mEditable: function(options){
		return this.get('a2meditable', options);
	}

});

A2mEditor.Actions = new Hash({
 	bold: {
		title: 'Bold',
		options: {
			sym: true,
			shortcut: 'b',
			selfclass: 'strong'
		},
		states: {
			tags: ['*' , '*']
		}
	},
	
	italic: {
		title: 'Italic',
		options: {
			sym: true,
			shortcut: 'i',
			selfclass:'em'
		},
		states: {
			tags: ['_' , '_']
		}
	},
	
	underline: {
		title: 'Underline',
		options: {
			sym: true,
			shortcut: 'u',
			selfclass:'u'
		},
		states: {
			tags: ['+']
		}
	},
	
	strike: {
		title: 'Strike',
		options: {
			sym: true,
			shortcut: '-',
			selfclass:'strike'
		},
		states: {
			tags: ['-']
		}
	},
	
	sup: {
		title: 'Sup',
		options: {
			sym: true,
			shortcut: '6',
			selfclass:'sup'
		},
		states: {
			tags: ['^']
		}
	},
	
	sub: {
		title: 'Sub',
		options: {
			sym: true,
			shortcut: 'l',
			selfclass:'sub'
		},
		states: {
			tags: ['~']
		}
	},
	
 });