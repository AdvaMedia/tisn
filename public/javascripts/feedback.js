/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
init_feedback = function(container, link){
    var close_b = container.getElement('a');
    close_b.addEvent('click',function(e){
        new Event(e).stop();
        container.destroy();
        link.fade('in');
    });
    
    var form = container.getElement('form');
    form.set('id', 'feedbackform-'+$random(0, 10000));

    var feedbackCheck = new FormCheck(form.get('id'),{
        display : {
            errorsLocation : 0,
            indicateErrors : 0,
            showErrors : 1,
            addClassErrorToField : 1,
            removeClassErrorOnTipClosure :1
        },
        fieldErrorClass: 'i-invalid',
        submitByAjax :true,
        ajaxResponseDiv : container,
        onAjaxSuccess:function(){
            container.destroy();
            link.fade('in');
        }
    });
}

window.addEvent('domready', function(){
    $$('a.contact-us').each(function(link){
        var hr=link.get('href');
        link.set('href','#');
        link.addEvent('click',function(e){
            new Event(e).stop();
            link.fade('out');
            var req = new Request({
                method: 'post',
                url: hr,
                onComplete: function(response) {
                    var container = new Element('div',{
                        'class':'modal'
                    });
                    container.set('html',response);
                    container.injectInside($(document.body));
                    init_feedback(container, link);
                }
            }).send();
        });
    });
});

