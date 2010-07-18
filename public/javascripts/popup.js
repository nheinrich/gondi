// popup ---------------------------------------------------------------------

var popup = {
  load:function(url){
    if (url) $.ajax({ dataType:'script', type:'get', url: url })
  },
  element:function(el){
    return this.el = el ? el : (this.el ? this.el : '#popup')
  },
  hide:function(e){
    if ($(this.element()).css('display') == 'block') {
      var el = e ? $(e.target) : $('body')
      if (el.is(this.element() + ' .window') || el.parents().is(this.element() + ' .window')) {
        // do nothing
      } else {
        $(this.element()).fadeOut();
        this.clear()
      }
    }
    return false
  },
  show:function(){
    this.setup.common();
    $(this.element()).show();
  },
  render:function(page){
    $(this.element()).html(page)
  },
  clear:function(){
    $(this.element()).html('')
  },
  setup: {
    common:function(){
      this.cancel();
      this.click_watch();
    },
    // cancel button
    cancel:function(){
      $(popup.element() + 'a.close').click(function(){
        popup.hide();
        return false
      })
    },
    // watches for clicks outside of the overlay, hides overlay if true
    click_watch:function(e){
      $(document).keyup(function(e){if (e.keyCode == 27) popup.hide(e)})
      $(document).bind('click', function(e) { popup.hide(e) })
    }
  }
}

// watch (popup) -------------------------------------------------------------

popup.watch = {
  show:function(){
    typography.hoverable(['.window h2 a'])
    popup.show()
  },
  video:function(url){
    popup.load(url)
  }
}
