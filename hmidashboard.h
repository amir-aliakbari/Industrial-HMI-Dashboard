#pragma once

#include <QObject>
#include <QTimer>
#include <QRandomGenerator>

class HmiDashboard : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double current READ current NOTIFY valuesChanged)
    Q_PROPERTY(double voltage READ voltage NOTIFY valuesChanged)
    Q_PROPERTY(double temperature READ temperature NOTIFY valuesChanged)
    Q_PROPERTY(bool running READ running NOTIFY runningChanged)

public:
    explicit HmiDashboard(QObject *parent = nullptr);

    double current() const;
    double voltage() const;
    double temperature() const;
    bool running() const;

public slots:
    void start();
    void stop();
    void reset();
    void settings();

signals:
    void valuesChanged();
    void runningChanged();
    void settingsRequested();

private slots:
    void updateValues();

private:
    double m_current = 0.0;
    double m_voltage = 0.0;
    double m_temperature = 0.0;
    bool m_running = false;
    QTimer m_timer;
};
