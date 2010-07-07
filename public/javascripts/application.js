// common

$(document).ready(function() {
  facebook.init();
})

// views ---------------------------------------------------------------------

var video = {
  new:{
    init:function(){
      console.log('video.new.init')
    }
  }
}


// components ----------------------------------------------------------------

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

// temp ----------------------------------------------------------------------
