var OfficeManager = new Class({
    initialize: function(options){
        this.options = $extend({
            }, options ||
            {});
    },

    LoadEvents:function(menu,content){
        hax({
            url: menu,
            nohistory:1,
            nocache:true,
            id: 'menu_container',
            onload:function(){this.InitActions();}.bind(this)
        });
        hax({
            url: content,
            nohistory:1,
            nocache:true,
            id: 'office',
            onload:function(){this.InitActions();}.bind(this)
        });
    },

    InitActions:function(){
        this.InitForms();
        this.InitLinks();
    },

    InitLinks:function(){
        $$('a.ajax').each(function(el){
            el.a2mAjaxebleLink({
                container:'office',
                notreload:true,
                onPostload: function(){this.InitActions();}.bind(this)
            });
        }.bind(this));

        $$('a.post_submit').each(function(el){
            el.a2mAjaxebleLink({
                container:'office',
                method:'post',
                notreload:true,
                onPostload: function(){this.InitActions();}.bind(this)
            });
        }.bind(this));

        this.SubmitButtons=$$('button.press_submit');
        if (this.SubmitButtons){
            this.SubmitButtons.each(function(button){
                button.removeEvent('click');
                button.addEvent('click',function(e){
                    if (button.get('id')=='submit_draft'){
                        //validations = []
                        $('item_visible').set('value','0');
                        $$('form.post_ajax').each(function(f){
                            f.validd.validations = []
                        });
                        //this.SimpleChecker.validations = []

                    }else{
                        $('item_visible').set('value','1');
                        //this.SimpleChecker.reinitialize('forced');
                        $$('form.post_ajax').each(function(f){
                            f.validd.reinitialize('forced');
                        });
                    }
                }.bind(this));
            }.bind(this));
        }

        $$('a.dub').each(function(el){
            el.dublicatable({
                cloneup:true,
                onDublicate:function(){this.InitLinks();}.bind(this)
            });
        }.bind(this));
    },

    InitForms:function(){
        $$('form.post_ajax').each(function(f){
            f.a2mAjaxebleVForm({
                container:'office',
                notreload:false,
                onPostload: function(){this.InitActions();}.bind(this)
            });
        }.bind(this));
    }

});