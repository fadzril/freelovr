jQuery(function($){
   window.Map = Spine.Controller.create({
     el : "body",

     map : null,

     elements : {
       "#map": "mapContainer"
     },

     render : function() {
       var lat = 3.0774376970512085; //45.428688849691014;
       var lng = 101.51641845703125; //12.317744493484497;
       var point = new google.maps.LatLng(lat,lng);
       var options = {
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
       
       window.Map.fn.map = new google.maps.Map(document.getElementById('map'), options);
       window.Map.fn.map.setTilt(45);
     },

     showMap : function() {
       var that = this;
       var geocoder = new google.maps.Geocoder();
       if (window.Twitter.fn.els.users.length) {
         $.each(window.Twitter.fn.els.users, function(key, value) {
           geocoder.geocode({address: value.properties.location}, that.createMarkers)
         });
         clearTimeout(this);
       }
     },

     hideMap : function() {
      this.mapContainer.hide();
     },

     showDetails : function() {
     },

     createMarkers: function(response, status) {
       if (status == google.maps.GeocoderStatus.OK) {

         var x = response[0].geometry.location.lat();
         var y = response[0].geometry.location.lng();
         var marker = new google.maps.Marker({
           icon: value.avatarImg,
           map: map,
           title: value.screenName,
           position: new google.maps.LatLng(x, y)
         });

         marker.setMap(window.Map.fn.map);
       }
     },

     init : function() {
       this.App.bind('change', this.render);
       this.render();
       this.mapContainer.show();
       //setTimeout(this.showMap, 3000);
     }

   });
});