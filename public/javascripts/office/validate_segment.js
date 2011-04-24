var companySettingsEvent = new Class({
    initialize: function(options){
        this.options = $extend({
            geteventurl:		'',
            checksegment_url:           ''
        }, options ||
        {});

        this.InitActions();
    },
    InitActions:function(){
      alert('Надо будет интегрировать проверку сегмента... пока этого нет... оставил на потом   ')  ;
    }
})