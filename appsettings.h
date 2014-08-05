#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QObject>
#include <QString>

class AppSettings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString version READ version WRITE setVersion NOTIFY versionChanged)
    Q_PROPERTY(QString builddate READ builddate)
    Q_PROPERTY(QString buildtime READ buildtime)
public:
    explicit AppSettings(QObject *parent = 0);
    //virtual ~AppSettings();
    void setVersion(QString a);
    QString version();
    QString buildtime();
    QString builddate();

signals:
    void versionChanged();
private:
    QString m_version;
    QString m_builddate;
    QString m_buildtime;
};

#endif // APPSETTINGS_H

