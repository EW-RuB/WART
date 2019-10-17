# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'LogWindow.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_LogWindow(object):
    def setupUi(self, LogWindow):
        LogWindow.setObjectName(_fromUtf8("LogWindow"))
        LogWindow.resize(800, 480)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(LogWindow.sizePolicy().hasHeightForWidth())
        LogWindow.setSizePolicy(sizePolicy)
        LogWindow.setMinimumSize(QtCore.QSize(800, 480))
        LogWindow.setMaximumSize(QtCore.QSize(800, 480))
        LogWindow.setStyleSheet(_fromUtf8("QDialog{ background-color: #2b2b2b; }\n"
"\n"
"QPushButton{ border: 2px solid #5f5f5f;\n"
"                            border-radius: 5px;\n"
"                            color: #b6b9b8; \n"
"                            border-style: outset; }\n"
"\n"
"QPushButton:hover:!pressed{\n"
"                            border-color: #7a8084;\n"
"                            background-color: #555a5c;\n"
"}\n"
"\n"
"QLabel { color: #b6b9b8;  }\n"
"\n"
"QTableWidget { background-color: #ededed;\n"
"                            gridline-color: #959ca1;\n"
"                            border-radius: 4px;\n"
"                            border: none; }\n"
"\n"
"QHeaderView::section {\n"
"    background-color: #2b2b2b;\n"
"    color:  #b6b9b8;\n"
"    padding: 4px;\n"
"    border: 1px solid #3c3f41;\n"
"}\n"
"\n"
"     QTableWidget QTableCornerButton::section {\n"
"         background-color: #2b2b2b;\n"
"        border: 1px solid #3c3f41;\n"
"        /*border-radius: 4px;*/\n"
"     }\n"
"\n"
"QTableWidget::item:selected{ background-color: #4cda43 }"))
        self.btn_close = QtGui.QPushButton(LogWindow)
        self.btn_close.setGeometry(QtCore.QRect(350, 430, 85, 27))
        self.btn_close.setObjectName(_fromUtf8("btn_close"))
        self.label = QtGui.QLabel(LogWindow)
        self.label.setGeometry(QtCore.QRect(50, 30, 621, 17))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(True)
        font.setWeight(75)
        self.label.setFont(font)
        self.label.setObjectName(_fromUtf8("label"))
        self.textBrowser = QtGui.QTextBrowser(LogWindow)
        self.textBrowser.setGeometry(QtCore.QRect(50, 70, 700, 331))
        self.textBrowser.setObjectName(_fromUtf8("textBrowser"))

        self.retranslateUi(LogWindow)
        QtCore.QMetaObject.connectSlotsByName(LogWindow)

    def retranslateUi(self, LogWindow):
        LogWindow.setWindowTitle(_translate("LogWindow", "Implementierte Simulationen", None))
        self.btn_close.setText(_translate("LogWindow", "Schließen", None))
        self.label.setText(_translate("LogWindow", "Log-Fenster:", None))

