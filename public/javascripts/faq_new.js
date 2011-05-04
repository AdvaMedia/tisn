var last_sort_method = true;
var waiter_search;
var faq_more_last_url;
window.addEvent('domready', function(){
	waiter_search = new Waiter($('faq_search_result'));
	$$('dl.faq dd').each(function(el){
		el.acc_margin = {'margin-top':el.getStyle('margin-top'), 'margin-bottom': el.getStyle('margin-top') };
		el.set('morph', {duration: 'short'});
	});
	
	$$('form').each(function(frm){
		frm.getElements('fieldset[class!="hidden"] input[type="text"]').combine(frm.getElements('fieldset[class!="hidden"] textarea')).each(function(inp){
			set_over_text_for_item(inp, null);
		});
	});
	
	init_top_toggler($$('dl.faq_top dt'), $$('dl.faq_top dd'));
	
	
	$$('form').each(function(frm, index){
		frm.set('id', 'validate_form_'+index);
		init_forms(frm, frm.getElement('div.success_cont'));
	});
	
	var search_input = $('question_title');
	if (search_input != undefined){
		var storred_data = $('faq_search_result').get('html');
		set_over_text_for_item(search_input, "overtext for-to-ask");
		new Observer(search_input, function(){
			if (search_input.get('value') != ''){
				if (search_input.get('value').length > 0){
					faq_more_last_url='/railsbike/faq/live_search?q='+search_input.get('value');
					var myHTMLRequest = new Request.HTML({
						url:'/railsbike/faq/live_search',
						onRequest: function(){
						        waiter_search.start();
					    },
					    onFailure: function(responseText){
						        waiter_search.stop();
					    },
						onSuccess:function(responseTree, responseElements, responseHTML, responseJavaScript){
							waiter_search.stop();
							publish_search_results($('faq_search_result'), responseHTML);
					}}).post('q='+search_input.get('value'));
			}else{
				//publish_search_results($('faq_search_result'), storred_data);
				console.debug('test');
			}
		}}, {delay:500});			
	}
	
	$$('input.search_helper').each(function(el){
		el.getNext('fieldset').fade('out');
		el.addEvent('click',function(e){
			new Event(e).stop();
			el.getNext('fieldset').removeClass('hidden').fade('in');
			el.getParent('div').getNext('div.success_cont').addClass('hidden');
			show_tooltip(el);
			frm = el.getParent('form');
			frm.getElements('input[type="text"]').combine(frm.getElements('textarea')).each(function(inp){
				if (inp.get('id') != 'question_title'){
					set_over_text_for_item(inp, null);
				}
			});
		});
	});
	
	new MGFX.Tabs('.tab','.tab-container',{
					autoplay: false,
					transitionDuration:500,
					hover:false
	});
	make_sort_buttons();
	faq_sort(last_sort_method);
});

var init_top_toggler = function(togglers, containers){
	togglers.each(function(el, index){
		containers[index].removeClass('hidden');
		el.fx = new Fx.Slide(containers[index], {resetHeight:true}).hide();
		el.fx.wrapper.morph({'margin-top':0, 'margin-bottom': 0 });
		el.addEvent('click',function(e){
			el.fx.toggle();
			if (el.fx.open){
				el.fx.wrapper.morph({'margin-top':0, 'margin-bottom': 0 });
				el.fx.wrapper.fade('out');
				el.removeClass('on');
			}else{
				el.fx.wrapper.morph(el.fx.element.acc_margin);
				el.fx.wrapper.fade('in');
				el.addClass('on');
			}
		});
	});
	/*new Fx.Accordion(togglers, containers,{
		onActive:function(toggler, element){
			toggler.addClass('on');
			element.morph(element.acc_margin);
		},
		onBackground:function(toggler, element){
			toggler.removeClass('on');
			element.morph({'margin-top':0, 'margin-bottom': 0 });
		}
	}).elements.each(function(el){
		el.removeClass('hidden');
	});*/
}

var init_show_more = function(){
	//init paginate links
	var paginate_arr = $$('ul.pagination li a');
	if (paginate_arr.length > 0){
		faq_more_last_url = $$('ul.pagination li.active a')[0].get('href');
		paginate_arr.each(function(link, index){
			link.removeEvent('click');
			link.addEvent('click',function(e){
				new Event(e).stop();
				faq_more_last_url = link.get('href');
				link.set('href','#');
				var myHTMLRequest = new Request.HTML({
					url:faq_more_last_url,
					onRequest: function(){
							//new Element('div').set('id', 'faq_search_result_more').replaces($('show_more_link').getParent('ul'));
					        waiter_search.start();
				    },
				    onFailure: function(responseText){
					        waiter_search.stop();
				    },
					onSuccess:function(responseTree, responseElements, responseHTML, responseJavaScript){
						waiter_search.stop();
						publish_search_results($('faq_search_result'), responseHTML);
					}
				}).post('&page='+link.get('html'));
			});
		});
	}else{
		if (faq_more_last_url == undefined && $('show_more_link_hidden') != undefined){
			faq_more_last_url = $('show_more_link_hidden').get('value');
		}
	}
	
	/*if ($('show_more_link') != undefined){
		if (faq_more_last_url == undefined){
		faq_more_last_url = $$('ul.pagination li.active a').first.get('href');
		}
		$('show_more_link').removeEvent('click');
		$('show_more_link').addEvent('click',function(e){
			new Event(e).stop();
			faq_more_last_url = $('show_more_link').get('href');
			$('show_more_link').set('href',"#");
			var myHTMLRequest = new Request.HTML({
				url:faq_more_last_url,
				onRequest: function(){
						//new Element('div').set('id', 'faq_search_result_more').replaces($('show_more_link').getParent('ul'));
				        waiter_search.start();
			    },
			    onFailure: function(responseText){
				        waiter_search.stop();
			    },
				onSuccess:function(responseTree, responseElements, responseHTML, responseJavaScript){
					waiter_search.stop();
					publish_search_results($('faq_search_result'), responseHTML);
				}
			}).post('order=position');
		});
	}*/
}

var make_sort_buttons = function(){
	
}

var faq_sort = function(forward){
	/*last_sort_method = forward;
	var sorterFx = new Fx.Sort($$('dl.user-questions'), {
	  duration: 1000
	});
	if (forward){
		sorterFx.forward();
	}else{
		sorterFx.backward();	
	}*/
	init_show_more();
	$$('p.sort-list a.pseudo').each(function(item, index){
		item.removeEvent('click');
		item.addEvent('click',function(e){
			new Event(e).stop();
			var last_page = 1
			if ($$('ul.pagination li.active a').length > 0){
				last_page = $$('ul.pagination li.active a')[0].get('html');
			}
			$$('p.sort-list a.pseudo').each(function(el){el.removeClass('active')});
			item.addClass('active');
			var myHTMLRequest = new Request.HTML({
				url:faq_more_last_url,
				onRequest: function(){
						//new Element('div').set('id', 'faq_search_result_more').replaces($('show_more_link').getParent('ul'));
				        waiter_search.start();
			    },
			    onFailure: function(responseText){
				        waiter_search.stop();
			    },
				onSuccess:function(responseTree, responseElements, responseHTML, responseJavaScript){
					waiter_search.stop();
					publish_search_results($('faq_search_result'), responseHTML);
				}}).post('order='+item.get('href').replace('#','')+'&skip_search=true'+'&page='+last_page);
		});
	});
	
	$$('a.vote-up').each(function(link){
		if (!link.hasClass('on')){
			link.vote_link = link.get('href');
			link.set('href', "#");
			link.addEvent('click',function(e){
				new Event(e).stop();
				var myHTMLRequest = new Request.HTML({
					url:this.vote_link,
					onSuccess:function(responseTree, responseElements, responseHTML, responseJavaScript){
						this.getParent('div').set('html', responseHTML);
					}.bind(this)
				}).post();
			}.bind(link));
		}
	});
}

var set_over_text_for_item = function(item, overclass){
	if (overclass == null){
		overclass = 'overtext';
	}
	var iov = item.get('value');
	item.set('value','');
	new OverText(item,{textOverride:iov, labelClass:overclass, element:'span'}).text.set('style', '').set('class', overclass);
}

var publish_search_results = function(container, data){
	container.set('html',data);
	/*new Fx.Accordion($$('dl.faq_more dt'), $$('dl.faq_more dd'),{
		onActive:function(toggler, element){
			toggler.addClass('on');
			element.morph(element.acc_margin);
		},
		onBackground:function(toggler, element){
			toggler.removeClass('on');
			element.morph({'margin-top':0, 'margin-bottom': 0 });
		},
		display:-1
	}).elements.each(function(el){
		el.removeClass('hidden');
	});*/
	make_sort_buttons();
	faq_sort(last_sort_method);
}

var show_tooltip = function(sender){
	sender.getNext('fieldset').getElements('a.cancel').each(function(el){
		el.addEvent('click',function(e){
			new Event(e).stop();
			sender.getNext('fieldset').fade('out').addClass('hidden');
		})
	});
}

var init_forms = function(form, result_element){
	new FormCheck(form,{
        display : {
            errorsLocation : 0,
            indicateErrors : 0,
            showErrors : 1,
            addClassErrorToField : 1,
            removeClassErrorOnTipClosure :1
        },
		form_id: form.get('id'),
		submit:false,
        fieldErrorClass: 'i-invalid',
		onValidateSuccess:function(){
			faq_more_last_url = this.form.get('action');
			var myJSONRemote = new Request.JSON({
				url:faq_more_last_url,
				onSuccess:function(responseJSON, responseText){
					if (responseJSON.errors.length == 0){
						result_element.removeClass('hidden');
						result_element.getParent('form').getElement('fieldset').addClass('hidden');
						result_element.getParent('form').getElements('input[type="text"]').combine(result_element.getParent('form').getElements('textarea')).each(function(el){
							el.set('value', '');
						});
					}
				}
			}).post(form);
		}
    });
}