#ifndef PIHOLE_API_H
#define PIHOLE_API_H

#pragma once
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class PiholeApi : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString sid READ sid NOTIFY sidChanged)
    Q_PROPERTY(QString sid READ sid NOTIFY sidChanged)
    Q_PROPERTY(QString baseUrl READ baseUrl WRITE setBaseUrl NOTIFY baseUrlChanged)

public:
    explicit PiholeApi(QObject *parent = nullptr);
    Q_INVOKABLE void login(const QString &password);
    Q_INVOKABLE void logout();
    Q_INVOKABLE void fetchStats(qint64 until, qint64 from);
    Q_INVOKABLE void fetchTopClients();
    Q_INVOKABLE void fetchTopClientsBlocked();
    Q_INVOKABLE void fetchTopDomains();
    Q_INVOKABLE void fetchTopDomainsBlocked();
    Q_INVOKABLE void populateClientGraph();
    Q_INVOKABLE void populateDomainGraph();
    Q_INVOKABLE void fetchLists();
    Q_INVOKABLE void fetchLogs();
    Q_INVOKABLE void deleteList(QString list, QString type);
    Q_INVOKABLE void addList(QString url, QString comment, QString group, QString type);
    QString sid() const { return m_sid; }
    QString baseUrl() const { return m_baseUrl; }
    void setBaseUrl(const QString &url);

signals:
    void sidChanged();
    void statsReady(QVariantMap data);
    void loginFailed(QString error);
    void topClientsReady(QVariantMap data);
    void topDomainsReady(QVariantMap data);
    void topClientsBlockedReady(QVariantMap data);
    void topDomainsBlockedReady(QVariantMap data);
    void populateClientGraphReady(QVariantMap data);
    void populateDomainGraphReady(QVariantMap data);
    void fetchListsReady(QVariantMap data);
    void logsReady(QVariantMap data);
    void deletedList();
    void listAdded();
    void listFailed2Add(QString error);
    void baseUrlChanged();

private:
    QNetworkAccessManager *m_manager;
    QString m_sid;
    QString m_baseUrl;
};

#endif // PIHOLE_API_H
