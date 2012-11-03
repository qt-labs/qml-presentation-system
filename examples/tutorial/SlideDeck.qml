/***************************************************************************
**
** This file is part of QML Presentation System **
**
** Copyright (c) 2010 Nokia Corporation and/or its subsidiary(-ies).*
**
** All rights reserved.
** Contact:  Nokia Corporation (qt-info@nokia.com)
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**
**  * Redistributions of source code must retain the above copyright notice,
**    this list of conditions and the following disclaimer.
**  * Redistributions in binary form must reproduce the above copyright notice,
**    this list of conditions and the following disclaimer in the documentation
**    and/or other materials provided with ** the distribution.
**  * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor the
**    names of its contributors may be used to endorse or promote products
**    derived from this software without specific ** prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
** IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
** ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
** LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
** DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
** SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
** CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
** OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
**************************************************************************/

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
            text: "Presentation
{
    width: 640
    height: 360

    // Define a background color...
    Rectangle {
        anchors.fill: parent
        color: \"white\"
    }

    property color textColor: \"black\"

    // Then define slide elements
    Slide { ... }
    Slide { ... }
    Slide { ... }
    ...
}"
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
        title: "Slide {}, continued"
        writeInText: "You can also use the 'writeInText' property for text that should appear character-by-character, like this...\n\n\nProin vulputate pretium tortor, ut bibendum nisi ultricies et. Nullam pharetra tincidunt lorem eu consequat. Sed placerat sem non lacus dictum at lobortis tellus molestie. Fusce sit amet iaculis odio. Ut dictum nibh quis justo lacinia pulvinar. In hac habitasse platea dictumst. Aliquam erat volutpat."
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
        centeredText: 'Hit [C] to fade out the current page if there are questions from the audience'
    }

    Slide {
        title: "Features"
        centeredText: 'Navigate back and forth using [left] and [right]\n[space] or [click] takes you to the next slide.'
    }


    Slide {
        centeredText: "Now go make our own presentations\n\nEnjoy!"
    }


}
