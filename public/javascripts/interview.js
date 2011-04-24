window.addEvent('domready', function(){
   var interforms = $$('form.interview-form');
   interforms.each(function(el){
       var submit_buton = el.getElements('button');
       if (submit_buton){
           submit_buton.removeClass('hidden');
       }

       var interview_selects = $$('form.interview-form input')

       interview_selects.each(function(el){
           el.addEvent('change', function(){
               submit_buton.set('disabled','');
           })
       });

       el.addEvent('submit',function(e){
           new Event(e).stop();
           var req = new Request({
                method: 'post',
                url: el.get('action'),
                onComplete: function(response) {
                    var container = el.getParent();
                    container.set('html',response);
                }
            }).post(el);
       });
   });
});