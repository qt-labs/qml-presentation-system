import QtQuick 2.0

import Qt.labs.presentation 1.0

Presentation {
    width: 1280
    height: 720

    BackgroundSwirls {}

    property color textColor: "white"

    Slide {
        centeredText: "Animated Background"
        fontScale: 2
    }

    Slide {
        title: "Composition"
        content: [
            "Gradient Rectangle",
            "Swirls using ShaderEffectItem",
            " Movement using a vertexShader",
            " Colorized using a gradient rect converted to a texture",
            " Controlled using QML properties and animations",
            "Snow",
            " Using 'Qt.labs.particles 2.0'",
            " TrailsEmitter",
            " ColoredParticle"
        ]
    }

}
