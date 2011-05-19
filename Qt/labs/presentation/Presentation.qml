import QtQuick 2.0

Item {
    id: root

    property variant slides: []
    property int currentSlide;

    property bool faded: false

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
            root.slides[root.currentSlide].visible = true;
        }
    }

    function switchSlides(from, to) {
        from.visible = false
        to.visible = true
        return true
    }

    function goToNextSlide() {
        if (faded)
            return
        if (root.currentSlide + 1 < root.slides.length) {
            var from = slides[currentSlide]
            var to = slides[currentSlide + 1]
            if (switchSlides(from, to)) {
                currentSlide = currentSlide + 1;
                root.focus = true;
            }
        }
    }

    function goToPreviousSlide() {
        if (root.faded)
            return
        if (root.currentSlide - 1 >= 0) {
            var from = slides[currentSlide]
            var to = slides[currentSlide - 1]
           if (switchSlides(from, to)) {
                currentSlide = currentSlide - 1;
               root.focus = true;		
           }
        }
    }

    focus: true

    Keys.onSpacePressed: goToNextSlide();
    Keys.onRightPressed: goToNextSlide();
    Keys.onLeftPressed: goToPreviousSlide();
    Keys.onEscapePressed: root.faded = !root.faded;

    Rectangle {
        z: 1000
        color: "black"
        anchors.fill: parent
        opacity: root.faded ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: goToNextSlide()
    }


}
