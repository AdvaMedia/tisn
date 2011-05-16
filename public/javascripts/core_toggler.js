var init_top_toggler = function(togglers, containers){
	togglers.each(function(el, index){
		containers[index].removeClass('hidden');
		el.fx = new Fx.Slide(containers[index], {resetHeight:true}).hide();
		el.fx.wrapper.morph({'margin-top':0, 'margin-bottom': 0 });
		el.addEvent('click',function(e){
			el.fx.toggle();
			if (el.fx.open){
				close_toggler_init(el);
			}else{
				open_toggler_init(el);
				
			}
		});
		if (index == 0){el.fx.toggle(); open_toggler_init(el);}
	});
}

var open_toggler_init = function(el){
	el.fx.wrapper.morph(el.fx.element.acc_margin);
	el.fx.wrapper.fade('in');
	el.addClass('on');
}

var close_toggler_init = function(el){
	el.fx.wrapper.morph({'margin-top':0, 'margin-bottom': 0 });
	el.fx.wrapper.fade('out');
	el.removeClass('on');
}

window.addEvent('domready',function(e){
	init_top_toggler($$('div.specials h3.toggle'), $$('div.specials div.toggle-container'));
});