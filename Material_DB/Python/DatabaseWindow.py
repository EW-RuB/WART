# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'DatabaseWindow.ui'
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

class Ui_Database(object):
    def setupUi(self, Database):
        Database.setObjectName(_fromUtf8("Database"))
        Database.resize(1000, 600)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Database.sizePolicy().hasHeightForWidth())
        Database.setSizePolicy(sizePolicy)
        Database.setMinimumSize(QtCore.QSize(1000, 600))
        Database.setMaximumSize(QtCore.QSize(1000, 600))
        self.tableWidget = QtGui.QTableWidget(Database)
        self.tableWidget.setGeometry(QtCore.QRect(50, 150, 900, 350))
        self.tableWidget.setSelectionBehavior(QtGui.QAbstractItemView.SelectRows)
        self.tableWidget.setObjectName(_fromUtf8("tableWidget"))
        self.tableWidget.setColumnCount(0)
        self.tableWidget.setRowCount(0)
        self.label = QtGui.QLabel(Database)
        self.label.setGeometry(QtCore.QRect(200, 20, 571, 31))
        font = QtGui.QFont()
        font.setPointSize(16)
        font.setBold(True)
        font.setWeight(75)
        self.label.setFont(font)
        self.label.setAlignment(QtCore.Qt.AlignCenter)
        self.label.setObjectName(_fromUtf8("label"))
        self.refresh_btn = QtGui.QPushButton(Database)
        self.refresh_btn.setGeometry(QtCore.QRect(50, 540, 151, 31))
        self.refresh_btn.setObjectName(_fromUtf8("refresh_btn"))
        self.enter_btn = QtGui.QPushButton(Database)
        self.enter_btn.setGeometry(QtCore.QRect(550, 540, 151, 31))
        self.enter_btn.setObjectName(_fromUtf8("enter_btn"))
        self.correct_btn = QtGui.QPushButton(Database)
        self.correct_btn.setGeometry(QtCore.QRect(300, 540, 151, 31))
        self.correct_btn.setObjectName(_fromUtf8("correct_btn"))
        self.label_2 = QtGui.QLabel(Database)
        self.label_2.setGeometry(QtCore.QRect(50, 115, 91, 17))
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.comboBox = QtGui.QComboBox(Database)
        self.comboBox.setGeometry(QtCore.QRect(170, 110, 221, 25))
        self.comboBox.setObjectName(_fromUtf8("comboBox"))
        self.groupBox = QtGui.QGroupBox(Database)
        self.groupBox.setGeometry(QtCore.QRect(500, 112, 351, 21))
        self.groupBox.setStyleSheet(_fromUtf8("border: none;"))
        self.groupBox.setTitle(_fromUtf8(""))
        self.groupBox.setAlignment(QtCore.Qt.AlignLeading|QtCore.Qt.AlignLeft|QtCore.Qt.AlignVCenter)
        self.groupBox.setObjectName(_fromUtf8("groupBox"))
        self.asc_btn = QtGui.QRadioButton(self.groupBox)
        self.asc_btn.setGeometry(QtCore.QRect(0, 0, 100, 22))
        self.asc_btn.setChecked(True)
        self.asc_btn.setObjectName(_fromUtf8("asc_btn"))
        self.desc_btn = QtGui.QRadioButton(self.groupBox)
        self.desc_btn.setGeometry(QtCore.QRect(190, 0, 100, 22))
        self.desc_btn.setObjectName(_fromUtf8("desc_btn"))
        self.label_3 = QtGui.QLabel(Database)
        self.label_3.setGeometry(QtCore.QRect(50, 80, 58, 14))
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.lineEdit = QtGui.QLineEdit(Database)
        self.lineEdit.setGeometry(QtCore.QRect(170, 70, 221, 28))
        self.lineEdit.setObjectName(_fromUtf8("lineEdit"))
        self.plotten_btn = QtGui.QPushButton(Database)
        self.plotten_btn.setGeometry(QtCore.QRect(800, 540, 151, 31))
        self.plotten_btn.setObjectName(_fromUtf8("plotten_btn"))

        self.retranslateUi(Database)
        QtCore.QMetaObject.connectSlotsByName(Database)
        Database.setTabOrder(self.refresh_btn, self.correct_btn)
        Database.setTabOrder(self.correct_btn, self.enter_btn)
        Database.setTabOrder(self.enter_btn, self.tableWidget)

    def retranslateUi(self, Database):
        Database.setWindowTitle(_translate("Database", "Dialog", None))
        self.label.setText(_translate("Database", "Material Datenbank", None))
        self.refresh_btn.setText(_translate("Database", "Aktualisieren", None))
        self.enter_btn.setText(_translate("Database", "Werte eintragen", None))
        self.correct_btn.setText(_translate("Database", "Werte korrigieren", None))
        self.label_2.setText(_translate("Database", "Sortieren nach:", None))
        self.asc_btn.setText(_translate("Database", "Aufsteigend", None))
        self.desc_btn.setText(_translate("Database", "Absteigend", None))
        self.label_3.setText(_translate("Database", "Suche:", None))
        self.plotten_btn.setText(_translate("Database", "Plotten", None))

