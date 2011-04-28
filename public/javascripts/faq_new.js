window.addEvent('domready', function(){
	$$('dl.faq dd').each(function(el){
		el.acc_margin = {'margin-top':el.getStyle('margin-top'), 'margin-bottom': el.getStyle('margin-top') };
		el.set('morph', {duration: 'short'});
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
	
	var search_input = $('question_title');
	if (search_input != undefined){
		new OverText(search_input, {textOverride:'Введите сюда Ваш вопрос'});
		search_input.addEvent('keyup',function(e){
			if (e.target.get('value') != ''){
				if (e.target.get('value').length > 3){
				var myHTMLRequest = new Request.HTML({url:'railsbike/faq/live_search', onSuccess:function(responseTree, responseElements, responseHTML, responseJavaScript){
					publish_search_results($('faq_search_result'), responseHTML);
				}}).post('q='+e.target.get('value'));
			}else{
				publish_search_results($('faq_search_result'), "<h1>Результаты поиска:</h1><span>По Вашему запросу ничего не найдено!</span>");
			}
			}
		});
	}
	
	$$('input.search_helper').each(function(el){
		el.getNext('fieldset').fade('out');
		el.addEvent('click',function(e){
			new Event(e).stop();
			el.getNext('fieldset').removeClass('hidden').fade('in');
			show_tooltip(el);
		});
	});
	
	new MGFX.Tabs('.tab','.tab-container',{
					autoplay: false,
					transitionDuration:500,
					hover:false
				});
				
});

var publish_search_results = function(container, data){
	container.set('html',data);
	new Fx.Accordion($$('dl.faq_more dt'), $$('dl.faq_more dd'),{
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
	});
}

var show_tooltip = function(sender){
	if (sender.overtext == undefined){
		if ($('question_content') != undefined){new OverText($('question_content'),{textOverride:'Уточните вопрос'});}
		if ($('question_name') != undefined){new OverText($('question_name'),{textOverride:'Ваше имя'});}
		sender.overtext = true;
	}
	sender.getNext('fieldset').getElements('a.cancel').each(function(el){
		el.addEvent('click',function(e){
			new Event(e).stop();
			sender.getNext('fieldset').fade('out').addClass('hidden');
		})
	});
}