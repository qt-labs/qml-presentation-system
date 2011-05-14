import QtQuick 2.0

import Qt.labs.presentation 1.0

Presentation {
    width: 640
    height: 360

    BackgroundSwirls {}

    property color textColor: "white"

    Slide {
        centeredText: "Animated Backgrounds"
        fontScale: 2
    }

    Slide {
        centeredText: "Just create what ever you want in the background, like shaders or rotating boxes and then put your Slide{} elements on top.."
    }

}
