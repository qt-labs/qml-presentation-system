import Qt.labs.presentation 1.0
import QtQuick 2.0

Presentation
{
    width: 1280
    height: 720


    Slide {
        centeredText: "Use [space] or [keypad] to see intro"
    }

    Slide {
        title: "Presentation {} Element"
        content: [
            "Toplevel element",
            "Defines background",
            "Foreground color",
        ]

        CodeSection {
            text: "
import Prezo 1.0

Presentation
{
    width: 640
    height: 360

    // Define a background...
    // Default is white..
    Rectangle {
        id: backgroundColor
        anchors.fill: parent
        color: \"blue\"
    }

    // Set text color
    property color textColor: \"white\"

    // Then define slide elements
    Slide { ... }
    Slide { ... }
    Slide { ... }
    ...
}
            "
        }
    }


    Slide {
        title: "Slide {} Element"
        content: [
            "Bullet points",
            "Should be short",
            "And to the point",
            " Sub point",
            "  Sub Sub point",
            " Sub point"
        ]

        CodeSection {

            text: "Slide {\n" +
                  "    id: areaSlide\n" +
                  "    title: \"Slide {} Element\"\n" +
                  "    content: [\n" +
                  "              \"Bullet points\",\n" +
                  "              \"Should be short\",\n" +
                  "              \"And to the point\",\n" +
                  "              \" Sub point\",\n" +
                  "              \"  Sub Sub point\",\n" +
                  "              \" Sub point\"\n" +
                  "             ]\n" +
                  "}\n"
        }
    }

    Slide {
        title: "Slide {}, continued"
        Rectangle {
            anchors.fill: parent
            color: "lightGray"
            Text {
                text: "Slide fills this area..."
                anchors.centerIn: parent
            }
        }
    }

    Slide {
        id: fillAreaSlide
        title: "Slide {}, continued"
        content: ["The built-in property \"contentWidth\" can be used to let the bullet points fill a smaller area of the slide..."]

        SequentialAnimation on contentWidth {
            PropertyAction { value: fillAreaSlide.width }
            PauseAnimation { duration: 2500 }
            NumberAnimation { to: fillAreaSlide.width / 2; duration: 5000; easing.type: Easing.InOutCubic }
            running: fillAreaSlide.visible
        }

        Rectangle {
            height: parent.height
            width: parent.contentWidth

            color: "lightGray"
            z: -1
        }
    }

    Slide {
        title: "Slide {}, continued"
        centeredText: "Use the predefined <i><b><code>centeredText</code></b></i> property to put a single block of text at the center of the Slide{}"
    }

    Slide {
        title: "Slide {}, continued"
        centeredText: '<font color="red"><i>Use</i> rich text, <font color="blue">if <b>you</b> like...'
    }




    Slide {
        title: "Font size relative to screen size"
        content: [
            "Which means you don't need to worry about it",
            "Bullet points wraps around on the edges, regardless of how long they are, like this. Even if you should choose to use a very long bullet point (which would distract your audience) it would still look ok'ish",
            "If you run out of height, you're out of luck though..."
        ]
    }



    Slide {
        id: interactiveSlide

        title: "Embed Interactive Content"

        Rectangle {
            id: box
            width: parent.fontSize * 10
            height: width
            color: mouse.pressed ? "lightsteelblue" : "steelblue"

            NumberAnimation on rotation { from: 0; to: 360; duration: 10000; loops: Animation.Infinite; running: visible }

            Text {
                text: "Click Me!"
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                drag.target: box
            }
        }
    }


    Slide {
        title: "Features"
        centeredText: 'Hit [esc] to fade out the current page if there are questions from the audience'
    }

    Slide {
        title: "Features"
        centeredText: 'Navigate back and forth using [left] and [right]\n[space] or [click] takes you to the next slide.'
    }


    Slide {
        centeredText: "Now go make our own presentations\n\nEnjoy!"
    }


}
