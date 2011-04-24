/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
window.addEvent('domready', function(){

    $$('div.questions-block a').each(function(el){
        el.addEvent('click',function(e){
            new Event(e).stop();
            var toggle_div = el.getParent('div').getElement('div');
            if (toggle_div !=null){
                toggle_div.toggleClass('hidden');
            }
        });
    });

    $$('div.faq_container button.send').each(function(el){
        el.addEvent('click',function(e){
            new Event(e).stop();
            $('faq_form_send').removeClass('hidden');
        });
    });
    new FormCheck('faq_form_send',{
        display : {
            errorsLocation : 0,
            indicateErrors : 0,
            showErrors : 1,
            addClassErrorToField : 1,
            removeClassErrorOnTipClosure :1
        },
        fieldErrorClass: 'i-invalid',
        submitByAjax :true,
        ajaxEvalScripts: true,
        ajaxResponseDiv : $('faq_form_send').getParent()
    });
});

