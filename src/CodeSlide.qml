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

import QtQuick 2.0

Slide {
    id: slide;

    property string codeFontFamily: parent.codeFontFamily;
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
        border.color: slide.textColor;
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
                color: slide.textColor;
                opacity: 0.1;
            }

            Text {
                id: lineLabel
                anchors.right: lineLabelBackground.right;
                text: (line+1) + ":"
                color: slide.textColor;
                font.family: slide.codeFontFamily
                font.pixelSize: slide.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem;
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9;

            }

            Rectangle {
                id: lineContentBackground
                anchors.fill: lineContent;
                anchors.leftMargin: -height / 2;
                color: slide.textColor
                opacity: 0.2
                visible: itemDelegate.ListView.isCurrentItem;
            }

            Text {
                id: lineContent
                anchors.left: lineLabelBackground.right
                anchors.leftMargin: lineContent.height;
                anchors.right: parent.right;
                color: slide.textColor;
                text: code;
                font.family: slide.codeFontFamily
                font.pixelSize: slide.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem;
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9;
            }
        }
    }



}
