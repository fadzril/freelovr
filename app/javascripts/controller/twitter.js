jQuery(function($) {
  window.Twitter = Spine.Controller.create({
    els : {
      users : []
    },

    userList: function() {
      var that = this;
      $.getJSON('/users/list.json', function(data) {
        $.each(data, function(key, value) {
          var username = that.trimName(value);
          window.Twitter.fn.getUsers(username);
        });
      });
    },

    trimName: function(str) {
      return str
        .replace('http', '')
        .replace(/[:\/\/!.#]/ig, '')
        .replace(/(www)(twitter)(com)/g, '')
        .replace(/twittercom/, '')
        .replace('@', '');
    },

    getUsers: function(user) {
      if (user) {
        var path = 'http://twitter.com/users/show/'+user;
        $.ajax({
          url: path,
          dataType: 'text',
          success: function(data) {
            var properties = {
              'screenName': data.screen_name,
              'avatarImg' : data.profile_img_url,
              'location'  : data.location
            };
            window.Twitter.fn.els.users.push(properties);
            clearTimeout(this);
          }
        });
      } else {
        return false;
      }
    },

    callbackEventHandler : function(data) {
      return false;
    },

    init: function() {
      this.userList();
      //setTimeout(this.getUsers, 2000);
    }
  });
});