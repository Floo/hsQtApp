TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc

OTHER_FILES += *.qml images/*.png \
    content/*.qml \
    content/LichtPage.qml \
    content/BewaesserungPage.qml \
    content/SzenePage.qml \
    content/JalousiePage.qml \
    content/SingleJalDelegate.qml \
    content/SingleJalModel.qml \
    javascript/hsClient.js \
    content/PanelBewaesserung.qml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)


