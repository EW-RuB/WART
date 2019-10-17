/********************************************************************************
** Form generated from reading UI file 'startdialog.ui'
**
** Created by: Qt User Interface Compiler version 4.8.7
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_STARTDIALOG_H
#define UI_STARTDIALOG_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QDialog>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>

QT_BEGIN_NAMESPACE

class Ui_StartDialog
{
public:
    QPushButton *btn_demo;
    QPushButton *btn_expert;
    QLabel *label;

    void setupUi(QDialog *StartDialog)
    {
        if (StartDialog->objectName().isEmpty())
            StartDialog->setObjectName(QString::fromUtf8("StartDialog"));
        StartDialog->resize(550, 400);
        StartDialog->setStyleSheet(QString::fromUtf8("QDialog{ background-color: #2b2b2b; }\n"
"\n"
"QPushButton{ border: 2px solid #5f5f5f;\n"
"							border-radius: 5px;\n"
"							color: #b6b9b8; \n"
"							border-style: outset; }\n"
"\n"
"QPushButton:hover:!pressed{\n"
"							border-color: #7a8084;\n"
"							background-color: #555a5c;\n"
"}\n"
"\n"
"QLabel { color: #b6b9b8;  }\n"
"\n"
"QTableWidget { background-color: #ededed;\n"
"							gridline-color: #959ca1;\n"
"							border-radius: 4px;\n"
"							border: none; }\n"
"\n"
"QHeaderView::section {\n"
"    background-color: #2b2b2b;\n"
"	color:  #b6b9b8;\n"
"    padding: 4px;\n"
"    border: 1px solid #3c3f41;\n"
"}\n"
"\n"
"     QTableWidget QTableCornerButton::section {\n"
"         background-color: #2b2b2b;\n"
"		border: 1px solid #3c3f41;\n"
"		/*border-radius: 4px;*/\n"
"     }\n"
"\n"
"QTableWidget::item:selected{ background-color: #4cda43 }"));
        btn_demo = new QPushButton(StartDialog);
        btn_demo->setObjectName(QString::fromUtf8("btn_demo"));
        btn_demo->setGeometry(QRect(170, 150, 190, 60));
        QFont font;
        font.setPointSize(12);
        font.setBold(true);
        font.setWeight(75);
        btn_demo->setFont(font);
        btn_expert = new QPushButton(StartDialog);
        btn_expert->setObjectName(QString::fromUtf8("btn_expert"));
        btn_expert->setGeometry(QRect(170, 260, 190, 60));
        btn_expert->setFont(font);
        label = new QLabel(StartDialog);
        label->setObjectName(QString::fromUtf8("label"));
        label->setGeometry(QRect(40, 70, 470, 30));
        QFont font1;
        font1.setPointSize(14);
        font1.setBold(true);
        font1.setWeight(75);
        label->setFont(font1);
        label->setAlignment(Qt::AlignCenter);

        retranslateUi(StartDialog);

        QMetaObject::connectSlotsByName(StartDialog);
    } // setupUi

    void retranslateUi(QDialog *StartDialog)
    {
        StartDialog->setWindowTitle(QApplication::translate("StartDialog", "Reflexion und Brechung ebener Wellen", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        btn_demo->setToolTip(QApplication::translate("StartDialog", "Einfacher Modus ( Frequenz-Sweep nicht m\303\266glich )", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        btn_demo->setText(QApplication::translate("StartDialog", "Demo-Mode", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        btn_expert->setToolTip(QApplication::translate("StartDialog", "Materialeigenschaften werden aus einer Datenbank eingelesen ( mit Frequenz-Sweep )", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        btn_expert->setText(QApplication::translate("StartDialog", "Advanced-Mode", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("StartDialog", "Bitte w\303\244hlen Sie den gew\303\274nschten Modus:", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class StartDialog: public Ui_StartDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_STARTDIALOG_H
