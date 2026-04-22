#include "pihole_api.h"
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>

PiholeApi::PiholeApi(QObject *parent)
    : QObject(parent)
    , m_manager(new QNetworkAccessManager(this))
{}

void PiholeApi::setBaseUrl(const QString &url) {
    m_baseUrl = "http://" + url;
    emit PiholeApi::baseUrlChanged();
}

void PiholeApi::login(const QString &password) {
    QNetworkRequest request(QUrl(m_baseUrl + "/api/auth"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject body;
    body["password"] = password;

    auto *reply = m_manager->post(request, QJsonDocument(body).toJson());
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(reply->readAll());
            m_sid = doc["session"]["sid"].toString();
            emit sidChanged();
        } else {
            emit loginFailed(reply->errorString());
        }
        reply->deleteLater();
    });
}

void PiholeApi::logout() {
    QNetworkRequest request(QUrl(m_baseUrl + "/api/auth"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    m_manager->deleteResource(request);
    emit sidChanged();
}


void PiholeApi::fetchStats(qint64 until, qint64 from) {
    QNetworkRequest request(QUrl(m_baseUrl + "/api/stats/summary?from=" + QString::number(from) + "&until=" + QString::number(until)));
    request.setRawHeader("sid", m_sid.toUtf8());

    auto *reply = m_manager -> get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        QByteArray response = reply->readAll();
        if (reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(response);
            emit statsReady(doc.object().toVariantMap());
        }
        reply->deleteLater();
    });
}

void PiholeApi::fetchTopClients() {
    qint64 until = QDateTime(QDate::currentDate(), QTime(23, 59, 59)).toSecsSinceEpoch();
    qint64 from = QDateTime(QDate::currentDate(), QTime(0, 0, 0)).toSecsSinceEpoch();
    QNetworkRequest request(QUrl(m_baseUrl + "/api/stats/top_clients?from=" + QString::number(from) + "&until=" + QString::number(until)));
    request.setRawHeader("sid", m_sid.toUtf8());

    auto *reply = m_manager -> get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        QByteArray response = reply->readAll();
        if (reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(response);
            emit topClientsReady(doc.object().toVariantMap());
        }
        reply->deleteLater();
    });
}

void PiholeApi::fetchTopClientsBlocked() {
    qint64 until = QDateTime(QDate::currentDate(), QTime(23, 59, 59)).toSecsSinceEpoch();
    qint64 from = QDateTime(QDate::currentDate(), QTime(0, 0, 0)).toSecsSinceEpoch();
    QNetworkRequest request(QUrl(m_baseUrl + "/api/stats/top_clients?from=" + QString::number(from) + "&until=" + QString::number(until) + "&blocked=true"));
    request.setRawHeader("sid", m_sid.toUtf8());

    auto *reply = m_manager -> get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        QByteArray response = reply->readAll();
        if (reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(response);
            emit topClientsBlockedReady(doc.object().toVariantMap());
        }
        reply->deleteLater();
    });
}

void PiholeApi::fetchTopDomains() {
    qint64 until = QDateTime(QDate::currentDate(), QTime(23, 59, 59)).toSecsSinceEpoch();
    qint64 from = QDateTime(QDate::currentDate(), QTime(0, 0, 0)).toSecsSinceEpoch();
    QNetworkRequest request(QUrl(m_baseUrl + "/api/stats/top_domains?from=" + QString::number(from) + "&until=" + QString::number(until)));
    request.setRawHeader("sid", m_sid.toUtf8());

    auto *reply = m_manager -> get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        QByteArray response = reply->readAll();
        if (reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(response);
            emit topDomainsReady(doc.object().toVariantMap());
        }
        reply->deleteLater();
    });
}

void PiholeApi::fetchTopDomainsBlocked() {
    qint64 until = QDateTime(QDate::currentDate(), QTime(23, 59, 59)).toSecsSinceEpoch();
    qint64 from = QDateTime(QDate::currentDate(), QTime(0, 0, 0)).toSecsSinceEpoch();
    QNetworkRequest request(QUrl(m_baseUrl + "/api/stats/top_domains?from=" + QString::number(from) + "&until=" + QString::number(until) + "&blocked=true"));
    request.setRawHeader("sid", m_sid.toUtf8());

    auto *reply = m_manager -> get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        QByteArray response = reply->readAll();
        if (reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(response);
            emit topDomainsBlockedReady(doc.object().toVariantMap());
        }
        reply->deleteLater();
    });
}

void PiholeApi::populateClientGraph() {
    QNetworkRequest request(QUrl(m_baseUrl + "/api/history/clients?N=0"));
    request.setRawHeader("sid", m_sid.toUtf8());

    auto *reply = m_manager -> get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply] {
        QByteArray response = reply->readAll();
        if(reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(response);
            emit populateClientGraphReady(doc.object().toVariantMap());
        }
        reply->deleteLater();
    });
}

void PiholeApi::populateDomainGraph() {
    QNetworkRequest request(QUrl(m_baseUrl + "/api/history"));
    request.setRawHeader("sid", m_sid.toUtf8());

    auto *reply = m_manager -> get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply] {
        QByteArray response = reply->readAll();
        if(reply->error() == QNetworkReply::NoError) {
            auto doc = QJsonDocument::fromJson(response);
            emit populateDomainGraphReady(doc.object().toVariantMap());
        }
        reply->deleteLater();
    });
}
