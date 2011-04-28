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

//    ShaderEffectItem {
//        anchors.fill: parent

//        property variant source: ShaderEffectSource {
//            sourceItem: fromSlide
//        }

//        fragmentShader: "
//        varying highp vec2 qt_TexCoord0;
//        uniform mediump sampler2D source;
//        uniform lowp float qt_Opacity;
//        void main() {
//            gl_FragColor = texture2D(source, qt_TexCoord0) + vec4(qt_TexCoord0.x, qt_TexCoord0.y, 1, 1) * 0.5;
//        }
//        "

//        visible: deck.inTransition
//    }

    SequentialAnimation {
        id: transition
        ScriptAction { script: {
                deck.inTransition = true
                toSlide.visible = true
            }
        }

        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime;  }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 0.7; duration: deck.transitionTime; }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; }
            NumberAnimation { target: toSlide; property: "scale"; from: 1.1; to: 1; duration: deck.transitionTime; easing.type: Easing.OutBack}
        }

        ScriptAction { script: {
                deck.inTransition = false
                fromSlide.visible = false
                fromSlide.scale = 1
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

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "steelblue" }
            GradientStop { position: 1; color: "black" }
        }
    }

    Slide {
        title: "Slide number 1"
        content: [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            "Duis at dui eget mi vulputate ornare eget scelerisque justo.",
            "Quisque ut mi sit amet lorem sollicitudin faucibus.",
            "Mauris quis tellus vitae justo tempor lobortis in in ipsum.",
            "Praesent in mi eget mauris gravida hendrerit at at sapien.",
            "Cras semper diam a ligula tristique fringilla."
        ]
        bulletSpacing: 0
    }

    Slide {
        title: "Slide number 2"
        content: [
            "Duis sodales nibh a sem posuere non mollis tellus pharetra.",
            "Quisque viverra massa non tortor dictum eu porta enim vulputate.",
            "Ut id lacus eget sem rhoncus ultricies sed vel mi.",
            "Etiam gravida ipsum vel nisi sodales fringilla.",
            "Suspendisse interdum fringilla nisl, sodales feugiat neque accumsan eget.",
            "Vestibulum ultrices risus consectetur odio sagittis ac pharetra dolor ornare.",
            "Nunc tincidunt nisl sed ante vehicula consequat."
        ]
        bulletSpacing: 0
    }

    Slide {
        title: "Slide number 3"
        content: [
            "Vestibulum aliquam orci non ante viverra pretium.",
            "Aliquam fermentum congue eros, eget blandit eros dignissim nec.",
            "Quisque faucibus turpis et orci tempus interdum.",
            "Aenean at dolor arcu, eu dapibus purus.",
            "Ut ut elit nec dolor lobortis imperdiet.",
            "Phasellus quis dolor nibh, at aliquam nulla.",
            "Suspendisse vitae enim dictum tortor tempor lobortis ac eget felis.",
            "Fusce eget odio eget metus pharetra mattis nec et justo."
        ]
        bulletSpacing: 0
    }

    Slide {
        title: "Slide number 4"
        content: [
            "Pellentesque nec nulla est, et posuere augue.",
            "Sed ornare nisi ac quam rhoncus mollis.",
            "Cras facilisis diam id purus dapibus quis fermentum arcu ultricies."
        ]
        bulletSpacing: 0
    }

    Slide {
        title: "Slide number 5"
        content: [
            "Nulla sollicitudin posuere nisi, ut viverra lacus pellentesque id.",
            "Sed imperdiet porttitor enim, eu dictum mi eleifend sit amet.",
            "Nulla et sapien quis magna volutpat viverra vel eu libero."
        ]
        bulletSpacing: 0
    }

}
