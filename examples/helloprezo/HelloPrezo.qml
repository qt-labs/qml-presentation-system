import Prezo 1.0
import QtQuick 2.0

Presentation
{
    width: 800
    height: 600


    Slide {
        fontScale: 2
        centeredText: "Click to walk through intro!"
    }


    Slide {
        id: areaSlide
        title: "Title Text - Bullet points"
        content: [
            "Bullet points",
            "Should be short",
            "And to the point"
        ]
        Rectangle {
            x: areaSlide.contentX
            y: areaSlide.contentY
            width: areaSlide.contentWidth
            height: areaSlide.contentHeight

            color: Qt.rgba(0, 0, 0, 0.1)

            Text {
                text: "Dedicated content area"
                anchors.centerIn: parent
            }
        }
    }


    Slide {
        title: "Title Text - Centered Text"
        centeredText: "And this is some centered text..."
    }


    Slide {
        title: "Text is relative to presentation height"
        content: [
            "Which means you don't need to worry about it",
            "Bullet points wraps around on the edges, regardless of how long they are, like this. Even if you should choose to use a very long bullet point (which would distract your audience) it would still look ok'ish",
            "If you run out of height, you're out of luck though..."
        ]
    }


    Slide {
        centeredText: '<font color="red"><i>Use</i> rich text, <font color="blue">if <b>you</b> like...'
    }


    Slide {
        id: interactiveSlide

        title: "Embed Interactive Content"

        Rectangle {
            width: parent.height / 4
            height: width
            color: mouse.pressed ? "lightsteelblue" : "steelblue"
            anchors.centerIn: parent

            NumberAnimation on rotation { from: 0; to: 360; duration: 10000; loops: Animation.Infinite; running: visible }

            Text {
                text: "Click Me!"
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
            }
        }
    }


    Slide {
        centeredText: 'Hit "Esc" to fade out the current page if there are questions from the audience'
    }


    Slide {
        centeredText: "Now go make our own presentations\n\nEnjoy!"
    }


}
