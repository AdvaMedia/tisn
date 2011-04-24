window.addEvent('domready',function(e){
	var map;
	var geocoder;
	
    /*new Fx.Accordion($$('h3.toggle'), $$('div.toggle-container'),{
      onActive:function(toggler, element){
        toggler.addClass('on');
      },
      onBackground:function(toggler, element){
        toggler.removeClass('on');
      }
    });*/

	$$('h3.toggle').each(function(el, index){
		el.toggle_wrapper = el.getNext('div.toggle-container');
			
		if (el.toggle_wrapper != undefined){
			el.toggle_wrapper.removeClass('hidden');
			if (index > 0){
				el.removeClass('on');
				el.toggle_wrapper.slide('toggle');
			}else{
				el.addClass('on');
			}
			el.addEvent('click',function(e){
				new Event(e).stop();
				el.toggle_wrapper.slide('toggle');
				el.toggleClass('on');
			});
		}
		
	})


	var links = $$('ul.tabs-office li a');
	links.addEvent('click',function(e, link){
		new Event(e).stop();
		links.each(function(l){l.getParent().removeClass('active');});
		this.getParent().addClass('active');
		tabs.addClass('hidden');
		$(this.get('id')+'-container').removeClass('hidden');
	});
	
	var tabs = $$('div#good-carousel div.container');
	var placemark;
	
	// Создание стиля для значка метки
	            var s = new YMaps.Style();
	            s.iconStyle = new YMaps.IconStyle();
	            s.iconStyle.href = "/images/location.png";
	            s.iconStyle.size = new YMaps.Point(40, 44);
	            s.iconStyle.offset = new YMaps.Point(-9, -29);	
	
	$$('a.onmap').addEvent('click',function(e){
		new Event(e).stop();
		if (this.rel != undefined){
			this.map_args=this.rel.split(':');
			$('map_modal_window').removeClass('hidden');
			
			if (map == undefined){
				map = new YMaps.Map(document.getElementById("yandex_map_container_rm"));
				map.addControl(new YMaps.Zoom())
			}
			if (placemark != undefined){
				map.removeOverlay(placemark);
			}
			geocoder = new YMaps.Geocoder(new YMaps.GeoPoint(this.map_args[0], this.map_args[1]), {results: 1});
			YMaps.Events.observe(geocoder, geocoder.Events.Load, function (geocoder){
				var tmp_y_bounds = geocoder.get(0).getGeoPoint();
				placemark = new YMaps.Placemark(tmp_y_bounds, {draggable: false, style:s});
				placemark.name="Адрес офиса";
				placemark.description = geocoder.get(0).text;
				map.setZoom(50, {smooth:true});
				map.addOverlay(placemark);
				
			    //map.setBounds(geocoder.get(0).getBounds());
				map.panTo(geocoder.get(0).getGeoPoint(), {flying: 1})
			});
			
		}
	});
	
	$$('a.cancel').addEvent('click',function(e){
		new Event(e).stop();
		this.getParent('div.modal').addClass('hidden');
	});
  });