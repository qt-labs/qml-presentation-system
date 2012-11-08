import QtQuick 2.0
import Qt.labs.presentation 1.0

Presentation {

    width: 1280
    height: 720

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.16; color: "black" }
            GradientStop { position: 0.17; color: "white" }
            GradientStop { position: 0.92; color: "white" }
            GradientStop { position: 0.93; color: "black" }
        }
    }

    Clock { textColor: "white" }
    SlideCounter { textColor: "white" }

    property string titleColor: "white"

    showNotes: true

    Slide {
        id: firstSlide;
        centeredText: "Using Notes..."
        fontScale: 2
        notes: "In this window you will see the notes for the very first slide..."
    }

    CodeSlide {
        title: "Enable using Presentation.showNotes"
        notes: "Here you can see the code required to enable the slides view.

It is as simple as setting 'showNotes: true' in the Presentation {} element and then add a text to the 'notes' property of the Slide.

The text will then update automatically as you go from slide to slide."
        code:
"Presentation {
    showNotes: true;

    Slide {
        title: 'Slide One'
        content: ['bullet point', 'bullet point'];
        notes: 'Here cometh the notes...'
    }
"
    }

    Slide {
        title: "Example Slide"
        content: [
            "There should be a second window on your desktop",
            "It should read 'once upon a time'",
            "",
            "Try changing the slide..."
        ]
        notes: "once upon a time..."
    }

    Slide {
        title: "Second Example Slide"
        content: [
            "The text on the second window should now change",
            "The notes window shows plain text with plain line brakes only"
        ]
        notes:
"This is the second example slide...

This notes system uses the QtQuick.Window element to pop up a second window. Quite simple and quite convenient..."
    }

}
