import QtQuick 2.0

Item {
    id: slide

    property bool isSlide: true;

    property string title;
    property variant content: []
    property string centeredText

    property real fontSize: parent.height * 0.05
    property real fontScale: 1

    property real baseFontSize: fontSize * fontScale
    property real titleFontSize: fontSize * 1.2 * fontScale
    property real bulletSpacing: 1

    property real contentWidth: width

    // Define the slide to be the "content area"
    x: parent.width * 0.05
    y: parent.height * 0.2
    width: parent.width * 0.9
    height: parent.height * 0.7

    property real masterWidth: parent.width
    property real masterHeight: parent.height

    property color slideTextColor: parent.textColor != undefined ? parent.textColor : "black"

    visible: false

    Text {
        id: titleText
        font.pixelSize: titleFontSize
        text: title;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        anchors.bottomMargin: parent.fontSize * 1.5
        font.bold: true;
        color: slideTextColor
        horizontalAlignment: Text.Center
        z: 1
    }

    Text {
        id: centeredId
        width: parent.width
        anchors.centerIn: parent
        anchors.verticalCenterOffset: - parent.y / 3
        text: centeredText
        horizontalAlignment: Text.Center
        font.pixelSize: baseFontSize
        color: slideTextColor
        wrapMode: Text.Wrap
    }

    Column {
        id: contentId
        anchors.fill: parent

        Repeater {
            model: content.length

            Row {
                id: row

                function decideIndentLevel(s) { return s.charAt(0) == " " ? 1 + decideIndentLevel(s.substring(1)) : 0 }
                property int indentLevel: decideIndentLevel(content[index])
                property int nextIndentLevel: index < content.length - 1 ? decideIndentLevel(content[index+1]) : 0
                property real indentFactor: (10 - row.indentLevel * 2) / 10;

                height: text.height + (nextIndentLevel == 0 ? 1 : 0.3) * slide.baseFontSize * slide.bulletSpacing
                x: slide.baseFontSize * indentLevel

                Rectangle {
                    id: dot
                    y: baseFontSize * row.indentFactor / 2
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
                    width: slide.contentWidth - parent.x - dot.width - space.width
                    font.pixelSize: baseFontSize * row.indentFactor
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
