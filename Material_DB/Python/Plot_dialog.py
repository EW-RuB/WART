# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'Plot_dialog.ui'
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

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName(_fromUtf8("Dialog"))
        Dialog.resize(400, 100)
        self.btn_plot_dialog = QtGui.QPushButton(Dialog)
        self.btn_plot_dialog.setGeometry(QtCore.QRect(230, 50, 85, 30))
        self.btn_plot_dialog.setObjectName(_fromUtf8("btn_plot_dialog"))
        self.spinBox = QtGui.QSpinBox(Dialog)
        self.spinBox.setGeometry(QtCore.QRect(70, 50, 85, 28))
        self.spinBox.setObjectName(_fromUtf8("spinBox"))
        self.label = QtGui.QLabel(Dialog)
        self.label.setGeometry(QtCore.QRect(20, 20, 121, 16))
        self.label.setObjectName(_fromUtf8("label"))

        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "Dialog", None))
        self.btn_plot_dialog.setText(_translate("Dialog", "Plotten", None))
        self.label.setText(_translate("Dialog", "Anzahl der Punkte:", None))

