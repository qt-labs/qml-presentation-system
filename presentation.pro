TARGETPATH=Qt/labs/presentation
TEMPLATE=lib

CONFIG += plugin

qmldir.files += \
    src/qmldir \
    src/CodeSlide.qml \
    src/Presentation.qml \
    src/Slide.qml 

qmldir.path +=  $$[QT_INSTALL_IMPORTS]/$$TARGETPATH

INSTALLS += qmldir



