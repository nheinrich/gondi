// patterns ------------------------------------------------------------------

// facebook ------------------------------------------------------------------

var facebook = {
  init:function(){
    // init facebook
    // would be nice if the app_id was somehow grabbed from the facebook.yml
    FB.init("136218683069813", "/xd_receiver.htm")
    // setup links
    $('a.fb_connect').click(function(){
      var url = $(this).attr('href')
      FB.Connect.requireSession(function(){ facebook.sign_in(url) })
      return false
    })
  },
  sign_in:function(url){
    document.location.href = url
  }
}

// fader ---------------------------------------------------------------------

var fader = {
  init: function(element, hover_color, bg_color){
    el = $(element)
    el.data('hover_color', hover_color)
    el.data('bg_color', (bg_color || el.css('background-color')))

    $(el).hover(
      function(){
        if (typeof($(this).data('hover_color')) == 'function'){
          $(this).stop().animate({ backgroundColor: $(this).data('hover_color')() })
        } else {
          $(this).stop().animate({ backgroundColor: $(this).data('hover_color') })
        }
      },
      function(){
        if (typeof($(this).data('bg_color')) == 'function'){
          $(this).stop().animate({ backgroundColor: $(this).data('bg_color')() })
        } else {
          $(this).stop().animate({ backgroundColor: $(this).data('bg_color') })
        }
      }
    )
  }

}

// inputs --------------------------------------------------------------------

var forms = {
  init:function(){
    this.setup.text_field_blur()
    this.setup.submit_buttons()
  },
  setup:{
    text_field_blur:function(){
      $('div.fancy_input input').hint('blur')
    },
    submit_buttons:function(){
      $('a.submit').live('click', function(){
        $(this).parents('form').submit()
      })
    }
  }
}

// hoverable -----------------------------------------------------------------

var hoverable = {
  init: function(){
    $('.hoverable').hover(function() {
     $(this).addClass('hover');
    }, function() {
     $(this).removeClass('hover');
    })
  }
}

// typography ----------------------------------------------------------------

// todo: refactor the option methods into one method that accepts options

var typography = {
  init:function(){
    this.shadow(['h1 a','.footer a'])
  },
  replace:function(elements){
    Cufon.replace(elements)
    this.show(elements)
  },
  hoverable:function(elements){
    Cufon.replace(elements, { hover: true})
    this.show(elements)
  },
  shadow:function(elements, color){
    color = color || '#888'
    var declaration = color + ' 1px 1px'
    Cufon.replace(elements, { textShadow: declaration})
    this.show(elements)
  },
  hoverable_with_shadow:function(elements, color){
    color = color || '#888'
    var declaration = color + ' 1px 1px'
    Cufon.replace(elements, { textShadow: declaration, hover: true})
    this.show(elements)
  },
  show:function(elements){
    setTimeout(function(){
      $(elements.join(', ')).css('visibility','visible').fadeIn('slow')
    },10)

  }
}

// video ---------------------------------------------------------------------

var video = {}

// video form ----------

video.form = {
  element:function(el){
    return this.el = el ? el : (this.el ? this.el : '.video_form')
  },
  athlete_search:function(el){
    return this.as = el ? el : (this.as ? this.as : this.el + ' .athlete_search input:text')
  },
  hide:function(){
    var form = $("div.video_form")
    form.siblings('span.hr:first').remove()
    form.slideToggle().remove()
  },
  init:function(){
    // fixes fonts on the form
    typography.replace([this.selector('h2')], true)
    // status toggle
    $(this.el + ' div.status a').live('click',function(){
      var el = video.form.element() + ' div.status '
      var selected = $(el + 'a.selected')
      var next = selected.next('a')[0] || $(el + ' a:first')
      log(next)
      $(selected).removeClass('selected')
      $(next).addClass('selected')
      $(el + "input[type='hidden']").val($.trim($(next).text()))
    })
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
}

// video list ----------

video.list = {
  init:function(){
    this.fix_fonts()
    this.hovers()
  },
  hovers:function(){
    fader.init('ul.options li.edit a', '#fff600')
    fader.init('ul.options li.delete a', '#ff0000')
    fader.init('ul.options li.watch a', '#e7c9bb')
    fader.init('ul.options li.save a', '#00ff66', function(){
      return $('ul.options li.save a').hasClass('saved') ? '#00ff66' : '#9a9a9a'
    })
  },
  fix_fonts:function(container){
    var el = container ? container + ' ' : 'li.video '
    typography.shadow([el + 'h3'], '#555')
    typography.shadow([el + 'ul.options a'])
    typography.hoverable([el + 'h4', el + '.athletes a'])
  },
  favorite:function(id, text){
    var btn = $(id)
    var span = btn.find('span.text')
    span.fadeOut('fast',function(){
      $(this).html(text)
      typography.hoverable_with_shadow([id + ' span'])
      $(this).parents('a:first').removeClass('save saved').addClass(text.toLowerCase())
    }).fadeIn('fast')
  }
}

// utility -------------------------------------------------------------------

var u = {
  log:function(message){
    if (window.console) console.log(message)
  },
  reload:function(){
    window.location.reload();
  },
  test:function(callback){
    // keyCode 88 == 'x'
    $(document).keyup(function(e){if (e.keyCode == 88) callback() })
  }
}

var log = function(msg){ u.log(msg) }


// temp ----------------------------------------------------------------------
