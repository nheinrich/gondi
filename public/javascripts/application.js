// common

$(document).ready(function() {
  facebook.init();
  typography.init();
})

// views ---------------------------------------------------------------------

var video = {
  form:{
    element:function(el){
      return this.el = el ? el : (this.el ? this.el : '.video_form')
    },
    athlete_search:function(el){
      return this.as = el ? el : (this.as ? this.as : this.el + ' .athlete_search input:text')
    },
    hide:function(){
      $("div.admin div.video_form").slideToggle().remove()
      $("div.admin span.hr").remove()
    },
    init:function(){
      // fixes fonts on the form
      typography.replace([this.selector('h2')], true)
      // adds input hints, submit interaction
      forms.init()
      // input / autocomplete
      var $input = $(this.athlete_search())
      $input.autocomplete({
        url: '/athletes.js',
        matchContains: 1
      });
      // adds athlete on keypress of enter (13)
      $input.keypress(function(e){
        if (e.keyCode == 13) {
          var name = $(this).val()
          $.get('/videos/add_athlete', { athlete: name }, function(){
            $(video.form.athlete_search()).val('')
          }, 'script')
        }
      })
      // remove athlete icon links
      $(this.el + ' .athletes ul.tag_list a').live('click',function(){
        $(this).parents('li').fadeOut().remove()
        return false
      })
      // cancel button
      $(this.el + ' .buttons a.cancel').live('click',function(){
        video.form.hide()
      })
    },
    select_athlete:function(){

    },
    selector:function(str){
      return this.element() + ' ' + str
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

