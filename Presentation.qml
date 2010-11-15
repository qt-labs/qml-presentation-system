import QtQuick 2.0

Item {
    id: root

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

   function switchSlides(from, to) {
       from.opacity = 0
       to.opacity = 1
       return true
   }

   MouseArea {
       id: mouseArea
       anchors.fill: parent
       onClicked: {
           if (root.currentSlide + 1 < root.slides.length) {
	       var from = slides[currentSlide]
	       var to = slides[currentSlide + 1]
               if (switchSlides(from, to))
	           currentSlide = currentSlide + 1;
           }
       }
   }


}
