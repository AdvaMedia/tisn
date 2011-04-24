/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
init_phones = function(container){
    var close_b = container.getElement('a');
    close_b.addEvent('click',function(e){
        new Event(e).stop();
        container.addClass('hidden');
    });
}

window.addEvent('domready', function(){
    var phones_window = $('all_phones');
    $$('div.phones a.pseudo').each(function(link){
        var hr=link.get('href');
        link.set('href','#');
        link.addEvent('click',function(e){
            new Event(e).stop();
            if (phones_window!=null){
                phones_window.removeClass('hidden');
                init_phones(phones_window);
            }
        });
    });
});

