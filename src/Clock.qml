import QtQuick 2.0

Text {
    id: clock

    property real fontSize: parent.height * 0.05
    property real fontScale: 0.5
    property color textColor: parent.textColor != undefined ? parent.textColor : "black"
    property string fontFamily: parent.fontFamily != undefined ? parent.fontFamily : "Helvetica"

    text: currentTime();

    function currentTime() {
        var d = new Date();
        var m = d.getMinutes();
        if (m < 10) m = "0" + m;
        return d.getHours() + ":" + m;
    }

    color: textColor;
    font.family: fontFamily;
    font.pixelSize: fontSize * fontScale;

    anchors.bottom: parent.bottom;
    anchors.left: parent.left;
    anchors.margins: font.pixelSize;

    Timer {
        interval: 60000;
        repeat: true;
        running: true
        onTriggered: clock.text = clock.currentTime();
    }
}
