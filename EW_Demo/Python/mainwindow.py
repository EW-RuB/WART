# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mainwindow.ui'
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

class Ui_EbeneWellen(object):
    def setupUi(self, EbeneWellen):
        EbeneWellen.setObjectName(_fromUtf8("EbeneWellen"))
        EbeneWellen.resize(1321, 737)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(EbeneWellen.sizePolicy().hasHeightForWidth())
        EbeneWellen.setSizePolicy(sizePolicy)
        EbeneWellen.setMinimumSize(QtCore.QSize(1321, 737))
        EbeneWellen.setMaximumSize(QtCore.QSize(1321, 737))
        EbeneWellen.setStyleSheet(_fromUtf8("QMainWindow{ background-color: #2b2b2b; }\n"
"\n"
"QMenuBar{ background-color: #2b2b2b;\n"
"                        color: #b6b9b8;\n"
"                         top: 5px; }\n"
"\n"
"QTabWidget::pane{ background-color: #3c3f41;\n"
"border-top-right-radius: 5px;\n"
"border-bottom-right-radius: 5px;\n"
"border-bottom-left-radius: 5px; \n"
"top: 10px; }\n"
"\n"
"QTabWidget::tab-bar:top { top: 10px; }\n"
"\n"
"QTabWidget::tab-bar:bottom { bottom: 5px; }\n"
"\n"
"QTabWidget::tab-bar:left { right: 5px; }\n"
"\n"
"QTabWidget::tab-bar:right { left: 5px; }\n"
"\n"
"QTabBar::tab:top:!selected {\n"
"    margin-top: 3px;\n"
"    border: 1px;\n"
"    background-color: #2b2b2b;\n"
"    border-color: #3c3f41;\n"
"}\n"
"\n"
"QTabBar::tab:!selected { color: #7b7b7b; }\n"
"\n"
"QTabBar::tab:bottom:!selected {\n"
"    /*margin-bottom: 10px;*/\n"
"}\n"
"\n"
"QTabBar::tab:top:selected {\n"
"    color: #b6b9b8;\n"
"}\n"
"\n"
"QTabBar::tab:selected{     border-top-left-radius: 5px;\n"
"    border-top-right-radius: 5px; }\n"
"\n"
"QTabBar::tab:top, QTabBar::tab:bottom{\n"
"    min-width: 8ex;\n"
"    margin-right: -1px;\n"
"    padding: 5px 10px 5px 10px;\n"
"}\n"
"\n"
"QTabBar::tab{ background-color: #3c3f41;\n"
"border-radius: 1px; }\n"
"\n"
"QTabBar::tab:!selected:hover {\n"
"    background: #313335;\n"
"    color: #b6b9b8;\n"
"}\n"
"\n"
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
"QLabel :Disabled{ background-color: red; }\n"
"\n"
"QRadioButton{     border: 5px;\n"
"                                color: #b6b9b8; }\n"
"\n"
"QGroupBox{ color: #b6b9b8;\n"
"                        border: 2px solid #434749; \n"
"                        border-radius: 4px;\n"
"                        /*border-color: #434749;*/}\n"
"\n"
"QLineEdit{ background-color: #ededed;\n"
"                    color: #434749; \n"
"                    border-radius: 4px;\n"
"                    selection-background-color: #4cda43;\n"
"                    }\n"
"\n"
"QLineEdit:selected{ background-color: #4cda43 }\n"
"\n"
"QLineEdit:Disabled{ background-color: #434749; }\n"
"\n"
"QComboBox { background-color: #ededed;\n"
"border-radius: 4px;\n"
"color: #434749;\n"
" }\n"
"\n"
"QComboBox::item:selected\n"
"{\n"
"    background-color: #4cda43;\n"
"    color: #ededed;\n"
"}\n"
"\n"
"QTextEdit { background-color: #000000;\n"
"                        border-radius: 4px; \n"
"                    color: #ededed}\n"
"\n"
"QTableWidget { background-color: #ededed;\n"
"                            color: #434749;\n"
"                            selection-color: #434749;\n"
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
"QTableWidget::item:selected{ background-color: #4cda43 }\n"
"\n"
"QCheckBox { color: #b6b9b8; }\n"
"\n"
"QGroupBox::title{ font: bold 75 11pt \"Noto Sans\"; }"))
        self.centralWidget = QtGui.QWidget(EbeneWellen)
        self.centralWidget.setObjectName(_fromUtf8("centralWidget"))
        self.tabWidget = QtGui.QTabWidget(self.centralWidget)
        self.tabWidget.setGeometry(QtCore.QRect(6, 20, 1311, 681))
        self.tabWidget.setAutoFillBackground(False)
        self.tabWidget.setStyleSheet(_fromUtf8(""))
        self.tabWidget.setObjectName(_fromUtf8("tabWidget"))
        self.tab = QtGui.QWidget()
        self.tab.setObjectName(_fromUtf8("tab"))
        self.lastSessionButton = QtGui.QPushButton(self.tab)
        self.lastSessionButton.setGeometry(QtCore.QRect(1110, 55, 150, 168))
        self.lastSessionButton.setStyleSheet(_fromUtf8(""))
        self.lastSessionButton.setText(_fromUtf8(""))
        self.lastSessionButton.setObjectName(_fromUtf8("lastSessionButton"))
        self.demoButton = QtGui.QPushButton(self.tab)
        self.demoButton.setGeometry(QtCore.QRect(1110, 230, 150, 168))
        self.demoButton.setStyleSheet(_fromUtf8(""))
        self.demoButton.setText(_fromUtf8(""))
        self.demoButton.setObjectName(_fromUtf8("demoButton"))
        self.helpButton = QtGui.QPushButton(self.tab)
        self.helpButton.setGeometry(QtCore.QRect(1110, 405, 150, 168))
        self.helpButton.setStyleSheet(_fromUtf8(""))
        self.helpButton.setText(_fromUtf8(""))
        self.helpButton.setObjectName(_fromUtf8("helpButton"))
        self.lbl_start_picture = QtGui.QLabel(self.tab)
        self.lbl_start_picture.setGeometry(QtCore.QRect(0, 190, 1091, 420))
        self.lbl_start_picture.setStyleSheet(_fromUtf8(""))
        self.lbl_start_picture.setText(_fromUtf8(""))
        self.lbl_start_picture.setObjectName(_fromUtf8("lbl_start_picture"))
        self.label_5 = QtGui.QLabel(self.tab)
        self.label_5.setGeometry(QtCore.QRect(30, 60, 1031, 61))
        font = QtGui.QFont()
        font.setPointSize(28)
        font.setBold(True)
        font.setItalic(True)
        font.setWeight(75)
        self.label_5.setFont(font)
        self.label_5.setAlignment(QtCore.Qt.AlignCenter)
        self.label_5.setObjectName(_fromUtf8("label_5"))
        self.tabWidget.addTab(self.tab, _fromUtf8(""))
        self.tab_2 = QtGui.QWidget()
        self.tab_2.setObjectName(_fromUtf8("tab_2"))
        self.vert1Line = QtGui.QFrame(self.tab_2)
        self.vert1Line.setWindowModality(QtCore.Qt.NonModal)
        self.vert1Line.setGeometry(QtCore.QRect(370, 20, 20, 611))
        self.vert1Line.setAutoFillBackground(False)
        self.vert1Line.setStyleSheet(_fromUtf8("color: #434749;"))
        self.vert1Line.setFrameShadow(QtGui.QFrame.Plain)
        self.vert1Line.setLineWidth(2)
        self.vert1Line.setFrameShape(QtGui.QFrame.VLine)
        self.vert1Line.setObjectName(_fromUtf8("vert1Line"))
        self.btn_te_fall = QtGui.QPushButton(self.tab_2)
        self.btn_te_fall.setGeometry(QtCore.QRect(50, 55, 88, 34))
        self.btn_te_fall.setStyleSheet(_fromUtf8(""))
        self.btn_te_fall.setObjectName(_fromUtf8("btn_te_fall"))
        self.btn_tm_fall = QtGui.QPushButton(self.tab_2)
        self.btn_tm_fall.setEnabled(True)
        self.btn_tm_fall.setGeometry(QtCore.QRect(232, 55, 88, 34))
        self.btn_tm_fall.setStyleSheet(_fromUtf8(""))
        self.btn_tm_fall.setObjectName(_fromUtf8("btn_tm_fall"))
        self.med1label = QtGui.QLabel(self.tab_2)
        self.med1label.setGeometry(QtCore.QRect(160, 135, 71, 18))
        self.med1label.setStyleSheet(_fromUtf8(""))
        self.med1label.setObjectName(_fromUtf8("med1label"))
        self.med1comboBox = QtGui.QComboBox(self.tab_2)
        self.med1comboBox.setGeometry(QtCore.QRect(80, 163, 211, 32))
        self.med1comboBox.setStyleSheet(_fromUtf8(""))
        self.med1comboBox.setObjectName(_fromUtf8("med1comboBox"))
        self.med2label = QtGui.QLabel(self.tab_2)
        self.med2label.setGeometry(QtCore.QRect(160, 222, 71, 18))
        self.med2label.setStyleSheet(_fromUtf8(""))
        self.med2label.setObjectName(_fromUtf8("med2label"))
        self.med2comboBox = QtGui.QComboBox(self.tab_2)
        self.med2comboBox.setGeometry(QtCore.QRect(80, 250, 210, 32))
        self.med2comboBox.setStyleSheet(_fromUtf8(""))
        self.med2comboBox.setObjectName(_fromUtf8("med2comboBox"))
        self.med3comboBox = QtGui.QComboBox(self.tab_2)
        self.med3comboBox.setGeometry(QtCore.QRect(80, 337, 210, 32))
        self.med3comboBox.setStyleSheet(_fromUtf8(""))
        self.med3comboBox.setObjectName(_fromUtf8("med3comboBox"))
        self.med3label = QtGui.QLabel(self.tab_2)
        self.med3label.setGeometry(QtCore.QRect(160, 310, 71, 18))
        self.med3label.setStyleSheet(_fromUtf8(""))
        self.med3label.setObjectName(_fromUtf8("med3label"))
        self.hor4Line = QtGui.QFrame(self.tab_2)
        self.hor4Line.setGeometry(QtCore.QRect(18, 390, 331, 20))
        self.hor4Line.setStyleSheet(_fromUtf8("color: #434749;"))
        self.hor4Line.setFrameShadow(QtGui.QFrame.Plain)
        self.hor4Line.setLineWidth(2)
        self.hor4Line.setFrameShape(QtGui.QFrame.HLine)
        self.hor4Line.setObjectName(_fromUtf8("hor4Line"))
        self.btn_questionmark = QtGui.QPushButton(self.tab_2)
        self.btn_questionmark.setGeometry(QtCore.QRect(166, 55, 41, 34))
        self.btn_questionmark.setStyleSheet(_fromUtf8(""))
        self.btn_questionmark.setObjectName(_fromUtf8("btn_questionmark"))
        self.textEdit_OctaveConsole = QtGui.QTextEdit(self.tab_2)
        self.textEdit_OctaveConsole.setGeometry(QtCore.QRect(410, 410, 871, 191))
        palette = QtGui.QPalette()
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.WindowText, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Button, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Light, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Midlight, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Dark, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Mid, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Text, brush)
        brush = QtGui.QBrush(QtGui.QColor(255, 255, 255))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.BrightText, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.ButtonText, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Base, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Window, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.Shadow, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.AlternateBase, brush)
        brush = QtGui.QBrush(QtGui.QColor(255, 255, 220))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.ToolTipBase, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Active, QtGui.QPalette.ToolTipText, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.WindowText, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Button, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Light, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Midlight, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Dark, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Mid, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Text, brush)
        brush = QtGui.QBrush(QtGui.QColor(255, 255, 255))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.BrightText, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.ButtonText, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Base, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Window, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.Shadow, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.AlternateBase, brush)
        brush = QtGui.QBrush(QtGui.QColor(255, 255, 220))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.ToolTipBase, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Inactive, QtGui.QPalette.ToolTipText, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.WindowText, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Button, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Light, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Midlight, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Dark, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Mid, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Text, brush)
        brush = QtGui.QBrush(QtGui.QColor(255, 255, 255))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.BrightText, brush)
        brush = QtGui.QBrush(QtGui.QColor(237, 237, 237))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.ButtonText, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Base, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Window, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.Shadow, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.AlternateBase, brush)
        brush = QtGui.QBrush(QtGui.QColor(255, 255, 220))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.ToolTipBase, brush)
        brush = QtGui.QBrush(QtGui.QColor(0, 0, 0))
        brush.setStyle(QtCore.Qt.SolidPattern)
        palette.setBrush(QtGui.QPalette.Disabled, QtGui.QPalette.ToolTipText, brush)
        self.textEdit_OctaveConsole.setPalette(palette)
        self.textEdit_OctaveConsole.setStyleSheet(_fromUtf8(""))
        self.textEdit_OctaveConsole.setReadOnly(True)
        self.textEdit_OctaveConsole.setObjectName(_fromUtf8("textEdit_OctaveConsole"))
        self.btn_start = QtGui.QPushButton(self.tab_2)
        self.btn_start.setGeometry(QtCore.QRect(110, 430, 146, 181))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setWeight(75)
        self.btn_start.setFont(font)
        self.btn_start.setStyleSheet(_fromUtf8("QPushButton#btn_start { color: none;\n"
"                                                background-color:none;\n"
"                                                border: none;    }"))
        self.btn_start.setText(_fromUtf8(""))
        self.btn_start.setObjectName(_fromUtf8("btn_start"))
        self.Freq_u_Winkel_Box = QtGui.QGroupBox(self.tab_2)
        self.Freq_u_Winkel_Box.setGeometry(QtCore.QRect(410, 20, 871, 351))
        font = QtGui.QFont()
        font.setBold(False)
        font.setWeight(50)
        self.Freq_u_Winkel_Box.setFont(font)
        self.Freq_u_Winkel_Box.setStyleSheet(_fromUtf8(""))
        self.Freq_u_Winkel_Box.setObjectName(_fromUtf8("Freq_u_Winkel_Box"))
        self.field_SchrittgroesseFreq = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_SchrittgroesseFreq.setEnabled(False)
        self.field_SchrittgroesseFreq.setGeometry(QtCore.QRect(720, 190, 141, 27))
        self.field_SchrittgroesseFreq.setStyleSheet(_fromUtf8(""))
        self.field_SchrittgroesseFreq.setObjectName(_fromUtf8("field_SchrittgroesseFreq"))
        self.field_startFreq = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_startFreq.setEnabled(False)
        self.field_startFreq.setGeometry(QtCore.QRect(210, 190, 141, 27))
        self.field_startFreq.setStyleSheet(_fromUtf8(""))
        self.field_startFreq.setObjectName(_fromUtf8("field_startFreq"))
        self.field_festerWinkel = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_festerWinkel.setEnabled(False)
        self.field_festerWinkel.setGeometry(QtCore.QRect(210, 148, 141, 27))
        self.field_festerWinkel.setStyleSheet(_fromUtf8(""))
        self.field_festerWinkel.setObjectName(_fromUtf8("field_festerWinkel"))
        self.field_endFreq = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_endFreq.setEnabled(False)
        self.field_endFreq.setGeometry(QtCore.QRect(460, 190, 141, 27))
        self.field_endFreq.setStyleSheet(_fromUtf8(""))
        self.field_endFreq.setObjectName(_fromUtf8("field_endFreq"))
        self.lbl_Schrittgroesse_2 = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_Schrittgroesse_2.setEnabled(True)
        self.lbl_Schrittgroesse_2.setGeometry(QtCore.QRect(630, 195, 81, 17))
        self.lbl_Schrittgroesse_2.setStyleSheet(_fromUtf8("color: #434749"))
        self.lbl_Schrittgroesse_2.setObjectName(_fromUtf8("lbl_Schrittgroesse_2"))
        self.radioButton_festerWinkel = QtGui.QRadioButton(self.Freq_u_Winkel_Box)
        self.radioButton_festerWinkel.setEnabled(False)
        self.radioButton_festerWinkel.setGeometry(QtCore.QRect(20, 150, 161, 22))
        self.radioButton_festerWinkel.setAcceptDrops(False)
        self.radioButton_festerWinkel.setStyleSheet(_fromUtf8("color: #585e61"))
        self.radioButton_festerWinkel.setObjectName(_fromUtf8("radioButton_festerWinkel"))
        self.lbl_endFreq = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_endFreq.setEnabled(True)
        self.lbl_endFreq.setGeometry(QtCore.QRect(370, 195, 81, 20))
        self.lbl_endFreq.setStyleSheet(_fromUtf8("color: #434749"))
        self.lbl_endFreq.setObjectName(_fromUtf8("lbl_endFreq"))
        self.lbl_startFreq = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_startFreq.setEnabled(True)
        self.lbl_startFreq.setGeometry(QtCore.QRect(45, 195, 151, 17))
        self.lbl_startFreq.setStyleSheet(_fromUtf8("color: #434749"))
        self.lbl_startFreq.setFrameShape(QtGui.QFrame.NoFrame)
        self.lbl_startFreq.setLineWidth(0)
        self.lbl_startFreq.setObjectName(_fromUtf8("lbl_startFreq"))
        self.field_SchrittgroesseWinkel = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_SchrittgroesseWinkel.setGeometry(QtCore.QRect(720, 80, 141, 27))
        self.field_SchrittgroesseWinkel.setStyleSheet(_fromUtf8(""))
        self.field_SchrittgroesseWinkel.setObjectName(_fromUtf8("field_SchrittgroesseWinkel"))
        self.field_festeFrequenz = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_festeFrequenz.setGeometry(QtCore.QRect(210, 38, 141, 27))
        self.field_festeFrequenz.setStyleSheet(_fromUtf8(""))
        self.field_festeFrequenz.setObjectName(_fromUtf8("field_festeFrequenz"))
        self.radioButton_festeFrequenz = QtGui.QRadioButton(self.Freq_u_Winkel_Box)
        self.radioButton_festeFrequenz.setGeometry(QtCore.QRect(20, 40, 161, 22))
        self.radioButton_festeFrequenz.setAcceptDrops(False)
        self.radioButton_festeFrequenz.setStyleSheet(_fromUtf8(""))
        self.radioButton_festeFrequenz.setChecked(True)
        self.radioButton_festeFrequenz.setObjectName(_fromUtf8("radioButton_festeFrequenz"))
        self.field_Startwinkel = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_Startwinkel.setGeometry(QtCore.QRect(210, 80, 141, 27))
        self.field_Startwinkel.setStyleSheet(_fromUtf8(""))
        self.field_Startwinkel.setObjectName(_fromUtf8("field_Startwinkel"))
        self.lbl_Schrittgroesse = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_Schrittgroesse.setGeometry(QtCore.QRect(630, 85, 81, 17))
        self.lbl_Schrittgroesse.setStyleSheet(_fromUtf8(""))
        self.lbl_Schrittgroesse.setObjectName(_fromUtf8("lbl_Schrittgroesse"))
        self.field_Endwinkel = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_Endwinkel.setGeometry(QtCore.QRect(460, 80, 141, 27))
        self.field_Endwinkel.setStyleSheet(_fromUtf8(""))
        self.field_Endwinkel.setObjectName(_fromUtf8("field_Endwinkel"))
        self.lbl_Startwinkel = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_Startwinkel.setGeometry(QtCore.QRect(60, 85, 121, 17))
        self.lbl_Startwinkel.setStyleSheet(_fromUtf8(""))
        self.lbl_Startwinkel.setObjectName(_fromUtf8("lbl_Startwinkel"))
        self.lbl_Endwinkel = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_Endwinkel.setGeometry(QtCore.QRect(380, 85, 71, 17))
        self.lbl_Endwinkel.setStyleSheet(_fromUtf8(""))
        self.lbl_Endwinkel.setObjectName(_fromUtf8("lbl_Endwinkel"))
        self.field_fwuf_Winkel = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_fwuf_Winkel.setEnabled(False)
        self.field_fwuf_Winkel.setGeometry(QtCore.QRect(720, 300, 141, 27))
        self.field_fwuf_Winkel.setStyleSheet(_fromUtf8(""))
        self.field_fwuf_Winkel.setObjectName(_fromUtf8("field_fwuf_Winkel"))
        self.radioButton_festeWiuFreq = QtGui.QRadioButton(self.Freq_u_Winkel_Box)
        self.radioButton_festeWiuFreq.setEnabled(True)
        self.radioButton_festeWiuFreq.setGeometry(QtCore.QRect(20, 260, 191, 22))
        self.radioButton_festeWiuFreq.setStyleSheet(_fromUtf8("color: #585e61"))
        self.radioButton_festeWiuFreq.setObjectName(_fromUtf8("radioButton_festeWiuFreq"))
        self.field_fwuf_Freq = QtGui.QLineEdit(self.Freq_u_Winkel_Box)
        self.field_fwuf_Freq.setEnabled(False)
        self.field_fwuf_Freq.setGeometry(QtCore.QRect(460, 300, 141, 27))
        self.field_fwuf_Freq.setStyleSheet(_fromUtf8(""))
        self.field_fwuf_Freq.setObjectName(_fromUtf8("field_fwuf_Freq"))
        self.lbl_Winkel = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_Winkel.setEnabled(True)
        self.lbl_Winkel.setGeometry(QtCore.QRect(660, 305, 51, 20))
        self.lbl_Winkel.setStyleSheet(_fromUtf8("color: #434749"))
        self.lbl_Winkel.setObjectName(_fromUtf8("lbl_Winkel"))
        self.lbl_Freq = QtGui.QLabel(self.Freq_u_Winkel_Box)
        self.lbl_Freq.setEnabled(True)
        self.lbl_Freq.setGeometry(QtCore.QRect(380, 305, 71, 20))
        self.lbl_Freq.setStyleSheet(_fromUtf8("color: #434749"))
        self.lbl_Freq.setObjectName(_fromUtf8("lbl_Freq"))
        self.line_2 = QtGui.QFrame(self.Freq_u_Winkel_Box)
        self.line_2.setGeometry(QtCore.QRect(0, 230, 871, 20))
        self.line_2.setStyleSheet(_fromUtf8("color: #434749;"))
        self.line_2.setFrameShadow(QtGui.QFrame.Plain)
        self.line_2.setLineWidth(2)
        self.line_2.setFrameShape(QtGui.QFrame.HLine)
        self.line_2.setObjectName(_fromUtf8("line_2"))
        self.line_3 = QtGui.QFrame(self.Freq_u_Winkel_Box)
        self.line_3.setGeometry(QtCore.QRect(0, 120, 871, 20))
        self.line_3.setStyleSheet(_fromUtf8("color: #434749;"))
        self.line_3.setFrameShadow(QtGui.QFrame.Plain)
        self.line_3.setLineWidth(2)
        self.line_3.setFrameShape(QtGui.QFrame.HLine)
        self.line_3.setObjectName(_fromUtf8("line_3"))
        self.label_23 = QtGui.QLabel(self.tab_2)
        self.label_23.setGeometry(QtCore.QRect(20, 20, 111, 17))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(False)
        font.setWeight(75)
        self.label_23.setFont(font)
        self.label_23.setStyleSheet(_fromUtf8(""))
        self.label_23.setObjectName(_fromUtf8("label_23"))
        self.octave_output_checkBox = QtGui.QCheckBox(self.tab_2)
        self.octave_output_checkBox.setGeometry(QtCore.QRect(430, 380, 171, 22))
        font = QtGui.QFont()
        font.setBold(True)
        font.setWeight(75)
        self.octave_output_checkBox.setFont(font)
        self.octave_output_checkBox.setChecked(True)
        self.octave_output_checkBox.setTristate(False)
        self.octave_output_checkBox.setObjectName(_fromUtf8("octave_output_checkBox"))
        self.octave_output_to_file_checkBox = QtGui.QCheckBox(self.tab_2)
        self.octave_output_to_file_checkBox.setGeometry(QtCore.QRect(660, 380, 191, 22))
        self.octave_output_to_file_checkBox.setChecked(True)
        self.octave_output_to_file_checkBox.setObjectName(_fromUtf8("octave_output_to_file_checkBox"))
        self.btn_LogWindow = QtGui.QPushButton(self.tab_2)
        self.btn_LogWindow.setGeometry(QtCore.QRect(1130, 378, 141, 27))
        self.btn_LogWindow.setObjectName(_fromUtf8("btn_LogWindow"))
        self.btn_clearConsole = QtGui.QPushButton(self.tab_2)
        self.btn_clearConsole.setGeometry(QtCore.QRect(950, 378, 141, 27))
        self.btn_clearConsole.setObjectName(_fromUtf8("btn_clearConsole"))
        self.btn_Abbrechen = QtGui.QPushButton(self.tab_2)
        self.btn_Abbrechen.setGeometry(QtCore.QRect(1130, 610, 141, 27))
        self.btn_Abbrechen.setObjectName(_fromUtf8("btn_Abbrechen"))
        self.btn_Pause = QtGui.QPushButton(self.tab_2)
        self.btn_Pause.setGeometry(QtCore.QRect(950, 610, 141, 27))
        self.btn_Pause.setObjectName(_fromUtf8("btn_Pause"))
        self.btn_Weiter = QtGui.QPushButton(self.tab_2)
        self.btn_Weiter.setGeometry(QtCore.QRect(760, 610, 141, 27))
        self.btn_Weiter.setObjectName(_fromUtf8("btn_Weiter"))
        self.tabWidget.addTab(self.tab_2, _fromUtf8(""))
        self.tab_3 = QtGui.QWidget()
        self.tab_3.setObjectName(_fromUtf8("tab_3"))
        self.lbl_materialList = QtGui.QLabel(self.tab_3)
        self.lbl_materialList.setGeometry(QtCore.QRect(80, 30, 151, 17))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(True)
        font.setUnderline(False)
        font.setWeight(75)
        font.setStrikeOut(False)
        self.lbl_materialList.setFont(font)
        self.lbl_materialList.setObjectName(_fromUtf8("lbl_materialList"))
        self.tableWidget = QtGui.QTableWidget(self.tab_3)
        self.tableWidget.setGeometry(QtCore.QRect(70, 70, 1161, 501))
        self.tableWidget.setStyleSheet(_fromUtf8(""))
        self.tableWidget.setObjectName(_fromUtf8("tableWidget"))
        self.tableWidget.setColumnCount(0)
        self.tableWidget.setRowCount(0)
        self.tabWidget.addTab(self.tab_3, _fromUtf8(""))
        self.tab_6 = QtGui.QWidget()
        self.tab_6.setObjectName(_fromUtf8("tab_6"))
        self.frame_3 = QtGui.QFrame(self.tab_6)
        self.frame_3.setGeometry(QtCore.QRect(50, 50, 1211, 541))
        self.frame_3.setStyleSheet(_fromUtf8("background-color: #434749"))
        self.frame_3.setFrameShape(QtGui.QFrame.StyledPanel)
        self.frame_3.setFrameShadow(QtGui.QFrame.Raised)
        self.frame_3.setObjectName(_fromUtf8("frame_3"))
        self.groupBox_legend = QtGui.QGroupBox(self.frame_3)
        self.groupBox_legend.setEnabled(False)
        self.groupBox_legend.setGeometry(QtCore.QRect(70, 100, 401, 121))
        self.groupBox_legend.setStyleSheet(_fromUtf8("QGroupBox{\n"
"                        border: 3px solid #3c3f41; }"))
        self.groupBox_legend.setObjectName(_fromUtf8("groupBox_legend"))
        self.radioButton_legend1 = QtGui.QRadioButton(self.groupBox_legend)
        self.radioButton_legend1.setGeometry(QtCore.QRect(30, 20, 331, 22))
        self.radioButton_legend1.setChecked(True)
        self.radioButton_legend1.setObjectName(_fromUtf8("radioButton_legend1"))
        self.radioButton_legend2 = QtGui.QRadioButton(self.groupBox_legend)
        self.radioButton_legend2.setGeometry(QtCore.QRect(30, 50, 361, 22))
        self.radioButton_legend2.setObjectName(_fromUtf8("radioButton_legend2"))
        self.radioButton_legend3 = QtGui.QRadioButton(self.groupBox_legend)
        self.radioButton_legend3.setGeometry(QtCore.QRect(30, 80, 301, 22))
        self.radioButton_legend3.setObjectName(_fromUtf8("radioButton_legend3"))
        self.cB_SurfaceFlag = QtGui.QCheckBox(self.frame_3)
        self.cB_SurfaceFlag.setGeometry(QtCore.QRect(640, 70, 87, 22))
        self.cB_SurfaceFlag.setObjectName(_fromUtf8("cB_SurfaceFlag"))
        self.checkBox_Plots = QtGui.QCheckBox(self.frame_3)
        self.checkBox_Plots.setGeometry(QtCore.QRect(50, 70, 121, 22))
        self.checkBox_Plots.setObjectName(_fromUtf8("checkBox_Plots"))
        self.label_3 = QtGui.QLabel(self.frame_3)
        self.label_3.setGeometry(QtCore.QRect(320, 500, 751, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(False)
        font.setWeight(75)
        self.label_3.setFont(font)
        self.label_3.setStyleSheet(_fromUtf8("color: #cb0606;"))
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.label_4 = QtGui.QLabel(self.frame_3)
        self.label_4.setGeometry(QtCore.QRect(20, 10, 281, 17))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(True)
        font.setWeight(75)
        self.label_4.setFont(font)
        self.label_4.setObjectName(_fromUtf8("label_4"))
        self.tabWidget.addTab(self.tab_6, _fromUtf8(""))
        self.tab_4 = QtGui.QWidget()
        self.tab_4.setObjectName(_fromUtf8("tab_4"))
        self.frame = QtGui.QFrame(self.tab_4)
        self.frame.setGeometry(QtCore.QRect(59, 40, 540, 561))
        self.frame.setStyleSheet(_fromUtf8("QFrame{ color: #b6b9b8;\n"
"                        border: 2px solid #434749; \n"
"                        border-radius: 4px;\n"
"                        /*border-color: #434749;*/}"))
        self.frame.setFrameShape(QtGui.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtGui.QFrame.Raised)
        self.frame.setObjectName(_fromUtf8("frame"))
        self.lbl_theorieHeader = QtGui.QLabel(self.frame)
        self.lbl_theorieHeader.setGeometry(QtCore.QRect(210, 20, 121, 31))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(True)
        font.setWeight(75)
        self.lbl_theorieHeader.setFont(font)
        self.lbl_theorieHeader.setStyleSheet(_fromUtf8("border: none;"))
        self.lbl_theorieHeader.setAlignment(QtCore.Qt.AlignCenter)
        self.lbl_theorieHeader.setObjectName(_fromUtf8("lbl_theorieHeader"))
        self.btn_theoriePDF = QtGui.QPushButton(self.frame)
        self.btn_theoriePDF.setGeometry(QtCore.QRect(180, 420, 200, 60))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(False)
        font.setWeight(75)
        self.btn_theoriePDF.setFont(font)
        self.btn_theoriePDF.setIconSize(QtCore.QSize(40, 40))
        self.btn_theoriePDF.setCheckable(False)
        self.btn_theoriePDF.setAutoRepeat(False)
        self.btn_theoriePDF.setAutoExclusive(False)
        self.btn_theoriePDF.setObjectName(_fromUtf8("btn_theoriePDF"))
        self.frame_2 = QtGui.QFrame(self.tab_4)
        self.frame_2.setGeometry(QtCore.QRect(690, 40, 540, 561))
        self.frame_2.setStyleSheet(_fromUtf8("QFrame{ color: #b6b9b8;\n"
"                        border: 2px solid #434749; \n"
"                        border-radius: 4px;\n"
"                        /*border-color: #434749;*/}"))
        self.frame_2.setFrameShape(QtGui.QFrame.StyledPanel)
        self.frame_2.setFrameShadow(QtGui.QFrame.Raised)
        self.frame_2.setObjectName(_fromUtf8("frame_2"))
        self.lbl_Projektstruktur = QtGui.QLabel(self.frame_2)
        self.lbl_Projektstruktur.setGeometry(QtCore.QRect(220, 20, 151, 31))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setItalic(True)
        font.setWeight(75)
        self.lbl_Projektstruktur.setFont(font)
        self.lbl_Projektstruktur.setStyleSheet(_fromUtf8("border: none;"))
        self.lbl_Projektstruktur.setObjectName(_fromUtf8("lbl_Projektstruktur"))
        self.btn_projektstruktur = QtGui.QPushButton(self.frame_2)
        self.btn_projektstruktur.setGeometry(QtCore.QRect(170, 420, 200, 60))
        font = QtGui.QFont()
        font.setPointSize(10)
        font.setBold(True)
        font.setWeight(75)
        self.btn_projektstruktur.setFont(font)
        self.btn_projektstruktur.setObjectName(_fromUtf8("btn_projektstruktur"))
        self.tabWidget.addTab(self.tab_4, _fromUtf8(""))
        EbeneWellen.setCentralWidget(self.centralWidget)
        self.statusBar = QtGui.QStatusBar(EbeneWellen)
        self.statusBar.setObjectName(_fromUtf8("statusBar"))
        EbeneWellen.setStatusBar(self.statusBar)

        self.retranslateUi(EbeneWellen)
        self.tabWidget.setCurrentIndex(0)
        QtCore.QMetaObject.connectSlotsByName(EbeneWellen)

    def retranslateUi(self, EbeneWellen):
        EbeneWellen.setWindowTitle(_translate("EbeneWellen", "EbeneWellen Demo", None))
        self.label_5.setText(_translate("EbeneWellen", "Reflexion und Brechung ebener Wellen", None))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab), _translate("EbeneWellen", "Start", None))
        self.btn_te_fall.setText(_translate("EbeneWellen", "TE Fall", None))
        self.btn_tm_fall.setText(_translate("EbeneWellen", "TM Fall", None))
        self.med1label.setText(_translate("EbeneWellen", "Medium 1:", None))
        self.med2label.setText(_translate("EbeneWellen", "Medium 2:", None))
        self.med3label.setText(_translate("EbeneWellen", "Medium 3:", None))
        self.btn_questionmark.setText(_translate("EbeneWellen", "?", None))
        self.Freq_u_Winkel_Box.setTitle(_translate("EbeneWellen", "Frequenz und Winkel einstellen:", None))
        self.lbl_Schrittgroesse_2.setText(_translate("EbeneWellen", "Schrittgröße:", None))
        self.radioButton_festerWinkel.setText(_translate("EbeneWellen", "Fester Winkel in Grad:", None))
        self.lbl_endFreq.setText(_translate("EbeneWellen", "Endfrequenz:", None))
        self.lbl_startFreq.setText(_translate("EbeneWellen", "Startfrequenz in Hz:", None))
        self.radioButton_festeFrequenz.setText(_translate("EbeneWellen", "Feste Frequenz in Hz:", None))
        self.lbl_Schrittgroesse.setText(_translate("EbeneWellen", "Schrittgröße:", None))
        self.lbl_Startwinkel.setText(_translate("EbeneWellen", "Startwinkel in Grad:", None))
        self.lbl_Endwinkel.setText(_translate("EbeneWellen", "Endwinkel:", None))
        self.radioButton_festeWiuFreq.setText(_translate("EbeneWellen", "Fester Winkel und Frequenz:", None))
        self.lbl_Winkel.setText(_translate("EbeneWellen", "Winkel:", None))
        self.lbl_Freq.setText(_translate("EbeneWellen", "Frequenz:", None))
        self.label_23.setText(_translate("EbeneWellen", "Fall:", None))
        self.octave_output_checkBox.setText(_translate("EbeneWellen", "Octave Ausgabe:", None))
        self.octave_output_to_file_checkBox.setText(_translate("EbeneWellen", "Ausgabe in Datei schreiben", None))
        self.btn_LogWindow.setText(_translate("EbeneWellen", "LogWindow", None))
        self.btn_clearConsole.setText(_translate("EbeneWellen", "clearConsole", None))
        self.btn_Abbrechen.setText(_translate("EbeneWellen", "Abbrechen", None))
        self.btn_Pause.setText(_translate("EbeneWellen", "Pause", None))
        self.btn_Weiter.setText(_translate("EbeneWellen", "Weiter", None))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_2), _translate("EbeneWellen", "Hauptmenü", None))
        self.lbl_materialList.setText(_translate("EbeneWellen", "Materialliste:", None))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_3), _translate("EbeneWellen", "Materialien", None))
        self.groupBox_legend.setTitle(_translate("EbeneWellen", "Legende:", None))
        self.radioButton_legend1.setText(_translate("EbeneWellen", "legend (..., \"location\", \"east\" ) \' in allen static plots", None))
        self.radioButton_legend2.setText(_translate("EbeneWellen", "legend (...) \' OHNE \"location\", \"east\" in allen static plots", None))
        self.radioButton_legend3.setText(_translate("EbeneWellen", "GANZ OHNE \' legend (...) \' in allen static plots", None))
        self.cB_SurfaceFlag.setText(_translate("EbeneWellen", "Surface", None))
        self.checkBox_Plots.setText(_translate("EbeneWellen", "Plots erzeugen", None))
        self.label_3.setText(_translate("EbeneWellen", "Achtung: Änderungen werden erst nach dem Neustart des Simulationsprogramms wirksam!", None))
        self.label_4.setText(_translate("EbeneWellen", "Octave Einstellungen:", None))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_6), _translate("EbeneWellen", "Einstellungen", None))
        self.lbl_theorieHeader.setText(_translate("EbeneWellen", "Hilfe", None))
        self.btn_theoriePDF.setText(_translate("EbeneWellen", "Datei öffnen...", None))
        self.lbl_Projektstruktur.setText(_translate("EbeneWellen", "Projektstruktur", None))
        self.btn_projektstruktur.setText(_translate("EbeneWellen", "Projektstruktur anzeigen", None))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_4), _translate("EbeneWellen", "Hilfe", None))

