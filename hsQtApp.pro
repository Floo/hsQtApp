TEMPLATE = app

QT += qml quick widgets
QT += sql network

SOURCES += main.cpp \
    appsettings.cpp

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
    javascript/storage.js \
    content/Logfile.qml \
    content/InfoElement.qml \
    android/AndroidManifest.xml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

#Version numbering
#VERSION = $$system(svn info -r HEAD . | grep 'Changed\ Rev' | cut -b 19-)
#VERSION = $$system(git rev-list HEAD --count)
VERSION = 12
!isEmpty(VERSION){
   VERSION = 0.$${VERSION}
}

VERSTR = '\\"$${VERSION}\\"'  # place quotes around the version string
DEFINES += VER=\"$${VERSTR}\" # create a VER macro containing the version string

HEADERS += \
    appsettings.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android


