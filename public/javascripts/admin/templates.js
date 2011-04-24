var TemplatesManager=new Class({
    initialize: function(options){
        this.options = $extend({
            wrapper_id:'admin_template_wrapper',
            window_id:'admin_templates_window_content'
        }, options ||
        {});
        this.Wrapper=this.options.wrapper_id;
        this.Container=this.options.window_id
        this.ReInit();
    },

    ReInit:function(){
        this.InitLinks();
        this.InitForms();
    },

    InitLinks:function(){
        this.Links=$(this.Container).getElements('a');
        this.Links.each(function(element){
            //Для всех ссылок...
            element.addEvent('click',function(e){
                new Event(e).stop();
                hax({id:this.Container, url:element.get('href'),  nohistory:1, nocache:true, method: 'get', onload:this.ReInit.bind(this)});
            }.bind(this));
        }.bind(this));
    },

    InitForms:function(){
        this.Forms=$(this.Container).getElements('form');
        this.Forms.each(function(element){
            //Для всех форм
            new FormCheck(element,{submit:false});
            element.addEvent('submit',function(e){
                new Event(e).stop();
                hax({id:this.Container, url:element.get('action'),  nohistory:1, nocache:true, method: 'post', form:element, onload:this.ReInit.bind(this)});
            }.bind(this));
        }.bind(this));
    }
});

var templatesManager=null;
window.addEvent('domready',function(){
    templatesManager=new TemplatesManager();
});