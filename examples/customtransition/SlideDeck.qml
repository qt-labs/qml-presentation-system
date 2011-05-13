import Prezo 1.0
import QtQuick 2.0

DissolvingPresentation
{
    Slide {
        id: slide1
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
        Image {
            source: "distortion.png"
            smooth: true

            x: parent.contentX
            y: parent.contentY
            width: parent.contentWidth
            height: parent.contentHeight
        }
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
