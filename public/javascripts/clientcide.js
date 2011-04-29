/**
 * Observer - Observe formelements for changes
 *
 * - Additional code from clientside.cnet.com
 *
 * @version		1.1
 *
 * @license		MIT-style license
 * @author		Harald Kirschner <mail [at] digitarald.de>
 * @copyright	Author
 */
var Observer = new Class({

	Implements: [Options, Events],

	options: {
		periodical: false,
		delay: 1000
	},

	initialize: function(el, onFired, options){
		this.element = $(el) || $$(el);
		this.addEvent('onFired', onFired);
		this.setOptions(options);
		this.bound = this.changed.bind(this);
		this.resume();
	},

	changed: function() {
		var value = this.element.get('value');
		if ($equals(this.value, value)) return;
		this.clear();
		this.value = value;
		this.timeout = this.onFired.delay(this.options.delay, this);
	},

	setValue: function(value) {
		this.value = value;
		this.element.set('value', value);
		return this.clear();
	},

	onFired: function() {
		this.fireEvent('onFired', [this.value, this.element]);
	},

	clear: function() {
		$clear(this.timeout || null);
		return this;
	},

	pause: function(){
		if (this.timer) $clear(this.timer);
		else this.element.removeEvent('keyup', this.bound);
		return this.clear();
	},

	resume: function(){
		this.value = this.element.get('value');
		if (this.options.periodical) this.timer = this.changed.periodical(this.options.periodical, this);
		else this.element.addEvent('keyup', this.bound);
		return this;
	}

});

var $equals = function(obj1, obj2) {
	return (obj1 == obj2 || JSON.encode(obj1) == JSON.encode(obj2));
};

/* Clientcide Copyright (c) 2006-2009, http://www.clientcide.com/wiki/cnet-libraries#license*/

//Contents: Clientcide, Waiter.Compat

//This lib: http://www.clientcide.com/js/build.php?excludeLibs[]=mootools-core&excludeLibs[]=mootools-more&require[]=Clientcide&require[]=Waiter.Compat&compression=jsmin


var Clientcide={version:'%build%',assetLocation:"http://github.com/anutron/clientcide/raw/master/Assets",setAssetLocation:function(baseHref){Clientcide.assetLocation=baseHref;if(Clientcide.preloaded)Clientcide.preLoadCss();},preLoadCss:function(){if(window.StickyWin&&StickyWin.ui)StickyWin.ui();if(window.StickyWin&&StickyWin.pointy)StickyWin.pointy();Clientcide.preloaded=true;return true;},preloaded:false};(function(){if(!window.addEvent)return;var preload=function(){if(window.dbug)dbug.log('preloading clientcide css');if(!Clientcide.preloaded)Clientcide.preLoadCss();};window.addEvent('domready',preload);window.addEvent('load',preload);})();setCNETAssetBaseHref=Clientcide.setAssetLocation;
var Waiter=new Class({Extends:Spinner,options:{baseHref:'http://www.cnet.com/html/rb/assets/global/waiter/',containerProps:{styles:{position:'absolute','text-align':'center'},'class':'waiterContainer'},containerPosition:{},msg:false,msgProps:{styles:{'text-align':'center',fontWeight:'bold'},'class':'waiterMsg'},img:{src:'waiter.gif',styles:{width:24,height:24},'class':'waiterImg'},layer:{styles:{width:0,height:0,position:'absolute',zIndex:999,display:'none',opacity:0.9,background:'#fff'},'class':'waitingDiv'},useIframeShim:true,fxOptions:{},injectWhere:null},render:function(){this.parent();this.waiterContainer=this.element.set(this.options.containerProps);if(this.msgContainer)this.msgContainer=this.content.set(this.options.msgProps);if(this.options.img)this.waiterImg=document.id(this.options.img.id)||new Element('img',$merge(this.options.img,{src:this.options.baseHref+this.options.img.src})).inject(this.img);this.element.set(this.options.layer);},place:function(){this.inject.apply(this,arguments);},reset:function(){return this.hide();},start:function(element){return this.show();},stop:function(callback){return this.hide();}});if(window.Request){Request=Class.refactor(Request,{options:{useWaiter:false,waiterOptions:{},waiterTarget:false},initialize:function(options){if(options){if(options.useWaiter)options.useSpinner=options.useWaiter;if(options.waiterOptions)options.spinnerOptions=options.waiterOptions;if(options.waiterTarget)options.spinnerTarget=options.waiterTarget;}
this.previous(options);}});}
Element.Properties.waiter={set:function(options){return this.set('spinner',options);},get:function(options){return this.get('spinner',options);}};Element.implement({wait:function(options){return this.spin(options);},release:function(){return this.unspin(options);}});