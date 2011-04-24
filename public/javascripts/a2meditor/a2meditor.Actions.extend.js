/*
Script: MooEditable.Extras.js
	Extends MooEditable to include more (simple) toolbar buttons.

License:
	MIT-style license.
*/

A2mEditor.Actions.extend({

	formatBlock: {
		title: 'Block Formatting',
		type: 'menu-list',
		options: {
			list: [
				{text: 'Заголовок', 'class': 'header'},
				{text: 'Heading 1', value: 'h4. ', 'class': 'h4 icon'},
				{text: 'Heading 2', value: 'h5. ', 'class': 'h5 icon'},
				{text: 'Heading 3', value: 'h6. ', 'class': 'h6 icon'}
			]
		},
		states: {
			tags: ['p', 'h1', 'h2', 'h3']
		},
		command: function(menulist, name){
			if (!name) return;
			this.selection.newline(name);
			this.focus();
		}
	},
	
	listingBlock:{
		title: 'LI OL elements',
		type: 'menu-list',
		options: {
			list: [
				{text: 'Список', 'class': 'header'},
				{text: 'Ненумерованный', 'class': 'ul icon', value: '# '},
				{text: 'Нумерованный', 'class': 'ol icon', value: '* '},
			]
		},
		states: {
			
		},
		command: function(menulist, name){
			if (!name) return;
			this.selection.newline(name);
			//this.selection.around(name);
			this.focus();
		}
	}

});
