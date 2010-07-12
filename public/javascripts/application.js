// common

$(document).ready(function() {
  facebook.init();
  typography.init();

  $('a.new_video').click()
})

// views ---------------------------------------------------------------------

var video = {
  form:{
    element:function(el){
      return this.el = el ? el : (this.el ? this.el : '.video_form')
    },
    selector:function(str){
      return this.element() + ' ' + str
    },
    init:function(){
      typography.replace([this.selector('h2')], true)
      forms.init()
    }
  },
  list:{
    init:function(){
      this.fix_fonts()
    },
    fix_fonts:function(container){
      var el = container ? container + ' ' : 'li.video '
      typography.shadow([el + 'h3'], '#555')
      typography.shadow([el + 'ul.options a'])
      typography.replace([el + 'h4', el + '.athletes a'])
    }
  }
}

