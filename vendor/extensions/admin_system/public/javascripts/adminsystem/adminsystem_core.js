/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
FCK_fix=function(){
    try{
        if (FCKeditorAPI){
            for (fckeditorName in FCKeditorAPI.__Instances){
                var _fck_nst=FCKeditorAPI.GetInstance(fckeditorName);
                _fck_nst.UpdateLinkedField();
            }
        }
    }
    catch(err){

    }
}

Element.implement({

    a2mAjaxebleLink: function(options){
        this.addEvent('click',function(e){
            new Event(e).stop();
            var updated_container=this.getParent('div.mochaContent');
            var updated_url=this.get('href');
            var updated_hax_id=updated_container.get('id');
            this.set('html',this.get('html')+'...');
            hax({
                url: updated_url,
                nohistory:1,
                nocache:true,
                id: updated_hax_id,
                onload: function(){ A2mAdmin.init(); }
            });
        });
    },

    a2mAjaxebleForm:function(options){
        this.addEvent('submit', function(e){
            new Event(e).stop();
            var updated_container=this.getParent('div.mochaContent');
            var updated_url=this.get('action');
            var updated_hax_id=updated_container.get('id');
            FCK_fix();
            hax({
                url: updated_url,
                nohistory:1,
                nocache:true,
                method: this.get('method'),
                form: this,
                id: updated_hax_id,
                onload: function(){ A2mAdmin.init(); }
            });
        });
    }

});

var as_instance=null;
var A2mAdmin=new Hash();

A2mAdmin.init=function(){
    if(!as_instance){
        var as_instance=new AdminSystem();
    }else{
        as_instance.InitActions();
    }
}

var AdminSystem=new Class({
    initialize: function(options){
        this.options = $extend({
        }, options ||
            {});
        this.InitDefaults();
        this.InitActions();
    },

    InitDefaults: function(){
        this.windows_default_options="headerHeight:      30,\n"+
            "footerHeight:      25,\n"+
            "closeBgColor:      [231, 70, 50],\n"+
            "closeColor:        [255, 255, 255],\n"+
            "cornerRadius:      8,"+
            "addClass:          '',"+
            "x:                 null,"+
            "y:                 null,"+
            "scrollbars:        true,"+
            "padding:           { top: 12, right: 12, bottom: 12, left: 12 },"+
            "shadowBlur:        4,"+
            "shadowOffset:      {'x': 0, 'y': 1},"+
            "controlsOffset:    {'right': 12, 'top': 9},"+
            "useCanvas:         true,"+
            "useCanvasControls: true,"+
            "useSpinner:        true";
    },

    InitActions:function(){
        this.InitLinks();
        this.InitAjaxClicks();
        this.InitForms();
    },

    InitLinks: function(){
        this.Links=$$('a.menuitem');
        if (this.Links){
            this.Links.each(function(link){
                var linkeval_text="MochaUI."+link.get('id')+"Window=function(link){"+
                    "new MochaUI.Window({"+
                    "id:'"+link.get('id')+"_window',"+
                    "loadMethod: 'fullajax',"+
                    "contentURL: '"+link.get('href')+"',"+
                    "title: '"+link.get("html")+"',"+
                    "width: window.getSize().x*0.7,"+
                    "height: window.getSize().y*0.7,"+
                    this.windows_default_options+","+
                    "onContentLoaded: function(){ A2mAdmin.init(); }"+
                    "});"+
                    "}";
                eval(linkeval_text);
                link.removeEvent('click');
                link.addEvent('click',function(e){
                    new Event(e).stop();
                    var click_eval_txt="new Event(e).stop();"+
                        "MochaUI."+link.get('id')+"Window($('"+link.get('id')+"'));";
                    eval(click_eval_txt);
                }.bind(this));

            }.bind(this));
        }
    },

    InitAjaxClicks: function(){
        this.AjaxLinks=$$('a.ajax');
        this.AjaxLinks.each(function(link){
            link.a2mAjaxebleLink();
        }.bind(this));
    },

    InitForms:function(){
        this.Forms=$$('form');
        this.Forms.each(function(element){
            element.a2mAjaxebleForm();
        }.bind(this));
    }
});

// Initialize MochaUI when the DOM is ready
window.addEvent('domready', function(){
    MochaUI.Desktop = new MochaUI.Desktop();
    MochaUI.Desktop.desktop.setStyles({
        'background': '#fff',
        'visibility': 'visible'
    });
    A2mAdmin.init();
    MochaUI.Dock = new MochaUI.Dock({
        dockPosition: 'bottom'
    });
    /*initializeWindows();*/
});