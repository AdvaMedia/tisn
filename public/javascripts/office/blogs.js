var BlogsManager = new Class({
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
        this.InitLinks();
        this.InitForms();
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