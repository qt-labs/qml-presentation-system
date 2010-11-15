import QtQuick 2.0

Rectangle {
    id: root
    width: 540
    height: 360
    gradient: Gradient {
        GradientStop { position: 0; color: "white" }
        GradientStop { position: 1; color: "black" }
    }

    property variant slides: []
    property int currentSlide;

   Component.onCompleted: {
       var slideCount = 0;
       var slides = [];
       for (var i=0; i<root.resources.length; ++i) {
           var r = root.resources[i];
           if (r.isSlide) {
               slides.push(r);
           }
       }

       root.slides = slides;

       // Make first slide visible...
       if (root.slides.length > 0) {
           root.currentSlide = 0;
           root.slides[root.currentSlide].opacity = 1;
       }
   }

   function moveToSlide(i) {
       slides[currentSlide].opacity = 0;
       slides[i].opacity = 1;
   }

   MouseArea {
       id: mouseArea
       anchors.fill: parent
       onClicked: {
           if (root.currentSlide + 1 < root.slides.length) {
               moveToSlide(currentSlide + 1);
               currentSlide = currentSlide + 1;
           }
       }
   }


}
