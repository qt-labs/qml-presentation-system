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
import Qt.labs.presentation 1.0

Presentation {

    id: deck

    width: 1280
    height: 720

    property color textColor: "white"

    property bool inTransition: false;

    property variant fromSlide;
    property variant toSlide;

    property int transitionTime: 500;

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "lightsteelblue" }
            GradientStop { position: 1; color: "black" }
        }
    }

    SequentialAnimation {
        id: forwardTransition
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 1.1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: toSlide; property: "scale"; from: 0.7; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: fromSlide; property: "scale"; value: 1 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
    }
    SequentialAnimation {
        id: backwardTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 0.7; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: toSlide; property: "scale"; from: 1.1; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: fromSlide; property: "scale"; value: 1 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
    }

    function switchSlides(from, to, forward)
    {
        if (deck.inTransition)
            return false

        deck.fromSlide = from
        deck.toSlide = to

        if (forward)
            forwardTransition.running = true
        else
            backwardTransition.running = true

        return true
    }
}
