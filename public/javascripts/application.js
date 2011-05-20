// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
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
        .css('background-color', 'rgba('+r+','+g+','+b+','+Math.random(255*100)+')');
    },

    render: function(e){
      e.preventDefault();
      var target = $(this).attr('href');
      $('.list').load(target);
    },

    setLevelText: function() {
      var txt = this.level.text();
      alert(this.level.length);
      switch(txt){
        case '2':
          this.level.text('Not A Rockstar');
          break;
        case '3':
          this.level.text('Somewhat a Rockstar');
          break;
        case '4':
          this.level.text('Totally Rockstar');
          break;
        default:
          this.level.text('Not Really Sure');
          break;
      }
    },

    fetch: function(){
      function split( val ) {
        return val.split( /,\s*/ );
      }
      function extractLast( term ) {
        return split( term ).pop();
      }

      $(this).autocomplete({
//        source: function( request, response ) {
//          $.ajax({
//            url: "filters/index",
//            dataType: "json",
//            data: request.term,
//            success: function( data ) {
//              response(
//                  $.map(data, function(item){
//                    return {
//                        label: item,
//                        value: item,
//                        id: item
//                    }
//                  })
//              )
//            }
//          });
//        },
        source: function(request, response) {
          $.getJSON('filters/index',request.term, response);
        },
        search: function(){
          console.log(this.value)
        },
        focus: function(){
          return false;
        },
        select: function(event, ui) {
          var user = ui.item.id;
          $('.list').load('users/'+user);
        }
      });
    },

    init: function(){

      $('select').selectbox();
      $('.statistic').find('li').each(this.randomized);

      //TODO: refactor to controller, remove all attached events
      this.detail.live('click', this.render);
      this.filter.live('keypress', this.fetch);
    }
  }).init();
});
