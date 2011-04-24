var OrdersForms=new Class({
    initialize: function(options){
        this.options = $extend({
            getform: '',
            sendform: '',
            buyclass: 'buy'
        }, options ||
        {});

    this.BuyLinks=$$('.'+this.options.buyclass);
    this.InitActions();
    },

    InitActions:function(){
        this.BuyLinks.each(function(link){
            linkid=link.get('id');
            link.getParent().set('id','hax_'+linkid);
            link.addEvent('click',function(e){
                new Event(e).stop();
                hax({id:link.getParent().get('id'), url:this.options.getform+'/'+link.get('id'),  nohistory:1, nocache:true, method: 'post'});
            }.bind(this));
        }.bind(this));
    }
});