// common

$(document).ready(function() {
  facebook.init();
  typography.init();
  inputs.init();
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

      inputs.init()
    }
  },
  list:{
    init:function(){
      typography.shadow(['li.video h3'], '#555')
      typography.shadow(['li.video ul.options a'])
      typography.replace(['li.video h4','li.video .stars a'])
    }
  }
}

