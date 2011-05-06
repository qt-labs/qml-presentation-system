import QtQuick 2.0
import Prezo 1.0

Presentation {
    width: 640
    height: 360

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "lightsteelblue" }
            GradientStop { position: 1; color: "black" }
        }
    }

    Rectangle {
        id: colorTableItem
        width: 16
        height: 16
        anchors.fill: parent

        property color color1: "white"
        property color color2: "white"

        gradient: Gradient {
            GradientStop { position: 0; color: colorTableItem.color1 }
            GradientStop { position: 0.2; color: "transparent" }
            GradientStop { position: 0.8; color: "transparent" }
            GradientStop { position: 1; color: colorTableItem.color2 }
        }

        visible: false
    }

    ShaderEffectSource {
        id: colorTableSource
        sourceItem: colorTableItem
        smooth: true
    }

    Swirl {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        height: parent.height / 4
        opacity: 0.3
        colorTable: colorTableSource
    }
    Swirl {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        height: parent.height / 4
        opacity: 0.3
        colorTable: colorTableSource
    }

    property color textColor: "white"

    Slide {
        centeredText: "Animated Backgrounds"
        fontScale: 2
    }

    Slide {
        centeredText: "Just create what ever you want in the background, like shaders or rotating boxes and then put your Slide{} elements on top.."
    }

}
