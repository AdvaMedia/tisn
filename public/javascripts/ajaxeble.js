Element.implement({

    Implements: [Events],

    a2mAjaxebleLink: function(options){
        if (!this.ajaxeble){
            this.ajaxeble=true;
            this.prelink=this.get('href');
            this.set('href','#');
            this.addEvents({
                onPreload: options.onPreload||$empty,
                onPostload: options.onPostload||$empty
            });
            this.removeEvent('click');
            this.addEvent('click',function(e){
                this.fireEvent('onPreload');
                new Event(e).stop();
                var updated_container=$(options.container);
                var updated_url=this.prelink;
                var updated_hax_id=updated_container.get('id');
                var method="get";
                if (options.method){
                    method=options.method;
                }
                if (options.spinner){
                    this.set('html',this.get('html')+options.spinner);
                }
                hax({
                    url: updated_url,
                    nohistory:1,
                    nocache:true,
                    id: updated_hax_id,
                    method: method,
                    onload: function(){
                        this.fireEvent('onPostload');
                        if (options.notreload){
                        }
                        else{
                            if (options.func){
                                eval(options.sender+"."+options.func);
                            }else{
                                eval(options.sender+".init();");
                            }
                        }
                    }.bind(this)
                });
            });
        }
    },

    a2mAjaxebleWLink: function(options){
        if (!this.ajaxeble){
            this.ajaxeble=true;
            this.prelink=this.get('href');
            this.set('href','#');
            this.addEvents({
                onPreload: options.onPreload||$empty,
                onPostload: options.onPostload||$empty
            });
            this.removeEvent('click');
            this.addEvent('click',function(e){
                this.fireEvent('onPreload');
                new Event(e).stop();
                var updated_container=$(options.container);
                var updated_url=this.prelink;
                var updated_hax_id=updated_container.get('id');
                var method="get";
                if (options.method){
                    method=options.method;
                }
                if (options.spinner){
                    this.set('html',this.get('html')+options.spinner);
                }
                new A2M.Window({
                    title:'Выбор города',
                    url:updated_url
                });
            });
        }
    },

    a2mAjaxebleForm:function(options){
        this.addEvent('submit', function(e){
            new Event(e).stop();
            var updated_container=$(options.container);
            var updated_url=this.get('action');
            var updated_hax_id=updated_container.get('id');
            hax({
                url: updated_url,
                nohistory:1,
                nocache:true,
                method: this.get('method'),
                form: this,
                id: updated_hax_id,
                onload: function(){
                    if (options.notreload){
                    }
                    else{
                        if (options.func){
                            eval(options.sender+"."+options.func);
                        }else{
                            eval(options.sender+".init();");
                        }
                    }
                }.bind(this)
            });
        });
    },

    a2mAjaxebleVForm:function(options){
        var updated_container=$(options.container);
        var updated_url=this.get('action');
        var updated_hax_id=updated_container.get('id');
        this.addEvents({
            onPreload: options.onPreload||$empty,
            onPostload: options.onPostload||$empty
        });
        this.validd=new FormCheck(this,{
            submitByAjax:true,
            ajaxResponseDiv:updated_hax_id,
            ajaxEvalScripts:true,
            onAjaxSuccess:function(){
                this.fireEvent('onPostload');
            }.bind(this)
        });
    },

    a2mAjaxebleCheckBox :function(options){
        if (!this.ajaxeble){
            this.ajaxeble=true;
            this.removeEvent('click');
            this.addEvent('click',function(e){
                //new Event(e).stop();
                var updated_container=$(options.container);
                var updated_url=this.getNext('input').get('value');
                var updated_hax_id=updated_container.get('id');
                if (options.spinner){
                    this.set('html',this.get('html')+options.spinner);
                }
                hax({
                    url: updated_url,
                    nohistory:1,
                    nocache:true,
                    id: updated_hax_id,
                    onload: function(){
                        if (options.func){
                            eval(options.sender+"."+options.func);
                        }else{
                            eval(options.sender+".init();");
                        }
                    }
                });
            });
        }
    },

    a2mAjaxebleButton :function(options){
        if (!this.ajaxeble){
            this.ajaxeble=true;
            this.preform=this.getParent('form');
            this.prelink="#";
            this.appendix=options.appendix||'';
            if (this.preform){
                this.prelink=this.preform.get('action')+this.appendix;
            }
            this.addEvents({
                onPreload: options.onPreload||$empty,
                onPostload: options.onPostload||$empty
            });
            this.removeEvent('click');
            this.addEvent('click',function(e){
                this.fireEvent('onPreload');
                new Event(e).stop();
                var updated_container=$(options.container);
                var updated_url=this.prelink;
                var updated_hax_id=updated_container.get('id');
                var method="get";
                if (options.method){
                    method=options.method;
                }
                if (options.spinner){
                    this.set('html',this.get('html')+options.spinner);
                }
                hax({
                    url: updated_url,
                    nohistory:1,
                    nocache:true,
                    id: updated_hax_id,
                    method: method,
                    form: this.preform,
                    onload: function(){
                        this.fireEvent('onPostload');
                        if (options.notreload){
                        }
                        else{
                            if (options.func){
                                eval(options.sender+"."+options.func);
                            }else{
                                eval(options.sender+".init();");
                            }
                        }
                    }.bind(this)
                });
                return false;
            });
        }
    },

    dublicatable:function(options){
        this.addEvent('click',function(e){
            new Event(e).stop();
            this.addEvents({
                onDublicate: options.onDublicate||$empty
            });
            var parent_cont=null;
            var dub_element = null;
            //При нажатии на этот элемент будет дублироваться весь контейнер, в который включен данных элемента
            if (options.cloneup){
                parent_cont=this.getPrevious();
            }else{
                parent_cont=this.getParent();
            }
            if (parent_cont){
                var dub_element = parent_cont.clone();
                if (options.cloneup){
                    dub_element.set('value','');
                }else{
                    dub_element.getChildren().each(function(el){
                        el.set('value','');
                    });
                }
                dub_element.inject(parent_cont,'after');
                this.removeEvents('click');
                this.fireEvent('onDublicate');
            }
        });
    }

});