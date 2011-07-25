/***************************************************************************
**
** This file is part of the QML Presentation System **
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

import QtQuick 1.0

Item {
    id: root

    property variant slides: []
    property int currentSlide;

    property bool faded: false

    property int userNum;

    Component.onCompleted: {
        var slideCount = 0;
        var slides = [];
        for (var i=0; i<root.resources.length; ++i) {
            var r = root.resources[i];
            if (r.isSlide) {
                slides.push(r);
            }
        }

        root.slides = slides;
        root.userNum = 0;

        // Make first slide visible...
        if (root.slides.length > 0) {
            root.currentSlide = 0;
            root.slides[root.currentSlide].visible = true;
        }
    }

    function switchSlides(from, to) {
        from.visible = false
        to.visible = true
        return true
    }

    function goToNextSlide() {
        root.userNum = 0
        if (faded)
            return
        if (root.currentSlide + 1 < root.slides.length) {
            var from = slides[currentSlide]
            var to = slides[currentSlide + 1]
            if (switchSlides(from, to)) {
                currentSlide = currentSlide + 1;
                root.focus = true;
            }
        }
    }

    function goToPreviousSlide() {
        root.userNum = 0
        if (root.faded)
            return
        if (root.currentSlide - 1 >= 0) {
            var from = slides[currentSlide]
            var to = slides[currentSlide - 1]
           if (switchSlides(from, to)) {
                currentSlide = currentSlide - 1;
               root.focus = true;
           }
        }
    }

    function goToUserSlide() {
        --userNum;
        if (root.faded || userNum >= root.slides.length)
            return
        if (userNum < 0)
            goToNextSlide()
        else if (root.currentSlide != userNum) {
            var from = slides[currentSlide]
            var to = slides[userNum]
           if (switchSlides(from, to)) {
                currentSlide = userNum;
               root.focus = true;
           }
        }
    }

    focus: true

    Keys.onSpacePressed: goToNextSlide()
    Keys.onRightPressed: goToNextSlide()
    Keys.onDownPressed: goToNextSlide()
    Keys.onLeftPressed: goToPreviousSlide()
    Keys.onUpPressed: goToPreviousSlide()
    Keys.onEscapePressed: Qt.quit()
    Keys.onPressed: {
        if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9)
            userNum = 10 * userNum + (event.key - Qt.Key_0)
        else {
            if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter)
                goToUserSlide();
            else if (event.key == Qt.Key_Backspace)
                goToPreviousSlide();
            else if (event.key == Qt.Key_C)
                root.faded = !root.faded;
            userNum = 0;
        }
    }

    Rectangle {
        z: 1000
        color: "black"
        anchors.fill: parent
        opacity: root.faded ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.RightButton)
                goToPreviousSlide()
            else
                goToNextSlide()
        }
    }
}
