Element.implement({

    Implements: [Events],

    sliding_link: function(options){
        var klass='tmodul-'+this.get('class');
        this.panel=$(klass);
        this.addEvents({
            mouseover: function() {
                
                //over = true;
                this.panel.removeClass('hidden');
                this.panel.shown=true;
                $('toolbar-slider').removeClass('hidden');
            },
            mouseout: function() {
                //over = false;
                this.panel.addClass('hidden');

                $('toolbar-slider').addClass('hidden');
            }
        });
    }

})

var SliderMenu = new Class({
    Implements: [Options, Events, Chain],

    options: {
        item: null,
        duration: 3000,
        slider: 'toolbar-slider',
        onShow: $empty,
        onHide: $empty
    },

    initialize: function(options) {
        this.setOptions(options);
        this.Item = this.options.item;
        this.klass='tmodul-'+this.Item.get('class');
        this.Container = $(this.klass);
        this.Slider = $(this.options.slider);
        this.init_me();
    },

    init_me: function(){   
        if (this.options.duration) {
            this.clicks=0;
            this.hasMenu = this.Container.getChildren('li').length >0;
            this.Item.addEvent("click", function(e) {
                if (this.hasMenu){
                    if (this.Container.hasClass('hidden')){
                        this.removeAll();
                        new Event(e).stop();
                        this.show();
                    }
                }
            }.bind(this));
        }
    },

    remove: function() {
        
    },

    show: function(){
        if (this.hasMenu){
            this.Container.removeClass('hidden');
            this.Slider.removeClass('hidden');
            return this.fireEvent('onShow');
        }else{
            this.removeAll();
        }
    },

    removeAll: function(){
        this.Slider.getElements('ul').each(function(el){
            el.addClass('hidden');
        });
        this.Slider.addClass('hidden');
    }


});

window.addEvent('domready',function(){
    $$('#navigation_links .slided a').each(function(el){
        new SliderMenu({
            item:el
        });
    });
})