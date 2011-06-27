jQuery(function($){
   window.Map = Spine.Controller.create({
     el : "body",
     elements : {
       "#map": "mapContainer"
     },

     render : function() {
       var lat = 3.0774376970512085; //45.428688849691014;
       var lng = 101.51641845703125; //12.317744493484497;
       var point = new google.maps.LatLng(lat,lng);
       var opt = {
          zoom : 12,
          center : point,
          mapTypeId : google.maps.MapTypeId.HYBRID,
          mapTypeControl : false,
          panControl : true,
          panControlOptions : {
            position : google.maps.ControlPosition.TOP_RIGHT
          },
          zoomControl : true,
          zoomControlOptions : {
            style : google.maps.ZoomControlStyle.SMALL,
            position : google.maps.ControlPosition.TOP_RIGHT
          },
          streetViewControl : true,
          streetViewControlOptions	: {
            position : google.maps.ControlPosition.TOP_RIGHT
          }
       };
       var map = new google.maps.Map(document.getElementById('map'), opt);
       map.setTilt(45);

       var marker = new google.maps.Marker(point);
       marker.setMap(map);
     },

     showMap : function() {
      this.mapContainer.show();

     },

     hideMap : function() {
      this.mapContainer.hide();
     },

     showDetails : function() {
      var marker = new google.maps.Marker(points);
     },

     init : function() {
       this.App.bind('change', this.render);
       this.render();
     }

   });
});