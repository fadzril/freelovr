jQuery(function($) {
   window.Actions = Spine.Controller.create({
     elements: {
       '.action .details': 'details'
     },

     events: {
       '.action .details': 'click',
       '.action .website': 'click'
     },

     init: function() {
       this.elements.hide();

       Actions.bind('change', this.render);
       this.App.bind('change', this.render)
     },

     render: function(){
      this.items = this.elements;
      $(this.items).click()
     }


  })
});