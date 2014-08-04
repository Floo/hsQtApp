TEMPLATE = app

QT += qml quick widgets
QT += sql

SOURCES += main.cpp

RESOURCES += qml.qrc

OTHER_FILES += *.qml images/*.png \
    content/*.qml \
    content/LichtPage.qml \
    content/BewaesserungPage.qml \
    content/SzenePage.qml \
    content/JalousiePage.qml \
    content/SingleJalModel.qml \
    javascript/hsClient.js \
    content/PanelBewaesserung.qml \
    content/JalousieSetup.qml \
    content/AbluftSetup.qml \
    content/BewaesserungSetup.qml \
    content/SystemSetup.qml \
    content/SetupCheckbox.qml \
    content/TimePicker.qml \
    content/TimePickerDialog.qml \
    content/TimePickerSASUDialog.qml \
    content/SASUPicker.qml \
    content/SetupValue.qml \
    content/ValuePickerDialog.qml \
    content/TextDialog.qml \
    content/ListViewDelegate.qml \
    javascript/global.js \
    javascript/storage.js

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)


