/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

window.addEvent('domready', function(){
    $$('li.tabitem_ajax').each(function(item){
        var container = item.getParent('div').getElement('div.tabclass');
        var link = item.getElement('a');
        link.addEvent('click',function(e){
            new Event(e).stop();
            $$('li.tabitem_ajax').each(function(titem){
                titem.removeClass('active');
            });
            item.addClass('active');
            var loader = new Element('div', {
                'class':'loader'
            });
            container.empty();
            var req = new Request({
		evalScripts: true,
                method: 'get',
                url: link.get('href'),
                onRequest: function() {
                    loader.inject(container);
                },
                onComplete: function(response) {
                    container.set('html',response);
                }
            }).send();
        });
    });
});
