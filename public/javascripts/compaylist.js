var as_instance=null;
var CompanyListManager=new Hash();

CompanyListManager.init=function(){
    if(!as_instance){
        var as_instance=new CompanyListPage();
    }else{
        as_instance.InitActions();
    }
}

CompanyListManager.dialogshown=function(container){
    if(!as_instance){
        var as_instance=new CompanyListPage();
    }
    as_instance.InitDialogs(container);
}

CompanyListManager.dialogclose=function(container){
    if(!as_instance){
        var as_instance=new CompanyListPage();
    }
    as_instance.CloseDialogs(container);
}

var CompanyListPage = new Class({
    initialize: function(options){
        this.options = $extend({
            }, options ||
            {});
        this.InitActions();
    },

    InitActions: function(){
        this.AjaxLinks=$$('a.ajax');
        if (this.AjaxLinks){
            this.AjaxLinks.each(function(link){
                link.a2mAjaxebleLink({
                    container:'catalog',
                    sender: 'CompanyListManager',
                    spinner:''
                });
            });
        }

        this.AjaxLI=$$('li.ajax a');
        if (this.AjaxLI){
            this.AjaxLI.each(function(link){
                link.a2mAjaxebleLink({
                    container:'catalog',
                    sender: 'CompanyListManager',
                    spinner:''
                });
            });
        }

        this.AjaxCB=$$('input.i-checkbox');
        if (this.AjaxCB){
            this.AjaxCB.each(function(cbx){
                cbx.a2mAjaxebleCheckBox({
                    container:'catalog',
                    sender: 'CompanyListManager',
                    spinner:''});
            });
        }

        this.Checkboxes = $('menucat').getElements('input.hidden');
        if (this.Checkboxes){
            this.Checkboxes.each(function(cbox){
                cbox.removeClass('hidden');
            });
        }

        this.SelectCityLink=$('select_city_link')
        if (this.SelectCityLink){
            this.SelectCityLink.a2mAjaxebleWLink({
                container:'catalog',
                spinner:''
            });
        }
    },

    InitDialogs: function(container){
        var dial_cont=$(container);
        if (dial_cont){
            dial_cont.removeClass('hidden');
            var dtable=dial_cont.getChildren('table');
            if (dtable){
                dtable.move({
                    relativeTo: $('select_city_link')
                    });
            }
            //sity_ajax
            var select_city_links=dial_cont.getElements('a.sity_ajax');
            if (select_city_links){
                select_city_links.each(function(link){
                    link.a2mAjaxebleLink({
                        container:'catalog',
                        sender: 'CompanyListManager',
                        func: 'dialogclose("place_to_window")',
                        spinner:'...<sup>выбираю город</sup>'
                    });
                });
            }
            var links=dial_cont.getElements('a.closemodal');
            if (links){
                links.each(function(link){
                    link.addEvent('click',function(e){
                        new Event(e).stop();
                        dial_cont.getChildren('table').destroy();
                    });
                });
            }
        }
    },

    CloseDialogs:function(container){
        //alert('closedialog');
        var dial_cont=$(container);
        if (dial_cont){
            dial_cont.getChildren('table').destroy();
        }
    }
});

window.addEvent('domready', function(){
    CompanyListManager.init();
});