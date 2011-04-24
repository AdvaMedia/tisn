/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var A2M = new Hash({

    updateContent: function(updateOptions){
        var options = {
            'element':      null,
            'url':          null
        };
        $extend(options, updateOptions);

        if (!options.element) return;
        var element = options.element;
        var element_uniq_id = 'content_'+$time()
        element.set('id',element_uniq_id);
        hax({
            url:options.url,
            nohistory:1,
            nocache:true,
            id: element_uniq_id,
            method: 'get'
        });
    }
}
);

A2M.windowOptions = {
    title:  null,
    resizable: false,
    draggable: true,
    closable: true,
    title: 'Заголовок окна',
    url: '/blogs/help'
};

A2M.Window = new Class({
    Implements: [Options, Events],
    initialize:function(options){
        this.options= A2M.windowOptions;
        this.setOptions(options);

        if (!this.options.container){
            this.options.container = document.body;
        }

        this.newWindow();

        return this;
    },

    newWindow: function(properties){
        //Добавляем главный элемент окна
        this.windowEl = new Element('table',{
            'class': 'flykarkas'
        });
        //Если окно можно перемещать
        if (this.options.draggable){
            this.windowEl.addClass('move');
        }
        //Если можно изменять размеры окна
        if (this.options.resizable){
            this.windowEl.addClass('resize');
        }

        this.insertWindowElements();

        this.attachDraggable(this.windowEl);
        this.attachClosable(this.windowEl);

        A2M.updateContent({
            'element': this.contentEl,
            'url':this.options.url
        });

        this.options.container.adopt(this.windowEl);
        this.windowEl.position();
    },

    //Строим таблицу страницы
    insertWindowElements: function(){
        var options = this.options;
        var cache = {};

        cache.tr_top =    new Element('tr').inject(this.windowEl);
        cache.tr_center = new Element('tr').inject(this.windowEl);
        cache.tr_bottom = new Element('tr').inject(this.windowEl);

        //Верхняя плашка

        cache.top_ctl = new Element('td',{
            'class':'ctl',
            'html':'&nbsp;'
        }).inject(cache.tr_top);
        cache.top_top = new Element('td',{
            'class':'top',
            'html':'&nbsp;'
        }).inject(cache.tr_top);
        cache.top_ctr = new Element('td',{
            'class':'ctr',
            'html':'&nbsp;'
        }).inject(cache.tr_top);

        //Нижняя плашка
        cache.bottom_cbl = new Element('td',{
            'class':'cbl',
            'html':'&nbsp;'
        }).inject(cache.tr_bottom);
        cache.bottom_bottom = new Element('td',{
            'class':'bottom',
            'html':'&nbsp;'
        }).inject(cache.tr_bottom);
        cache.bottom_cbr = new Element('td',{
            'class':'cbr',
            'html':'&nbsp;'
        }).inject(cache.tr_bottom);

        //Центр
        cache.center_left = new Element('td',{
            'class':'left',
            'html':'&nbsp;'
        }).inject(cache.tr_center);
        cache.center_center = new Element('td').inject(cache.tr_center);
        ;
        cache.center_right = new Element('td',{
            'class':'right',
            'html':'&nbsp;'
        }).inject(cache.tr_center);

        //Заголовок окна
        cache.titleBar = new Element('h3',{
            'class':'corners corners-4',
            'html':this.options.title
        }).inject(cache.center_center);

        if (this.options.closable){
            cache.closeButton = new Element('a',{
                'class':'closemodal',
                'href':'#'
            });
            cache.closeImage = new Element('img',{
                'width':'16',
                'height':'16',
                'title': 'Закрыть',
                'alt': 'Закрыть',
                'src':'/i/icons/cross.png'
            }).inject(cache.closeButton);
            cache.close_cont = new Element('span').inject(cache.titleBar);
            cache.closeButton.inject(cache.close_cont);
        }
        cache.contentEl = new Element('div',{
            'class':'content'
        }).inject(cache.center_center);

        //-----------------------------------------------------------------------------

        

        //-----------------------------------------------------------------------------
        $extend(this, cache);
    },

    attachDraggable: function(windowEl){
        if (!this.options.draggable) return;
        this.windowDrag = new Drag.Move(windowEl,{
            handle: this.titleBar
        });
    },

    attachClosable: function(windowEl){
        if (!this.options.closable) return;
        this.closeButton.addEvent('click',function(e){
            new Event(e).stop();
            windowEl.destroy();
        });
    }
});