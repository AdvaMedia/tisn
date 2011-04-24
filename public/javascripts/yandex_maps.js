window.addEvent("domready",function(){
	$('clear_yandex_pams').addEvent('click', function(e){
			var lng = $('map_address_lng');
			var lat = $('map_address_lat');
			var res = 0;
			if (lng != undefined){lng.set('value', '0.0'); res++;}
			if (lat != undefined){lat.set('value', '0.0'); res++;}
			var yandex_map_cont = $('yandex_map_container');
			if ( yandex_map_cont  != undefined){yandex_map_cont.addClass('hidden'); res++;}
			if (res <3 ){alert('Не удалось полностью удалить данные карты.');}
			else{alert('Данные адреса полностью удалены с карты. Не забудьте сохранить изменения');}
		});
		
	$('show_yandex_pams').addEvent('click',function(){
		var yandex_map_cont = $('yandex_map_container');
		yandex_map_cont.toggleClass('hidden');
		var adress = "";
		var tmp_y_bounds;
		var lng = $('map_address_lng').get('value');
		var lat = $('map_address_lat').get('value');
		var map = new YMaps.Map(document.getElementById("yandex_map_container"));
		if (!yandex_map_cont.hasClass('hidden')){
			var geocoder;
			if (lng == 0 || lat == 0){
				adress = $("map_address_city").value + ", " +$("map_address_street").value + ", " +$("map_address_house").value;
				geocoder = new YMaps.Geocoder(adress, { prefLang : "ru" } );
			}else{
				geocoder = new YMaps.Geocoder(new YMaps.GeoPoint(lng, lat), {results: 1});
			}
			
			YMaps.Events.observe(geocoder, geocoder.Events.Load, function (geocoder) {
				tmp_y_bounds = geocoder.get(0).getGeoPoint();
				$('map_address_lng').set('value', tmp_y_bounds.getLng());
				$('map_address_lat').set('value', tmp_y_bounds.getLat());
				var placemark = new YMaps.Placemark(tmp_y_bounds, {draggable: true});
				console.debug(geocoder.get(0));
				placemark.name="Адрес офиса";
				placemark.description = geocoder.get(0).text;
				map.addOverlay(placemark);
				
			    map.setBounds(geocoder.get(0).getBounds());
				map.setZoom(100, {smooth:true});
				
				YMaps.Events.observe(placemark, placemark.Events.DragEnd, function (obj) {
				    // Стирает содержимое метки и обнуляет расстояние
				    obj.setIconContent(null);
				    obj.update();
					tmp_y_bounds = obj.getGeoPoint();
					var m_geocoder = new YMaps.Geocoder(obj.getGeoPoint(), {results: 1});
					console.debug(geocoder);
					YMaps.Events.observe(m_geocoder, m_geocoder.Events.Load, function (m_geocoder){
						placemark.name="Адрес офиса";
						placemark.description = m_geocoder.get(0).text;
					});
					$('map_address_lng').set('value', tmp_y_bounds.getLng());
					$('map_address_lat').set('value', tmp_y_bounds.getLat());
				});
			});
			
			
		}
	});
});