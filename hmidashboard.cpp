#include "hmidashboard.h"

HmiDashboard::HmiDashboard(QObject *parent)
    : QObject(parent)
{
    m_timer.setInterval(500);
    connect(&m_timer, &QTimer::timeout, this, &HmiDashboard::updateValues);
}

double HmiDashboard::current() const
{
    return m_current;
}

double HmiDashboard::voltage() const
{
    return m_voltage;
}

double HmiDashboard::temperature() const
{
    return m_temperature;
}

bool HmiDashboard::running() const
{
    return m_running;
}

void HmiDashboard::start()
{
    if (!m_running) {
        m_running = true;
        emit runningChanged();
        m_timer.start();
    }
}

void HmiDashboard::stop()
{
    if (m_running) {
        m_running = false;
        emit runningChanged();
        m_timer.stop();
    }
}

void HmiDashboard::reset()
{
    stop();
    m_current = 0.0;
    m_voltage = 0.0;
    m_temperature = 0.0;
    emit valuesChanged();
}

void HmiDashboard::settings()
{
    emit settingsRequested();
}

void HmiDashboard::updateValues()
{
    auto *rng = QRandomGenerator::global();

    m_current = 9.0 + (12.5 - 9.0) * rng->generateDouble();
    m_voltage = 225.0 + (235.0 - 225.0) * rng->generateDouble();
    m_temperature = 55.0 + (75.0 - 55.0) * rng->generateDouble();

    emit valuesChanged();
}
