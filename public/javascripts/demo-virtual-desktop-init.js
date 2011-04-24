initializeWindows = function(){

    //Модули {управление городами}
    MochaUI.navigationWindow=function(link){
        new MochaUI.Window({
            id:"admin_navigation_window",
            loadMethod: 'fullajax',
            contentURL: link.get("href"),
            title:link.get("html"),
            width: window.getSize().x*0.7,
            height: window.getSize().y*0.7
        });
    }
    if ($('admin_navigation_link')){
        $('admin_navigation_link').addEvent('click', function(e){
            new Event(e).stop();
            MochaUI.navigationWindow($('admin_navigation_link'));
        });
    }

    MochaUI.templatesWindow=function(link){
        new MochaUI.Window({
            id:"admin_templates_window",
            loadMethod: 'fullajax',
            contentURL: link.get("href"),
            title:link.get("html"),
            width: window.getSize().x*0.7,
            height: window.getSize().y*0.7
        });
    }
    if ($('admin_templates_link')){
        $('admin_templates_link').addEvent('click', function(e){
            new Event(e).stop();
            MochaUI.templatesWindow($('admin_templates_link'));
        });
    }

    MochaUI.pagepartsWindow=function(link){
        new MochaUI.Window({
            id:"admin_pageparts_window",
            loadMethod: 'fullajax',
            contentURL: link.get("href"),
            title:link.get("html"),
            width: window.getSize().x*0.7,
            height: window.getSize().y*0.7
        });
    }
    if ($('admin_pageparts_link')){
        $('admin_pageparts_link').addEvent('click', function(e){
            new Event(e).stop();
            MochaUI.pagepartsWindow($('admin_pageparts_link'));
        });
    }

    MochaUI.htmlWindow=function(link){
        new MochaUI.Window({
            id:"admin_html_window",
            loadMethod: 'fullajax',
            contentURL: link.get("href"),
            title:link.get("html"),
            width: window.getSize().x*0.7,
            height: window.getSize().y*0.7
        });
    }
    if ($('admin_html_link')){
        $('admin_html_link').addEvent('click', function(e){
            new Event(e).stop();
            MochaUI.htmlWindow($('admin_html_link'));
        });
    }

    MochaUI.newsWindow=function(link){
        new MochaUI.Window({
            id:"admin_news_window",
            loadMethod: 'fullajax',
            contentURL: link.get("href"),
            title:link.get("html"),
            width: window.getSize().x*0.7,
            height: window.getSize().y*0.7
        });
    }
    if ($('admin_news_link')){
        $('admin_news_link').addEvent('click', function(e){
            new Event(e).stop();
            MochaUI.newsWindow($('admin_news_link'));
        });
    }

    MochaUI.htmlrotateWindow=function(link){
        new MochaUI.Window({
            id:"admin_htmlrotate_window",
            loadMethod: 'fullajax',
            contentURL: link.get("href"),
            title:link.get("html"),
            width: window.getSize().x*0.7,
            height: window.getSize().y*0.7
        });
    }
    if ($('admin_htmlrotate_link')){
        $('admin_htmlrotate_link').addEvent('click', function(e){
            new Event(e).stop();
            MochaUI.htmlrotateWindow($('admin_htmlrotate_link'));
        });
    }

    //orders
    MochaUI.ordersWindow=function(link){
        new MochaUI.Window({
            id:"admin_orders_window",
            loadMethod: 'fullajax',
            contentURL: link.get("href"),
            title:link.get("html"),
            width: window.getSize().x*0.7,
            height: window.getSize().y*0.7
        });
    }
    if ($('admin_orders_link')){
        $('admin_orders_link').addEvent('click', function(e){
            new Event(e).stop();
            MochaUI.ordersWindow($('admin_orders_link'));
        });
    }
}

FCK_fix=function(){
    if (FCKeditorAPI){
        for (fckeditorName in FCKeditorAPI.__Instances){
            var _fck_nst=FCKeditorAPI.GetInstance(fckeditorName);
            _fck_nst.UpdateLinkedField();
        }
    }
}

// Initialize MochaUI when the DOM is ready
window.addEvent('domready', function(){

    $$('a.returnFalse').each(function(elem){
        elem.addEvent('click',function(e){
            new Event(e).stop();
        });
    });

    MochaUI.Desktop = new MochaUI.Desktop();
    MochaUI.Dock = new MochaUI.Dock({
        dockPosition: 'bottom'
    });
    MochaUI.Modal = new MochaUI.Modal();
	
    MochaUI.Desktop.desktop.setStyles({
        'background': '#fff',
        'visibility': 'visible'
    });
	
    initializeWindows();
});

// This is just for the demo. Running it onload gives pngFix time to replace the pngs in IE6.
window.addEvent('load', function(){
    $$('.desktopIcon').addEvent('click', function(){
        MochaUI.notification('Do Something');
    });
});	

// This runs when a person leaves your page.
window.addEvent('unload', function(){
    if (MochaUI) MochaUI.garbageCleanUp();
});