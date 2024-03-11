#ifndef CLOCKSENDER_H
#define CLOCKSENDER_H
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QtNetwork/QTcpServer>
#include <QtNetwork/QTcpSocket>
#include <QObject>
#include <QString>
#include <QDebug>
#include <QByteArray>
#include <QDateTime>

#define SERVER_PORT 42000

class ClockSender : public QObject
{
    Q_OBJECT

public:
    ClockSender(QObject *parent = nullptr);
private:
    QQmlApplicationEngine*  clockSenderEngine;
    QQmlContext*            clockSenderContext;
    QTcpSocket*             TcpSocket;

// signal
signals:
    void formatTimeFail();
    void connectToServerPortFail();
    void connectToServerPortSuccess();
    void cantSendMessage(QString);
    void sendMessageSuccess(QString);

// slots
public slots:
    void handleStringTime(QString);

// local function
public:
    void setQmlAppEngine(QQmlApplicationEngine *engine);
    void initApplication();
    bool checkFormatTime(QString);
};

#endif // CLOCKSENDER_H
