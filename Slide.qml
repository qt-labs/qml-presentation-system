import QtQuick 2.0

Rectangle {

    property bool isSlide: true;

    width: 540
    height: 360

    opacity: 0

    color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1);

    Text {
        anchors.centerIn: parent
        font.pixelSize: 20 + Math.random() * 20
        rotation: Math.random() * 40 - 20;
        text: "This is a slide"
    }
}
