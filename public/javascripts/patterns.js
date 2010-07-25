// patterns ------------------------------------------------------------------

// facebook ------------------------------------------------------------------

var facebook = {
  init:function(){
    // sign in
    FB.Event.subscribe('auth.login', function(response) {
      u.load()  // redirect when the user gets connected to facebook
    });
    // sign out
    $("a.sign_out").click(function(e) {
        var url = $(this).attr("href");
        FB.getLoginStatus(function(response) {
          if (response.session) { // user is connected to Facebook
            e.preventDefault();
            FB.logout(function() { u.load(url) });
          }
        });
    });
    // todo: get this working with login_status/etc.
    $('a.facebook').click(function(e){
      e.preventDefault()
      FB.getLoginStatus(function(response) {
        if (response.session) { // user is connected to Facebook
          u.reload()
        } else {
          FB.login(function(response) {
            if (response.session) {
              if (response.perms) {
                // user is logged in and granted some permissions.
                // perms is a comma separated list of granted permissions
                log(response.perms)
              } else {
                // user is logged in, but did not grant any permissions
                log('have no perms')
              }
            } else {
              // user is not logged in
              log('could not log you in')
            }
          }, {perms:'email,publish_stream'});
        }
      })
    })
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
          $(this).stop().animate({ backgroundColor: $(this).data('hover_color').call(this) })
        } else {
          $(this).stop().animate({ backgroundColor: $(this).data('hover_color') })
        }
      },
      function(){
        if (typeof($(this).data('bg_color')) == 'function'){
          $(this).stop().animate({ backgroundColor: $(this).data('bg_color').call(this) })
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

// google analytics ----------------------------------------------------------

var gat = function(code) {
  if (code) {
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', code]);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
  }
}

// hoverable -----------------------------------------------------------------

var hoverable = {
  init: function(container){
    container = container || ''
    $(container + ' .hoverable').hover(
      function() { $(this).addClass('hover'); },
      function() { $(this).removeClass('hover'); }
    )
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
    this.save_button()
  },
  fix_fonts:function(container){
    var el = container ? container + ' ' : 'li.video '
    typography.shadow([el + 'h3 a'], '#555')
    typography.shadow([el + 'ul.options a'])
    typography.hoverable([el + 'h4', el + '.athletes a'])
  },
  hovers:function(){
    fader.init('ul.options li.edit a', '#fff600')
    fader.init('ul.options li.delete a', '#ff0000')
    fader.init('ul.options li.watch a', '#4c4c4c')
    fader.init('ul.options li.save a', '#00ff66', (function(){
      return $(this).hasClass('saved') ? '#00ff66' : '#9a9a9a'
    }))
  },
  save_button:function(){
    $('ul.options li.save a').live('click',function(e){
      var link = $(this)
      var span = link.find('span.text')
      var text = span.text() == 'Save' ? 'Saved' : 'Save'
      link.removeClass('save saved').addClass(text.toLowerCase())
      span.fadeOut('fast', function(){
        var $this = $(this)
        var style = "." + $this.parents('li.video:first').attr('class').split(' ')[1]
        $this.text(text)
        typography.hoverable_with_shadow([style + ' a.save_video span.text'])
        $this.fadeIn()
      })
    })
  },
  increment_views:function(selector){
    el = $(selector + ' span.total_views')
    el.hide()
    el.text(parseFloat(el.text()) + 1).fadeIn('fast')
  }
}

// video.popup ----------

video.popup = {
  show:function(){
    typography.hoverable(['.window h2'])
    typography.hoverable_with_shadow(['a.save_video'])
    popup.show()
  }
}
// utility -------------------------------------------------------------------

var u = {
  log:function(message){
    if (window.console) console.log(message)
  },
  load:function(path){
    path = path || '/'
    window.location.href = path
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
