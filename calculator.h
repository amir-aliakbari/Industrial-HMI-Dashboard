#pragma once

#include <QObject>
#include <QString>

class Calculator : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString display READ display NOTIFY displayChanged)
    Q_PROPERTY(QString expression READ expression NOTIFY expressionChanged)

public:
    explicit Calculator(QObject *parent = nullptr);

    QString display() const;
    QString expression() const;

public slots:
    void digitPressed(const QString &digit);
    void operatorPressed(const QString &op);
    void decimalPressed();
    void equalsPressed();
    void clearPressed();
    void clearEntryPressed();
    void backspacePressed();
    void signPressed();
    void percentPressed();
    void squareRootPressed();

signals:
    void displayChanged(const QString &display);
    void expressionChanged(const QString &expression);
    void errorOccurred(const QString &message);

private:
    bool evaluate();
    void appendToDisplay(const QString &text);
    void setDisplay(const QString &text);
    void setExpression(const QString &text);

    QString m_display;
    QString m_expression;
    QString m_pendingOperator;
    double m_storedValue = 0.0;
    bool m_waitingForOperand = true;
    bool m_error = false;
};
