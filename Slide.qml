import QtQuick 2.0

Item {
    id: slide

    property bool isSlide: true;

    property string title;
    property variant content: []
    property string centeredText

    property real titleFontSize: parent.height * 0.06
    property real baseFontSize: parent.height * 0.05

    property real contentX: parent.width * 0.05
    property real contentY: parent.height * 0.2
    property real contentWidth: parent.width * 0.9
    property real contentHeight: parent.height * 0.7

    property color slideTextColor: parent.textColor != undefined ? parent.textColor : "black"

    width: parent.width
    height: parent.height

    opacity: 0

    Text {
        id: titleText
        font.pixelSize: titleFontSize
        text: title;
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: parent.width * 0.01
        anchors.leftMargin: parent.width * 0.01
        anchors.rightMargin: parent.width * 0.01
        font.bold: true;
        color: slideTextColor
    }

    Text {
        id: centeredId
        anchors.verticalCenter: parent.verticalCenter
        x: slide.contentX
        width: slide.contentWidth
        text: centeredText
        horizontalAlignment: Text.Center
        font.pixelSize: baseFontSize
        color: slideTextColor
        wrapMode: Text.Wrap
    }

    Column {
        id: contentId
        x: slide.contentX
        y: slide.contentY
        width: slide.contentHeight
        height: slide.contentHeight

        Repeater {
            model: content.length

            Row {

                height: baseFontSize * 2

                Rectangle {
                    id: dot
                    y: baseFontSize / 2
                    width: baseFontSize / 4
                    height: baseFontSize / 4
                    color: slide.slideTextColor
                    radius: width / 2
                    smooth: true
                    opacity: text.text.length == 0 ? 0 : 1
                }

                Rectangle {
                    id: space
                    width: dot.width * 2
                    height: 1
                    color: "#00ffffff"
                }

                Text {
                    id: text
                    width: slide.contentWidth
                    font.pixelSize: baseFontSize
                    text: content[index]
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    color: slide.slideTextColor
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
    }

}
