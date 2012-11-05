import QtQuick 2.0

Slide {
    id: slide;

    property string codeFontFamily: "Courier New"
    property string code;
    property real codeFontSize: baseFontSize * 0.6;



    Rectangle {
        id: background
        anchors.fill: parent
        radius: height / 10;
        gradient: Gradient {
            GradientStop { position: 0; color: Qt.rgba(0.8, 0.8, 0.8, 0.5); }
            GradientStop { position: 1; color: Qt.rgba(0.2, 0.2, 0.2, 0.5); }
        }
        border.color: slide.slideTextColor;
        border.width: height / 250;
        antialiasing: true
    }

    onCodeChanged: {
        listModel.clear();
        var codeLines = slide.code.split("\n");
        for (var i=0; i<codeLines.length; ++i) {
            listModel.append({
                                line: i,
                                code: codeLines[i]
                             });
        }
    }



    ListModel {
        id: listModel
    }


    onVisibleChanged: {
        listView.focus = slide.visible;
        listView.currentIndex = -1;
    }

    ListView {
        id: listView;

        anchors.fill: parent;
        anchors.margins: background.radius / 2
        clip: true

        model: listModel;
        focus: true;

        MouseArea {
            anchors.fill: parent
            onClicked: {
                listView.focus = true;
                listView.currentIndex = listView.indexAt(mouse.x, mouse.y + listView.contentY);
            }

        }

        delegate: Item {

            id: itemDelegate

            height: lineLabel.height
            width: parent.width

            Rectangle {
                id: lineLabelBackground
                width: lineLabel.height * 3;
                height: lineLabel.height;
                color: slide.slideTextColor;
                opacity: 0.1;
            }

            Text {
                id: lineLabel
                anchors.right: lineLabelBackground.right;
                text: line + ":"
                color: slide.slideTextColor;
                font.family: slide.codeFontFamily
                font.pixelSize: slide.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem;
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.8;

            }

            Rectangle {
                id: lineContentBackground
                anchors.fill: lineContent;
                anchors.leftMargin: -height / 2;
                color: slide.slideTextColor
                opacity: 0.2
                visible: itemDelegate.ListView.isCurrentItem;
            }

            Text {
                id: lineContent
                anchors.left: lineLabelBackground.right
                anchors.leftMargin: lineContent.height;
                anchors.right: parent.right;
                color: slide.slideTextColor;
                text: code;
                font.family: slide.codeFontFamily
                font.pixelSize: slide.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem;
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.8;
            }
        }
    }



}
