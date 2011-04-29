var last_sort_method = true;
window.addEvent('domready', function(){
	
	$$('dl.faq dd').each(function(el){
		el.acc_margin = {'margin-top':el.getStyle('margin-top'), 'margin-bottom': el.getStyle('margin-top') };
		el.set('morph', {duration: 'short'});
	});
	
	$$('form').each(function(frm){
		frm.getElements('fieldset[class!="hidden"] input[type="text"]').combine(frm.getElements('fieldset[class!="hidden"] textarea')).each(function(inp){
			set_over_text_for_item(inp, null);
		});
	});
	
	new Fx.Accordion($$('dl.faq_top dt'), $$('dl.faq_top dd'),{
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
	});
	
	$$('form').each(function(frm, index){
		frm.set('id', 'validate_form_'+index);
		init_forms(frm, frm.getElement('div.success_cont'));
	});
	
	var waiter_search = new Waiter($('faq_search_result'));
	
	var search_input = $('question_title');
	if (search_input != undefined){
		set_over_text_for_item(search_input, "overtext for-to-ask");
		new Observer(search_input, function(){
			if (search_input.get('value') != ''){
				if (search_input.get('value').length > 3){
				var myHTMLRequest = new Request.HTML({
					url:'railsbike/faq/live_search',
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
				publish_search_results($('faq_search_result'), "<h1>Результаты поиска:</h1><span>По Вашему запросу ничего не найдено!</span>");
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

var make_sort_buttons = function(){
	$$('p.sort-list a.pseudo').each(function(item, index){
		item.removeEvent('click');
		item.addEvent('click',function(e){
			new Event(e).stop();
			faq_sort(index == 0);
			$$('p.sort-list a.pseudo').each(function(el){el.removeClass('active')});
			item.addClass('active');
		});
	});
}

var faq_sort = function(forward){
	last_sort_method = forward;
	var sorterFx = new Fx.Sort($$('dl.user-questions'), {
	  duration: 1000
	});
	if (forward){
		sorterFx.forward();
	}else{
		sorterFx.backward();	
	}	
}

var set_over_text_for_item = function(item, overclass){
	if (overclass == null){
		overclass = 'overtext';
	}
	var iov = item.get('value');
	item.set('value','');
	console.debug([item, overclass]);
	new OverText(item,{textOverride:iov, labelClass:overclass, element:'span'}).text.set('class', overclass);
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
			var myJSONRemote = new Request.JSON({
				url:this.form.get('action'),
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