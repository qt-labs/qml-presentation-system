TARGETPATH=Qt/labs/presentation
TEMPLATE=lib

CONFIG += plugin

qmldir.files += \
    src/qmldir \
    src/Clock.qml \
    src/CodeSlide.qml \
    src/Presentation.qml \
    src/Slide.qml \
    src/SlideCounter.qml

qmldir.path +=  $$[QT_INSTALL_QML]/$$TARGETPATH

INSTALLS += qmldir





