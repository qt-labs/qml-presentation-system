import Qt.labs.presentation 1.0
import QtQuick 2.0

OpacityTransitionPresentation
{
    Slide {
        id: slide1
        title: "Custom Transitions, 1"
        centeredText: "The Presentation {} Element has a 'switchSlides(from, to)' function which will be called whenever a transition between slides should take place."
    }

    Slide {
        title: "Custom Transitions, 2"
        centeredText:
            "Re-implement this function and add your own transition for the slides. "
    }

    Slide {
        title: "Custom Transitions, 3"
        content: [
            "In this transition we do",
            " 'from' slide gets",
            "  opacity fades out",
            "  scale increases slightly",
            " 'to' slide gets",
            "  opacity fades in",
            "  scale increases from small to normal",
            "All with a fairly simple ParallelAnimation {}"
        ]
    }

    Slide {
        title: "Custom Transition, 4"
        centeredText: "The transition works whichever way you go...\nLets go back to the beginning..."
    }

}
