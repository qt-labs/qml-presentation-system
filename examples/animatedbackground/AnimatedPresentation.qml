import QtQuick 2.0
import Prezo 1.0

Presentation {

    id: deck

    width: 600
    height: 400


    property bool inTransition: false;

    property variant fromSlide;
    property variant toSlide;

    property int transitionTime: 2000;

    BackgroundSwirls {}

    ShaderEffectItem {
        id: effect
        anchors.fill: parent
        visible: deck.inTransition
        property variant source: ShaderEffectSource { sourceItem: fromSlide; smooth: true }
        property real ratio: 0
        property real amplitude: 0.1 * ratio
        property real frequency: 20
        property real time: 0
        NumberAnimation on time { loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 2000 }
        fragmentShader:
            "uniform highp float amplitude;" +
            "uniform highp float frequency;" +
            "uniform highp float time;" +
            "uniform lowp float ratio;" +
            "uniform sampler2D source;" +
            "varying highp vec2 qt_TexCoord0;" +
            "void main() {" +
            "    highp vec2 p = sin(time + frequency * qt_TexCoord0);" +
            "    gl_FragColor = texture2D(source, qt_TexCoord0 + amplitude * vec2(p.y, -p.x)) * (1. - ratio);" +
            "}"
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
            NumberAnimation { target: effect; property: "ratio"; from: 0; to: 1; duration: deck.transitionTime; }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
        }

        ScriptAction { script: {
                deck.inTransition = false
                fromSlide.visible = false
                fromSlide.opacity = 0
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
