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

ShaderEffect {
    id: shader

    width: 400
    height: 300

    property real speed: 1

    property color d: Qt.rgba(Math.random() * 0.7,
                              Math.random() * 0.5,
                              Math.random() * 0.7,
                              Math.random() * 0.5)
    property real tx
    NumberAnimation on tx { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }
    property real ty
    NumberAnimation on ty { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }
    property real tz
    NumberAnimation on tz { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }
    property real tw
    NumberAnimation on tw { from: 0; to: Math.PI * 2; duration: (Math.random() * 30 + 30) * 1000 / speed; loops: Animation.Infinite }

    property real amplitude: height / 2

    property variant colorTable: ShaderEffectSource { sourceItem: Rectangle { width: 4; height: 4; color: "steelblue" } }

    fragmentShader: "
    uniform lowp float qt_Opacity;
    uniform lowp sampler2D colorTable;
    varying highp vec2 qt_TexCoord0;

    void main() {
        gl_FragColor = texture2D(colorTable, qt_TexCoord0);
        gl_FragColor.w *= qt_Opacity;
    }
    "

    vertexShader: "
    uniform lowp vec4 d;
    uniform highp float tx;
    uniform highp float ty;
    uniform highp float tz;
    uniform highp float tw;
    uniform highp float amplitude;
    uniform highp mat4 qt_Matrix;
    attribute highp vec4 qt_Vertex;
    attribute highp vec2 qt_MultiTexCoord0;
    varying highp vec2 qt_TexCoord0;

    void main() {
        highp vec4 pos = qt_Vertex;

        highp float y1 = sin(tx + d.x * qt_MultiTexCoord0.x * 17. + 2. * d.y) + sin(ty + d.z * qt_MultiTexCoord0.x * 11. + 5. * d.w);
        highp float y2 = sin(tz + d.w * qt_MultiTexCoord0.x * 7. + 3. * d.z) + sin(tw + d.y * qt_MultiTexCoord0.x * 19. + 3. * d.x);

        pos.y += mix(y1, y2, qt_MultiTexCoord0.y) * amplitude * 0.5;

        gl_Position = qt_Matrix * pos;
        qt_TexCoord0 = qt_MultiTexCoord0;
    }
    "

    mesh: GridMesh { resolution: Qt.size(width / 10, 4) }

}
