import QtQuick 2.0
import Qt.labs.presentation 1.0

Presentation {

    id: deck

    width: 1280
    height: 720

    property color textColor: "white"

    property bool inTransition: false;

    property variant fromSlide;
    property variant toSlide;

    property int transitionTime: 500;

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "lightsteelblue" }
            GradientStop { position: 1; color: "black" }
        }
    }

    SequentialAnimation {
        id: transition
        ScriptAction { script: {
                deck.inTransition = true
                fromSlide.opacity = 0
                toSlide.visible = true
            }
        }

        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 1.1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: toSlide; property: "scale"; from: 0.7; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }

        ScriptAction { script: {
                deck.inTransition = false
                fromSlide.visible = false
                fromSlide.opacity = 0
                fromSlide.scale = 1
                toSlide.opacity = 1
            }
        }
    }

    function switchSlides(from, to)
    {
        if (deck.inTransition)
            return false

        deck.fromSlide = from
        deck.toSlide = to

        transition.running = true;

        return true
    }
}
