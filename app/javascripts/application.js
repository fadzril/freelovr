//= require <jquery>
//= require <spine>
//= require <jquery.ui>
//= require <selectbox>
//= require <controller/map>

jQuery(function($){
  window.App = Spine.Controller.create({
    el: $("body"),

    elements: {
      "#filter input": "filter",
      ".detail a": 'detail',
      ".detail .level": 'level'
    },

    randomized: function(){
      var r = parseInt(Math.floor(Math.random(255)*255), 10);
      var g = parseInt(Math.floor(Math.random(255)*255), 10);
      var b = parseInt(Math.floor(Math.random(255)*255), 10);
      $(this).children('span.size')
        .css('background-color', 'rgba('+r+','+g+','+b+','+Math.random(255*100).toFixed(2)+')');
    },

    render: function(e){
      e.preventDefault();
      var target = $(this).attr('href');
      $('.list').load(target);
    },

    fetch: function(){
      function split( val ) {
        return val.split( /,\s*/ );
      }
      function extractLast( term ) {
        return split( term ).pop();
      }

      $(this).autocomplete({
        source: function(request, response) {
          $.getJSON('filters/index', extractLast(request.term), response);
        },
        search: function(){
          console.log(this.value)
        },
        focus: function(){
          return false;
        },
        select: function(event, ui) {
          var user = ui.item.id;
          if (console) console.log("User ID: " + user);
          $('.list').load('users/'+user);
        }
      });
    },

    init: function(){

      Map.init();
      $('select').selectbox();
      $('.statistic').find('li').each(this.randomized);

      //TODO: refactor to controller, remove all attached events
      this.detail.live('click', this.render);
      this.filter.live('keypress', this.fetch);

    }
  }).init();
});
