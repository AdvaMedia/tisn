
window.addEvent('domready',function(){

    var blogs_roar=new Roar({
        position: 'upperRight'
    });

    $$('a.reply_ajax').each(function(link){
        var reply_container=link.getParent('li').getElement('div.recomment');
        link.a2mAjaxebleLink({
            container: reply_container,
            notreload:true,
            onPreload:function(){
                pre_reply_foo(this);
            }
        });
    });

    $$('a.need_signup').each(function(link){
        link.addEvent('click',function(e){
            new Event(e).stop();
            blogs_roar.alert("Внимание!","Чтобы ответить на пост - нужно либо войти на сайт под своим пользователем, либо зарегистрироваться");
        });
    });


    $$('a.voice').each(function(link){
        link.a2mAjaxebleLink({
            container: link.getParent(),
            notreload:true
        });
    });

    $$('a.bookmapslink').each(function(link){
        var insEl=new Element('div',{
            id: 'flykas-'+$random(200,5000)
        });
        link.a2mAjaxebleLink({
            container: insEl,
            notreload:true,
            onPreload: function(){
                var par_div=link.getParent('div.vote');
                insEl.set('id','flykas-'+$random(200,5000));
                //document.body.adopt(insEl);
                $('page').adopt(insEl);
            },
            onPostload: function(){
                insEl.move({
                    relativeTo: link.getParent().getParent().getParent(),
                    position: 'upperLeft',
                    offset: {x: -380, y: 0}
                });
                $$('a.andclose').each(function(el){
                    el.addEvent('click',function(e){
                        insEl.destroy();
                    });
                });
            }
        });

    /*
         * move({
    relativeTo: thiswindow
  });
         */
    });

    var prev_but=$('prev_button');
    if (prev_but){
        prev_but.a2mAjaxebleButton({
            appendix:'/pre',
            notreload:true,
            container: $('prev_cont'),
            method:'post',
            onPostload:function(){$('prev_cont').removeClass('hidden')}
        });
    }

    $$('button.showhelp').each(function(el){
        el.addEvent('click',function(e){
            new Event(e).stop();
            new A2M.Window();
        });
    });
});

var pre_reply_foo = function(childEl){
    var self_div=childEl.getParent().getNext();
    var self_id='';
    if (self_div){
        self_id=self_div.get('id');
    }

    $$('div.recomment').each(function(el){
        var h_id=el.get('id');
        if (h_id!=self_id){
            el.set('html','');
        }
    });
    $('add_comment_block').hide();
}