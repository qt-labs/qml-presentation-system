import QtQuick 2.0
import Prezo 1.0

Presentation {

    id: deck

    width: 600
    height: 400

    property color textColor: "white"

    property bool inTransition: false;

    property variant fromSlide;
    property variant toSlide;

    property int transitionTime: 500;

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "steelblue" }
            GradientStop { position: 1; color: "black" }
        }
    }

    Image {
        id: maskImage
        source: "distortion.png"
        visible: false
        smooth: true
    }

    ShaderEffectItem {
        id: effect

        anchors.fill: parent

        property variant source: ShaderEffectSource { sourceItem: fromSlide; smooth: true }
        property variant mask: maskImage

        property variant maskFactor;

        property real ratio: 0
        property real seed: 15

        fragmentShader: "
        varying highp vec2 qt_TexCoord0;
        uniform mediump sampler2D source;
        uniform mediump sampler2D mask;
        uniform lowp float qt_Opacity;
        uniform lowp float ratio;
        uniform lowp vec3 maskFactor;
        void main() {
            lowp vec3 distVec = texture2D(mask, qt_TexCoord0).xyz;
            lowp float p = dot(maskFactor, distVec);
            mediump vec2 sampleOffset = distVec.xy;
            gl_FragColor = texture2D(source, qt_TexCoord0 + ratio * sampleOffset * 0.2) * (1. - ratio * p * 4.) * (1. - ratio);
        }
        "

        onVisibleChanged: {
            effect.seed = Math.random() * Math.PI * 2;
            var x = Math.random();
            var y = Math.random();
            var z = Math.random();
            var l = Math.sqrt(x * x + y * y + z * z);
            maskFactor = Qt.vector3d(x / l, y / l, z / l);
        }

        visible: inTransition
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
            NumberAnimation { target: effect; property: "ratio"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InSine }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InSine }
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
