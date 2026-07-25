#include "calculator.h"

#include <QStringList>
#include <QStack>
#include <cmath>

Calculator::Calculator(QObject *parent)
    : QObject(parent)
    , m_display("0")
    , m_expression("")
{
}

QString Calculator::display() const
{
    return m_display;
}

QString Calculator::expression() const
{
    return m_expression;
}

void Calculator::setDisplay(const QString &text)
{
    if (m_display != text) {
        m_display = text;
        emit displayChanged(m_display);
    }
}

void Calculator::setExpression(const QString &text)
{
    if (m_expression != text) {
        m_expression = text;
        emit expressionChanged(m_expression);
    }
}

void Calculator::appendToDisplay(const QString &text)
{
    setDisplay(m_display + text);
}

void Calculator::digitPressed(const QString &digit)
{
    if (m_error) {
        clearPressed();
    }

    if (m_waitingForOperand) {
        setDisplay(digit);
        m_waitingForOperand = false;
    } else {
        if (m_display == "0") {
            setDisplay(digit);
        } else {
            appendToDisplay(digit);
        }
    }
}

void Calculator::decimalPressed()
{
    if (m_error) {
        clearPressed();
    }

    if (m_waitingForOperand) {
        setDisplay("0.");
        m_waitingForOperand = false;
        return;
    }

    if (!m_display.contains('.')) {
        appendToDisplay(".");
    }
}

void Calculator::operatorPressed(const QString &op)
{
    if (m_error) {
        m_error = false;
    }

    const double currentValue = m_display.toDouble();

    if (!m_pendingOperator.isEmpty()) {
        equalsPressed();
        if (m_error) {
            return;
        }
    } else {
        m_storedValue = currentValue;
    }

    m_pendingOperator = op;
    m_waitingForOperand = true;

    QString symbol = (op == "*") ? "×"
                    : (op == "/") ? "÷"
                    : (op == "-") ? "−"
                    : (op == "+") ? "+" : op;

    setExpression(QString::number(m_storedValue) + " " + symbol);
}

void Calculator::equalsPressed()
{
    if (m_error) {
        m_error = false;
    }

    if (m_pendingOperator.isEmpty()) {
        return;
    }

    const double currentValue = m_display.toDouble();
    double result = 0.0;

    if (m_pendingOperator == "+") {
        result = m_storedValue + currentValue;
    } else if (m_pendingOperator == "-") {
        result = m_storedValue - currentValue;
    } else if (m_pendingOperator == "*") {
        result = m_storedValue * currentValue;
    } else if (m_pendingOperator == "/") {
        if (currentValue == 0.0) {
            setDisplay("Error");
            setExpression("Cannot divide by zero");
            m_error = true;
            m_pendingOperator.clear();
            m_waitingForOperand = true;
            return;
        }
        result = m_storedValue / currentValue;
    }

    m_pendingOperator.clear();
    m_waitingForOperand = true;
    setExpression("");

    QString formatted = QString::number(result, 'g', 12);
    setDisplay(formatted);
    m_storedValue = result;
}

void Calculator::clearPressed()
{
    m_display = "0";
    m_expression = "";
    m_pendingOperator.clear();
    m_storedValue = 0.0;
    m_waitingForOperand = true;
    m_error = false;
    emit displayChanged(m_display);
    emit expressionChanged(m_expression);
}

void Calculator::clearEntryPressed()
{
    setDisplay("0");
    m_waitingForOperand = true;
}

void Calculator::backspacePressed()
{
    if (m_error || m_waitingForOperand) {
        return;
    }

    QString text = m_display;
    text.chop(1);
    if (text.isEmpty() || text == "-") {
        text = "0";
        m_waitingForOperand = true;
    }
    setDisplay(text);
}

void Calculator::signPressed()
{
    if (m_error || m_display == "0") {
        return;
    }

    if (m_display.startsWith('-')) {
        setDisplay(m_display.mid(1));
    } else {
        setDisplay("-" + m_display);
    }
}

void Calculator::percentPressed()
{
    if (m_error) {
        return;
    }

    const double value = m_display.toDouble() / 100.0;
    setDisplay(QString::number(value, 'g', 12));
    m_waitingForOperand = true;
}

void Calculator::squareRootPressed()
{
    if (m_error) {
        m_error = false;
    }

    const double value = m_display.toDouble();
    if (value < 0.0) {
        setDisplay("Error");
        setExpression("Invalid input");
        m_error = true;
        m_waitingForOperand = true;
        return;
    }

    const double result = std::sqrt(value);
    m_waitingForOperand = true;
    setExpression("√(" + QString::number(value, 'g', 12) + ")");
    setDisplay(QString::number(result, 'g', 12));
    m_storedValue = result;
}
