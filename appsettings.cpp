#include "appsettings.h"

AppSettings::AppSettings(QObject *parent) : QObject(parent) {
    m_version = VER;
    m_builddate = __DATE__;
    m_buildtime = __TIME__;
}

void AppSettings::setVersion(QString a) {
    if (a != m_version) {
        m_version = a;
        emit versionChanged();
    }
}

QString AppSettings::version() {
    return m_version;
}

QString AppSettings::builddate() {
    return m_builddate;
}

QString AppSettings::buildtime() {
    return m_buildtime;
}
