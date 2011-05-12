   import QtQuick 2.0

ShaderEffectItem {
    id: shader

    width: parent.width
    height: 100

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

    property variant colorTable

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
    uniform highp mat4 qt_ModelViewProjectionMatrix;
    attribute highp vec4 qt_Vertex;
    attribute highp vec2 qt_MultiTexCoord0;
    varying highp vec2 qt_TexCoord0;

    void main() {
        highp vec4 pos = qt_Vertex;

        highp float y1 = sin(tx + d.x * qt_MultiTexCoord0.x * 17. + 2. * d.y) + sin(ty + d.z * qt_MultiTexCoord0.x * 11. + 5. * d.w);
        highp float y2 = sin(tz + d.w * qt_MultiTexCoord0.x * 7. + 3. * d.z) + sin(tw + d.y * qt_MultiTexCoord0.x * 19. + 3. * d.x);

        pos.y += mix(y1, y2, qt_MultiTexCoord0.y) * amplitude * 0.5;

        gl_Position = qt_ModelViewProjectionMatrix * pos;
        qt_TexCoord0 = qt_MultiTexCoord0;
    }
    "

    mesh: GridMesh { resolution: Qt.size(width / 10, 4) }

}
