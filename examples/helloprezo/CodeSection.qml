import QtQuick 2.0

Rectangle
{
    id: root

    property string text
    property real fontSize: parent.baseFontSize / 2

    gradient: Gradient {
        GradientStop { position: 0; color: "white" }
        GradientStop { position: 1; color: "darkGray" }
    }

    color: "lightGray"
    border.color: "darkGray"
    border.width: 2
    radius: 10

    x: parent.width / 2
    width: parent.width / 2
    height: parent.height

    Text {
        id: textItem
        anchors.fill: parent
        anchors.margins: 20
        text: root.text;
        font.family: "courier"
        font.pixelSize: root.fontSize
    }

}
