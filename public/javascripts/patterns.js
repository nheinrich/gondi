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

// typography ----------------------------------------------------------------

var typography = {
  init:function(){
    this.shadow(['h1 a','.footer a'])
  },
  replace:function(elements){
    Cufon.replace(elements)
    this.show(elements)

  },
  shadow:function(elements, color){
    color = color || '#888'
    var declaration = color + ' 1px 1px'
    Cufon.replace(elements, { textShadow: declaration})
    this.show(elements)
  },
  show:function(elements){
    setTimeout(function(){
      $(elements.join(', ')).css('visibility','visible').fadeIn('slow')
    },10)

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
