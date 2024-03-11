#include "clocksender.h"

ClockSender::ClockSender(QObject *parent) : QObject(parent)
{
}
void ClockSender::setQmlAppEngine(QQmlApplicationEngine *engine)
{
    this->clockSenderEngine = engine;
}

void ClockSender::initApplication()
{
    this->clockSenderContext = this->clockSenderEngine->rootContext();
    const QUrl url(QStringLiteral("qrc:/Resource/main.qml"));
    this->clockSenderEngine->load(url);
    if(this->clockSenderEngine->rootObjects().isEmpty())
        return;
    this->clockSenderContext->setContextProperty("LockSender", this);

    QObject *cSender = clockSenderEngine->rootObjects().first()->findChild<QObject*>("QMLSender");
    QObject::connect(cSender, SIGNAL(sendTime(QString)), this, SLOT(handleStringTime(QString)));

    // init Socket
    TcpSocket = new QTcpSocket();

    // connect to server tcp port 42000
    TcpSocket->connectToHost(QHostAddress::LocalHost, SERVER_PORT);
    TcpSocket->open(QIODevice::ReadWrite);
    if(TcpSocket->isOpen())
    {
        emit connectToServerPortSuccess();
    }
    else
    {
        emit connectToServerPortFail();
    }
}



bool ClockSender::checkFormatTime(QString formatString)
{
    // format 'HH:mm:ss'
    QString format = "HH:mm:ss";

    // convert to dateTime
    QDateTime dateTime = QDateTime::fromString(formatString, format);

    // check valid
    return dateTime.isValid();
}

void ClockSender::handleStringTime(QString strTime)
{
    if(!checkFormatTime(strTime))
        emit formatTimeFail();
    else
    {
        if(this->TcpSocket)
        {
            if(this->TcpSocket->isOpen())
            {
                this->TcpSocket->write(strTime.toStdString().c_str());
                emit sendMessageSuccess(strTime);
            }
            else
            {
                emit cantSendMessage(strTime);
            }
        }
        else
        {
            emit cantSendMessage(strTime);
        }
    }
}
