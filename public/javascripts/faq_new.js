window.addEvent('domready', function(){
	$$('dl.faq dd').each(function(el){
		el.acc_margin = {'margin-top':el.getStyle('margin-top'), 'margin-bottom': el.getStyle('margin-top') };
	});
	
	new Fx.Accordion($$('dl.faq dt'), $$('dl.faq dd'),{
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
});