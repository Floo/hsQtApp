TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc

OTHER_FILES += *.qml content/*.png \
    ButtonMeth.qml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

target.path = d:/Privat/Entwicklung/Meth9/
INSTALLS += target
