# Demo_GUI


# History:

# 25.04.2018
# Funktion writeSQLData wurde auskommentiert, damit das Eintragen von Daten in die Datenbank nicht mehr möglich ist!
# 17.05.2018
# Funktion writeSQLData wurde entfernt, damit das Eintragen von Daten in die Datenbank nicht mehr möglich ist!

import os, sys
from PyQt4 import QtCore, QtGui
import sqlite3
import threading
import csv
import webbrowser
import subprocess
import time
import datetime
import signal

from mainwindow import Ui_EbeneWellen as maingui
# from Dialog import Ui_Dialog as dialog
from LogWindow import Ui_LogWindow as log
# from Media import Media as media
from TreeDialog import Ui_TreeDialog as tree


#################################
# Die Klasse des Hauptfensters  #
#################################
class MainDlg(QtGui.QMainWindow, maingui, log):


    def __init__(self):
        QtGui.QMainWindow.__init__(self)
        self.setupUi(self)
        self.LogWindow = None

        global shellScript

        global Fall
        Fall = "TE"

        # global dlgValue

        global sub_case_str
        sub_case_str = "1a1a"

        global teVersion
        teVersion = "EW_o_ESN_HPT.m"

        global tmVersion
        tmVersion = "EW_o_HSN_EPT.m"

        global mainPath
        mainPath = os.getcwd()

        self.__proc = QtCore.QProcess(self)

        ##############
        # Start TAB  #
        ##############
        # Willkommen-Bild
        movie = QtGui.QMovie(mainPath + "/images/start.gif")
        self.lbl_start_picture.setMovie(movie)
        movie.start()

        self.connect(self.demoButton, QtCore.SIGNAL("clicked()"), self.octaveDemo)
        self.connect(self.helpButton, QtCore.SIGNAL("clicked()"), self.helpButtonTab)
        self.connect(self.lastSessionButton, QtCore.SIGNAL("clicked()"), self.lastSession)
        self.demoButton.setStyleSheet("QPushButton#demoButton { border-image: url(" + mainPath + "/images/play2.png); background-color: none; color: #b6b9b8; border: none;} QPushButton:hover#demoButton { border-image: url(" + mainPath + "/images/play1.png); background-color: none; color: none; border: none;} QPushButton:pressed#demoButton { border-image: url(" + mainPath + "/images/play3.png); background-color: none; color: none; border: none;}")
        self.helpButton.setStyleSheet("QPushButton#helpButton { border-image: url(" + mainPath + "/images/qm2.png); background-color: none; color: #b6b9b8; border: none;} QPushButton:hover#helpButton { border-image: url(" + mainPath + "/images/qm1.png); background-color: none; color: none; border: none;} QPushButton:pressed#helpButton { border-image: url(" + mainPath + "/images/qm3.png); background-color: none; color: none; border: none;}")
        self.lastSessionButton.setStyleSheet("QPushButton#lastSessionButton { border-image: url(" + mainPath + "/images/undo1.png); background-color: none; color: #b6b9b8; border: none; text-align:bottom;} QPushButton:hover#lastSessionButton { border-image: url(" + mainPath + "/images/undo2.png); background-color: none; color: none; border: none;} QPushButton:pressed#lastSessionButton { border-image: url(" + mainPath + "/images/undo3.png); background-color: none; color: none; border: none;}")

        ###################
        # Hauptmenü TAB  #
        ###################
        # Radio Button
        self.connect(self.radioButton_festeFrequenz, QtCore.SIGNAL("clicked()"), self.enableFesteFrequenz)
        self.connect(self.radioButton_festerWinkel, QtCore.SIGNAL("clicked()"), self.enableFesterWinkel)
        self.connect(self.radioButton_festeWiuFreq, QtCore.SIGNAL("clicked()"), self.enableFesteFreq_u_Winkel)
        # Push Button
        self.connect(self.btn_start, QtCore.SIGNAL("clicked()"), self.startProgram)
        self.btn_start.setStyleSheet("QPushButton#btn_start { border-image: url(" + mainPath + "/images/StartButton1.png); background-color: none; color: none; border: none;} QPushButton:hover#btn_start { border-image: url(" + mainPath + "/images/StartButton2.png); background-color: none; color: none; border: none;} QPushButton:pressed#btn_start { border-image: url(" + mainPath + "/images/StartButton3.png); background-color: none; color: none; border: none;}")
        self.connect(self.btn_te_fall, QtCore.SIGNAL("clicked()"), self.teFall)
        self.btn_te_fall.setStyleSheet("background-color: #4cda43; color: #FFFFFF")
        self.connect(self.btn_tm_fall, QtCore.SIGNAL("clicked()"), self.tmFall)
        self.connect(self.btn_questionmark, QtCore.SIGNAL("clicked()"), self.questionMarkButton)
        self.connect(self.btn_LogWindow, QtCore.SIGNAL("clicked()"), self.openLogWindow)
        self.connect(self.btn_Abbrechen, QtCore.SIGNAL("clicked()"), self.on_btn_Abbrechen)
        self.connect(self.btn_Weiter, QtCore.SIGNAL("clicked()"), self.on_btn_Weiter)
        self.connect(self.btn_Pause, QtCore.SIGNAL("clicked()"), self.on_btn_Pause)
        self.connect(self.btn_clearConsole, QtCore.SIGNAL("clicked()"), self.on_btn_clearConsole)
        # CheckBox
        self.connect(self.octave_output_checkBox, QtCore.SIGNAL("clicked()"), self.readStdOutput)
        # Line Edit feste Frequenz
        self.field_festeFrequenz.setText("299.792458e6")
        self.field_Startwinkel.setText("0")
        self.field_Endwinkel.setText("90")
        self.field_SchrittgroesseWinkel.setText("0.5")
        # Line Edit fester Winkel
        self.field_festerWinkel.setText("25.0")
        self.field_festerWinkel.setStyleSheet("QLineEdit:Enabled{ background-color: #F7D358; }")
        self.field_festerWinkel.setReadOnly(True)
        self.field_startFreq.setText("100.0e6")
        self.field_startFreq.setStyleSheet("QLineEdit:Enabled{ background-color: #F7D358; }")
        self.field_startFreq.setReadOnly(True)
        self.field_endFreq.setText("300.0e6")
        self.field_endFreq.setStyleSheet("QLineEdit:Enabled{ background-color: #F7D358; }")
        self.field_endFreq.setReadOnly(True)
        self.field_SchrittgroesseFreq.setText("10.0e6")
        self.field_SchrittgroesseFreq.setStyleSheet("QLineEdit:Enabled{ background-color: #F7D358; }")
        self.field_SchrittgroesseFreq.setReadOnly(True)
        # Line Edit feste Frequenz_fester_Winkel
        self.field_fwuf_Freq.setText("299.792458e6")
        self.field_fwuf_Winkel.setText("25.0")


        # Combo Box
        self.med1comboBox.setStyleSheet("QComboBox::drop-down {border:0px; border-image: url(" + mainPath + "/images/icon-down1.png);}")
        self.med2comboBox.setStyleSheet("QComboBox::drop-down {border:0px; border-image: url(" + mainPath + "/images/icon-down1.png);}")
        self.med3comboBox.setStyleSheet("QComboBox::drop-down {border:0px; border-image: url(" + mainPath + "/images/icon-down1.png);}")
        self.med1comboBox.addItem("Plasma")
        self.med2comboBox.addItem("Glas")
        self.med3comboBox.addItem("deionisiertes Wasser")


        #################
        # Material TAB  #
        #################
        # Push Button
        # self.connect(self.btn_refresh, QtCore.SIGNAL("clicked()"), self.loadMaterialData)
        # self.connect(self.btn_Dialog, QtCore.SIGNAL("clicked()"), self.openDialog)

        # Material_Tabelle
        # Tabellen-Eigenschaften
        self.tableWidget.setSelectionBehavior(QtGui.QAbstractItemView.SelectRows)
        self.tableWidget.setEditTriggers(QtGui.QAbstractItemView.NoEditTriggers)
        # self.tableWidget.cellDoubleClicked.connect(self.tableToCombo)
        self.tableWidget.setSelectionBehavior(QtGui.QAbstractItemView.SelectRows)
        self.tableWidget.cellDoubleClicked.connect(self.onDoubleClicked)
        # Tabellen-Header und Spalten-Settings
        self.tableWidget.setColumnCount(3)
        self.tableWidget.setRowCount(16)
        # col_Headers = ['Kategorie', 'Materialname', 'εr', 'μr', 'spez. Leitf.', 'fmin', 'fmax']
        col_Headers = ['Medium 1', 'Medium 2', 'Medium 3']
        # Spaltenbreite
        __columnWidth = 371
        self.tableWidget.setColumnWidth(0, __columnWidth)
        self.tableWidget.setColumnWidth(1, __columnWidth)
        self.tableWidget.setColumnWidth(2, __columnWidth)
        self.tableWidget.setHorizontalHeaderLabels(col_Headers)
        # QTableWidget Items ( Zelleninhalte )
        self.tableWidget.setItem(0, 0, QtGui.QTableWidgetItem("Plasma"))
        self.tableWidget.setItem(0, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(0, 2, QtGui.QTableWidgetItem("deionisiertes Wasser"))

        self.tableWidget.setItem(1, 0, QtGui.QTableWidgetItem("Plasma"))
        self.tableWidget.setItem(1, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(1, 2, QtGui.QTableWidgetItem("Salzwasser"))

        self.tableWidget.setItem(2, 0, QtGui.QTableWidgetItem("Plasma"))
        self.tableWidget.setItem(2, 1, QtGui.QTableWidgetItem("deionisiertes Wasser /Teflon"))
        self.tableWidget.setItem(2, 2, QtGui.QTableWidgetItem("Glas"))

        self.tableWidget.setItem(3, 0, QtGui.QTableWidgetItem("Plasma"))
        self.tableWidget.setItem(3, 1, QtGui.QTableWidgetItem("deionisiertes Wasser"))
        self.tableWidget.setItem(3, 2, QtGui.QTableWidgetItem("Glas"))

        self.tableWidget.setItem(4, 0, QtGui.QTableWidgetItem("Luft"))
        self.tableWidget.setItem(4, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(4, 2, QtGui.QTableWidgetItem("deionisiertes Wasser"))

        self.tableWidget.setItem(5, 0, QtGui.QTableWidgetItem("Luft"))
        self.tableWidget.setItem(5, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(5, 2, QtGui.QTableWidgetItem("(Salz\)-Wasser"))

        self.tableWidget.setItem(6, 0, QtGui.QTableWidgetItem("Luft"))
        self.tableWidget.setItem(6, 1, QtGui.QTableWidgetItem("Wasser"))
        self.tableWidget.setItem(6, 2, QtGui.QTableWidgetItem("Luft"))

        self.tableWidget.setItem(7, 0, QtGui.QTableWidgetItem("Luft"))
        self.tableWidget.setItem(7, 1, QtGui.QTableWidgetItem("deionisiertes Wasser"))
        self.tableWidget.setItem(7, 2, QtGui.QTableWidgetItem("Glas"))

        self.tableWidget.setItem(8, 0, QtGui.QTableWidgetItem("dotierter Halbl."))
        self.tableWidget.setItem(8, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(8, 2, QtGui.QTableWidgetItem("Harz / Teflon"))

        self.tableWidget.setItem(9, 0, QtGui.QTableWidgetItem("Salzwasser"))
        self.tableWidget.setItem(9, 1, QtGui.QTableWidgetItem("Luft"))
        self.tableWidget.setItem(9, 2, QtGui.QTableWidgetItem("Glas"))

        self.tableWidget.setItem(10, 0, QtGui.QTableWidgetItem("Salzwasser"))
        self.tableWidget.setItem(10, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(10, 2, QtGui.QTableWidgetItem("Luft"))

        self.tableWidget.setItem(11, 0, QtGui.QTableWidgetItem("Salzwasser"))
        self.tableWidget.setItem(11, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(11, 2, QtGui.QTableWidgetItem("Plasma"))

        self.tableWidget.setItem(12, 0, QtGui.QTableWidgetItem("Kunstharz / Teflon"))
        self.tableWidget.setItem(12, 1, QtGui.QTableWidgetItem("Blei-Glas"))
        self.tableWidget.setItem(12, 2, QtGui.QTableWidgetItem("Teflon"))

        self.tableWidget.setItem(13, 0, QtGui.QTableWidgetItem("Kunstharz / Teflon"))
        self.tableWidget.setItem(13, 1, QtGui.QTableWidgetItem("Blei-Glas"))
        self.tableWidget.setItem(13, 2, QtGui.QTableWidgetItem("dotierter Halbleiter"))

        self.tableWidget.setItem(14, 0, QtGui.QTableWidgetItem("Kunstharz / Teflon"))
        self.tableWidget.setItem(14, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(14, 2, QtGui.QTableWidgetItem("Luft"))

        self.tableWidget.setItem(15, 0, QtGui.QTableWidgetItem("deionisiertes Wasser"))
        self.tableWidget.setItem(15, 1, QtGui.QTableWidgetItem("Glas"))
        self.tableWidget.setItem(15, 2, QtGui.QTableWidgetItem("Plasma"))
        # self.loadMaterialData()

        ######################
        # Einstellungen TAB  #
        ######################
        # CheckBox
        self.connect(self.checkBox_Plots, QtCore.SIGNAL("clicked()"), self.plotFlag)

        ###################
        # Hilfeseite TAB  #
        ###################
        self.connect(self.btn_theoriePDF, QtCore.SIGNAL("clicked()"), self.openTheoriePDF)
        self.connect(self.btn_projektstruktur, QtCore.SIGNAL("clicked()"), self.on_btn_projektstruktur)


    def lastSession(self):
        global Fall, shellScript, mainPath, teVersion, tmVersion, mainPath

        reader = csv.reader(open(mainPath + "/last_Session.csv"))
        my_csv_data = list(reader)

        if my_csv_data[0][0] == 'TE':

            self.btn_te_fall.setStyleSheet("background-color: #4cda43; color: #FFFFFF")
            self.btn_tm_fall.setStyleSheet("background-color: ")
            Fall = "TE"

            folder_back_array = [None] * 8
            for i in range(-1, -9, -1):
                folder_back_array[i + 8] = mainPath[i]
            folder_back_string = ''.join(folder_back_array)

            if folder_back_string == "Demo_GUI":
                os.chdir(mainPath + "/EW_Files/Bo2_d_16_TE")

            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)

            modus = my_csv_data[2][0]

            if modus == "fWuF":
                self.radioButton_festeWiuFreq.setChecked(True)
                self.enableFesteFreq_u_Winkel()
                sub_case_str = my_csv_data[1][0]
                self.field_fwuf_Freq.setText(my_csv_data[3][0])
                self.field_fwuf_Winkel.setText(my_csv_data[4][0])
                surfaceFlag = my_csv_data[5][0]
                if surfaceFlag == str(2):
                    self.cB_SurfaceFlag.setChecked(True)
                staticPlots = my_csv_data[6][0]
                if staticPlots == str(1):
                    self.checkBox_Plots.setChecked(True)
                legendFlag = my_csv_data[7][0]
                self.med1comboBox.addItem(my_csv_data[8][0])
                self.med2comboBox.addItem(my_csv_data[9][0])
                self.med3comboBox.addItem(my_csv_data[10][0])
                shellScript = "octave" + " " + teVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_fwuf_Freq.text() + " " + self.field_fwuf_Winkel.text() + " " + str(surfaceFlag) \
                              + " " + str(staticPlots) + " " + str(legendFlag)

            elif modus == "fF":
                self.radioButton_festeFrequenz.setChecked(True)
                self.enableFesteFrequenz()
                sub_case_str = my_csv_data[1][0]
                self.field_festeFrequenz.setText(my_csv_data[3][0])
                self.field_Startwinkel.setText(my_csv_data[4][0])
                self.field_Endwinkel.setText(my_csv_data[5][0])
                self.field_SchrittgroesseWinkel.setText(my_csv_data[6][0])
                surfaceFlag = my_csv_data[7][0]
                if surfaceFlag == str(2):
                    self.cB_SurfaceFlag.setChecked(True)
                staticPlots = my_csv_data[8][0]
                if staticPlots == str(1):
                    self.checkBox_Plots.setChecked(True)
                legendFlag = my_csv_data[9][0]
                self.med1comboBox.addItem(my_csv_data[10][0])
                self.med2comboBox.addItem(my_csv_data[11][0])
                self.med3comboBox.addItem(my_csv_data[12][0])
                shellScript = "octave" + " " + teVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_festeFrequenz.text() + " " + self.field_Startwinkel.text() \
                              + " " + self.field_Endwinkel.text() + " " + self.field_SchrittgroesseWinkel.text() \
                              + " " + str(surfaceFlag) + " " + str(staticPlots) + " " + str(legendFlag)

            # shellScript = "sh TE_Case"
            self.startOctaveThread()

        else:
            self.btn_tm_fall.setStyleSheet("background-color: #4cda43; color: #FFFFFF")
            self.btn_te_fall.setStyleSheet("background-color: ")
            Fall = "TM"

            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)

            folder_back_array = [None] * 8
            for i in range(-1, -9, -1):
                folder_back_array[i + 8] = mainPath[i]
            folder_back_string = ''.join(folder_back_array)

            if folder_back_string == "Demo_GUI":
                os.chdir(mainPath + "/EW_Files/Bo2_d_16_TM")


            modus = my_csv_data[2][0]

            if modus == "fWuF":
                self.radioButton_festeWiuFreq.setChecked(True)
                self.enableFesteFreq_u_Winkel()
                sub_case_str = my_csv_data[1][0]
                self.self.field_fwuf_Freq.setText(my_csv_data[3][0])
                self.field_fwuf_Winkel.setText(my_csv_data[4][0])
                surfaceFlag = my_csv_data[5][0]
                if surfaceFlag == str(2):
                    self.cB_SurfaceFlag.setChecked(True)
                staticPlots = my_csv_data[6][0]
                if staticPlots == str(1):
                    self.checkBox_Plots.setChecked(True)
                legendFlag = my_csv_data[7][0]
                self.med1comboBox.addItem(my_csv_data[8][0])
                self.med2comboBox.addItem(my_csv_data[9][0])
                self.med3comboBox.addItem(my_csv_data[10][0])
                shellScript = "octave" + " " + teVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_fwuf_Freq.text() + " " + self.field_fwuf_Winkel.text() + " " + str(surfaceFlag) \
                              + " " + str(staticPlots) + " " + str(legendFlag)

            elif modus == "fF":
                self.radioButton_festeFrequenz.setChecked(True)
                self.enableFesteFrequenz()
                sub_case_str = my_csv_data[1][0]
                self.field_festeFrequenz.setText(my_csv_data[3][0])
                self.field_Startwinkel.setText(my_csv_data[4][0])
                self.field_Endwinkel.setText(my_csv_data[5][0])
                self.field_SchrittgroesseWinkel.setText(my_csv_data[6][0])
                surfaceFlag = my_csv_data[7][0]
                if surfaceFlag == str(2):
                    self.cB_SurfaceFlag.setChecked(True)
                staticPlots = my_csv_data[8][0]
                if staticPlots == str(1):
                    self.checkBox_Plots.setChecked(True)
                legendFlag = my_csv_data[9][0]
                self.med1comboBox.addItem(my_csv_data[10][0])
                self.med2comboBox.addItem(my_csv_data[11][0])
                self.med3comboBox.addItem(my_csv_data[12][0])
                shellScript = "octave" + " " + teVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_festeFrequenz.text() + " " + self.field_Startwinkel.text() \
                              + " " + self.field_Endwinkel.text() + " " + self.field_SchrittgroesseWinkel.text() \
                              + " " + str(surfaceFlag) + " " + str(staticPlots) + " " + str(legendFlag)

            # shellScript = "sh TM_Case"
            self.startOctaveThread()


    def plotFlag(self):
        if self.checkBox_Plots.isChecked():
            self.groupBox_legend.setEnabled(True)
        else:
            self.groupBox_legend.setEnabled(False)


    def openTheoriePDF(self):
        dlg = QtGui.QFileDialog()
        dlg.setFileMode(QtGui.QFileDialog.AnyFile)
        dlg.setDirectory("../../EW_Common/Python/PDF")
        dlg.setFilter("Files (*.pdf *.txt)")        
        #filename = QtGui.QFileDialog.getOpenFileName()
        filename = None
        if dlg.exec_():
            filename = dlg.selectedFiles()
        
        if (filename):
            #subprocess.Popen(filename, shell=True)
            webbrowser.open_new(r'' + str(filename))




    def questionMarkButton(self):
        msgBox = QtGui.QMessageBox()
        msgBox.setIcon(QtGui.QMessageBox.Information)
        # msgBox.addButton(QtGui.QPushButton('Ok'), QtGui.QMessageBox.AcceptRole)
        msgBox.setWindowTitle("Fälle:")
        msgBox.setText("TE = Transversal Elektrisch;\nTM = Transversal Magnetisch;")
        msgBox.setStyleSheet("QMessageBox { background-color: #2b2b2b; }\n"
                             "QMessageBox QPushButton { border: 2px solid #5f5f5f;\n"
                             "border-radius: 4px;\n"
                             "color: #b6b9b8;\n"
                             "border-style: outset;\n"
                             "padding-top: 3px;\n"
                             "padding-bottom: 3px;\n"
                             "padding-left: 30px;\n"
                             "padding-right: 30px; }\n"
                             "QPushButton:hover:!pressed{ border-color: #7a8084;\n"
                             "background-color: #555a5c;}\n"
                             "QMessageBox QLabel { color: #b6b9b8; }")
        msgBox.exec_()


    def helpButtonTab(self):
        self.tabWidget.setCurrentIndex(4)


    def octaveDemo(self):
        global shellScript, mainPath, teVersion

        self.btn_te_fall.setStyleSheet("background-color: #4cda43; color: #FFFFFF")
        self.btn_tm_fall.setStyleSheet("background-color: ")
        Fall = "TE"

        self.med1comboBox.removeItem(0)
        self.med2comboBox.removeItem(0)
        self.med3comboBox.removeItem(0)
        self.med1comboBox.addItem("Plasma")
        self.med2comboBox.addItem("Glas")
        self.med3comboBox.addItem("deionisiertes Wasser")

        self.field_festeFrequenz.setText(str(299.792458e6))
        self.field_Startwinkel.setText(str(0))
        self.field_Endwinkel.setText(str(90))
        self.field_SchrittgroesseWinkel.setText(str(0.5))

        surfaceFlag = 1
        staticPlots = 0
        legendFlag = 2

        # wechselt in das Verzeichnis ../Bo2_d_16_TE
        # path = os.getcwd()
        folder_back_array = [None] * 8
        for i in range(-1, -9, -1):
            folder_back_array[i + 8] = mainPath[i]
        folder_back_string = ''.join(folder_back_array)

        if folder_back_string == "Demo_GUI":
            os.chdir(mainPath + "/EW_Files/Bo2_d_16_TE")

        modus = "fF"
        shellScript = "octave" + " " + teVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                      + self.field_festeFrequenz.text() + " " + self.field_Startwinkel.text() \
                      + " " + self.field_Endwinkel.text() + " " + self.field_SchrittgroesseWinkel.text() \
                      + " " + str(surfaceFlag) + " " + str(staticPlots) + " " + str(legendFlag)

        # Daten für last_Session
        writer = csv.writer(open(mainPath + "/last_Session.csv", "w"))
        daten = ([Fall],
                 [sub_case_str],
                 [modus],
                 [self.field_festeFrequenz.text()],
                 [self.field_Startwinkel.text()],
                 [self.field_Endwinkel.text()],
                 [self.field_SchrittgroesseWinkel.text()],
                 [surfaceFlag],
                 [staticPlots],
                 [legendFlag],
                 [str(self.med1comboBox.currentText())],
                 [str(self.med2comboBox.currentText())],
                 [str(self.med3comboBox.currentText())])
        writer.writerows(daten)

        self.startOctaveThread()


    def startOctaveThread(self):
        self.tabWidget.setCurrentIndex(1)
        cmd = shellScript
        if (self.__proc.pid()):
            self.__proc.close()
        
        # self.__proc = QtCore.QProcess(self)
        self.__proc.setProcessChannelMode(self.__proc.MergedChannels)
        self.__proc.start(cmd)
        self.__proc.readyReadStandardOutput.connect(lambda: self.readStdOutput(self.__proc))


    def readStdOutput(self, proc):
        global mainPath
        output = bytes(proc.readAllStandardOutput().data()).decode('utf8')
        if self.octave_output_checkBox.isChecked():
            self.textEdit_OctaveConsole.append(output)

        if self.octave_output_to_file_checkBox.isChecked():
            text_file = open(mainPath + "/Log.txt", "a")
            text_file.write('\n\n' + '#################### ' + datetime.datetime.fromtimestamp(time.time()).strftime('%d-%m-%Y %H:%M:%S') + ' ####################' + '\n\n')
            text_file.write(output)
            text_file.close()


    def startProgram(self):
        global shellScript, sub_case_str, mainPath, teVersion, tmVersion

        if Fall == "TE":

            # Daten für Flags
            if self.cB_SurfaceFlag.isChecked():
                surfaceFlag = 2
            else:
                surfaceFlag = 1

            if self.checkBox_Plots.isChecked():
                staticPlots = 1
                if self.radioButton_legend1.isChecked():
                    legendFlag = 2
                elif self.radioButton_legend2.isChecked():
                    legendFlag = 1
                else:
                    legendFlag = 0
            else:
                staticPlots = 0
                legendFlag = 2


            # wechselt in das Verzeichnis ../Bo2_d_16_TE
            # path = os.getcwd()
            folder_back_array = [None] * 8
            for i in range(-1, -9, -1):
                folder_back_array[i+8] = mainPath[i]
            folder_back_string = ''.join(folder_back_array)

            if folder_back_string == "Demo_GUI":
                os.chdir(mainPath + "/EW_Files/Bo2_d_16_TE")

            # definiert shell skript
            if self.radioButton_festeWiuFreq.isChecked():
                # fwuf = fester Winkel und Frequenz
                modus = "fWuF"
                shellScript = "octave" + " " + teVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_fwuf_Freq.text() + " " + self.field_fwuf_Winkel.text() + " " + str(surfaceFlag) \
                              + " " + str(staticPlots) + " " + str(legendFlag)

                # Daten für last_Session
                writer = csv.writer(open(mainPath + "/last_Session.csv", "w"))
                daten = ([Fall],
                         [sub_case_str],
                         [modus],
                         [self.field_fwuf_Freq.text()],
                         [self.field_fwuf_Winkel.text()],
                         [surfaceFlag],
                         [staticPlots],
                         [legendFlag],
                         [str(self.med1comboBox.currentText())],
                         [str(self.med2comboBox.currentText())],
                         [str(self.med3comboBox.currentText())])
                writer.writerows(daten)

            else:
                # feste Frequenz
                modus = "fF"
                shellScript = "octave" + " " + teVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_festeFrequenz.text() + " " + self.field_Startwinkel.text() \
                              + " " + self.field_Endwinkel.text() + " " + self.field_SchrittgroesseWinkel.text() \
                              + " " + str(surfaceFlag) + " " + str(staticPlots) + " " + str(legendFlag)

                # Daten für last_Session
                writer = csv.writer(open(mainPath + "/last_Session.csv", "w"))
                daten = ([Fall],
                         [sub_case_str],
                         [modus],
                         [self.field_festeFrequenz.text()],
                         [self.field_Startwinkel.text()],
                         [self.field_Endwinkel.text()],
                         [self.field_SchrittgroesseWinkel.text()],
                         [surfaceFlag],
                         [staticPlots],
                         [legendFlag],
                         [str(self.med1comboBox.currentText())],
                         [str(self.med2comboBox.currentText())],
                         [str(self.med3comboBox.currentText())])
                writer.writerows(daten)

            # shellScript = "sh TM_Case"
            self.startOctaveThread()
        else: # Fall == "TM"

            # Daten für Flags
            if self.cB_SurfaceFlag.isChecked():
                surfaceFlag = 2
            else:
                surfaceFlag = 1

            if self.checkBox_Plots.isChecked():
                staticPlots = 1
                if self.radioButton_legend1.isChecked():
                    legendFlag = 2
                elif self.radioButton_legend2.isChecked():
                    legendFlag = 1
                else:
                    legendFlag = 0
            else:
                staticPlots = 0
                legendFlag = 2


            # wechselt in das Verzeichnis ../Bo2_d_16_TE
            # path = os.getcwd()
            folder_back_array = [None] * 8
            for i in range(-1, -9, -1):
                folder_back_array[i + 8] = mainPath[i]
            folder_back_string = ''.join(folder_back_array)

            if folder_back_string == "Demo_GUI":
                os.chdir(mainPath + "/EW_Files/Bo2_d_16_TM")

            # definiert shell skript
            if self.radioButton_festeWiuFreq.isChecked():
                # fwuf = fester Winkel und Frequenz
                modus = "fWuF"
                shellScript = "octave" + " " + tmVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_fwuf_Freq.text() + " " + self.field_fwuf_Winkel.text() + " " + str(surfaceFlag) \
                              + " " + str(staticPlots) + " " + str(legendFlag)

                # Daten für last_Session
                writer = csv.writer(open(mainPath + "/last_Session.csv", "w"))
                daten = ([Fall],
                         [sub_case_str],
                         [modus],
                         [self.field_fwuf_Freq.text()],
                         [self.field_fwuf_Winkel.text()],
                         [surfaceFlag],
                         [staticPlots],
                         [legendFlag],
                         [str(self.med1comboBox.currentText())],
                         [str(self.med2comboBox.currentText())],
                         [str(self.med3comboBox.currentText())])
                writer.writerows(daten)

            else:
                # feste Frequenz
                modus = "fF"
                shellScript = "octave" + " " + tmVersion + " " + "Demo" + " " + sub_case_str + " " + modus + " " \
                              + self.field_festeFrequenz.text() + " " + self.field_Startwinkel.text() \
                              + " " + self.field_Endwinkel.text() + " " + self.field_SchrittgroesseWinkel.text() \
                              + " " + str(surfaceFlag) + " " + str(staticPlots) + " " + str(legendFlag)

                # Daten für last_Session
                writer = csv.writer(open(mainPath + "/last_Session.csv", "w"))
                daten = ([Fall],
                         [sub_case_str],
                         [modus],
                         [self.field_festeFrequenz.text()],
                         [self.field_Startwinkel.text()],
                         [self.field_Endwinkel.text()],
                         [self.field_SchrittgroesseWinkel.text()],
                         [surfaceFlag],
                         [staticPlots],
                         [legendFlag],
                         [str(self.med1comboBox.currentText())],
                         [str(self.med2comboBox.currentText())],
                         [str(self.med3comboBox.currentText())])
                writer.writerows(daten)

            # shellScript = "sh TM_Case"
            self.startOctaveThread()


    def teFall(self):
        self.btn_te_fall.setStyleSheet("background-color: #4cda43; color: #FFFFFF")
        self.btn_tm_fall.setStyleSheet("background-color: ")
        global Fall
        Fall = "TE"


    def tmFall(self):
        self.btn_tm_fall.setStyleSheet("background-color: #4cda43; color: #FFFFFF")
        self.btn_te_fall.setStyleSheet("background-color: ")
        global Fall
        Fall = "TM"


    def enableFesteFrequenz(self):
        # Feste Frequenz
        self.field_festeFrequenz.setEnabled(True)
        self.lbl_Startwinkel.setStyleSheet("color: #b6b9b8")
        self.field_Startwinkel.setEnabled(True)
        self.lbl_Endwinkel.setStyleSheet("color: #b6b9b8")
        self.field_Endwinkel.setEnabled(True)
        self.lbl_Schrittgroesse.setStyleSheet("color: #b6b9b8")
        self.field_SchrittgroesseWinkel.setEnabled(True)
        self.radioButton_festeFrequenz.setStyleSheet("color: #b6b9b8")
        # Fester Winkel
        self.field_festerWinkel.setEnabled(False)
        self.lbl_startFreq.setStyleSheet("color: #434749")
        self.field_startFreq.setEnabled(False)
        self.lbl_endFreq.setStyleSheet("color: #434749")
        self.field_endFreq.setEnabled(False)
        self.lbl_Schrittgroesse_2.setStyleSheet("color: #434749")
        self.field_SchrittgroesseFreq.setEnabled(False)
        self.radioButton_festerWinkel.setStyleSheet("color: #585e61")
        # Fester Winkel und Frequenz
        self.lbl_Freq.setStyleSheet("color: #434749")
        self.field_fwuf_Freq.setEnabled(False)
        self.lbl_Winkel.setStyleSheet("color: #434749")
        self.field_fwuf_Winkel.setEnabled(False)
        self.radioButton_festeWiuFreq.setStyleSheet("color: #585e61")


    def enableFesterWinkel(self):
        # Feste Frequenz
        self.field_festeFrequenz.setEnabled(False)
        self.lbl_Startwinkel.setStyleSheet("color: #434749")
        self.field_Startwinkel.setEnabled(False)
        self.lbl_Endwinkel.setStyleSheet("color: #434749")
        self.field_Endwinkel.setEnabled(False)
        self.lbl_Schrittgroesse.setStyleSheet("color: #434749")
        self.field_SchrittgroesseWinkel.setEnabled(False)
        self.radioButton_festeFrequenz.setStyleSheet("color: #585e61")
        # Fester Winkel
        self.field_festerWinkel.setEnabled(True)
        self.lbl_startFreq.setStyleSheet("color: #b6b9b8")
        self.field_startFreq.setEnabled(True)
        self.lbl_endFreq.setStyleSheet("color: #b6b9b8")
        self.field_endFreq.setEnabled(True)
        self.lbl_Schrittgroesse_2.setStyleSheet("color: #b6b9b8")
        self.field_SchrittgroesseFreq.setEnabled(True)
        self.radioButton_festerWinkel.setStyleSheet("color: #b6b9b8")
        # Fester Winkel und Frequenz
        self.lbl_Freq.setStyleSheet("color: #434749")
        self.field_fwuf_Freq.setEnabled(False)
        self.lbl_Winkel.setStyleSheet("color: #434749")
        self.field_fwuf_Winkel.setEnabled(False)
        self.radioButton_festeWiuFreq.setStyleSheet("color: #585e61")


    def enableFesteFreq_u_Winkel(self):
        # Feste Frequenz
        self.field_festeFrequenz.setEnabled(False)
        self.lbl_Startwinkel.setStyleSheet("color: #434749")
        self.field_Startwinkel.setEnabled(False)
        self.lbl_Endwinkel.setStyleSheet("color: #434749")
        self.field_Endwinkel.setEnabled(False)
        self.lbl_Schrittgroesse.setStyleSheet("color: #434749")
        self.field_SchrittgroesseWinkel.setEnabled(False)
        self.radioButton_festeFrequenz.setStyleSheet("color: #585e61")
        # Fester Winkel
        self.field_festerWinkel.setEnabled(False)
        self.lbl_startFreq.setStyleSheet("color: #434749")
        self.field_startFreq.setEnabled(False)
        self.lbl_endFreq.setStyleSheet("color: #434749")
        self.field_endFreq.setEnabled(False)
        self.lbl_Schrittgroesse_2.setStyleSheet("color: #434749")
        self.field_SchrittgroesseFreq.setEnabled(False)
        self.radioButton_festerWinkel.setStyleSheet("color: #585e61")
        # Fester Winkel und Frequenz
        self.lbl_Freq.setStyleSheet("color: #b6b9b8")
        self.field_fwuf_Freq.setEnabled(True)
        self.lbl_Winkel.setStyleSheet("color: #b6b9b8")
        self.field_fwuf_Winkel.setEnabled(True)
        self.radioButton_festeWiuFreq.setStyleSheet("color: #b6b9b8")


    def openLogWindow(self):
        self.logW = LogWindow()
        self.logW.exec_()
        # global dlgValue
        # dlgValue = self.logW.returnValue()


    def onDoubleClicked(self):
        if self.tableWidget.currentRow() == 0:
            sub_case_str = "1a1a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 1:
            sub_case_str = "1a1b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 2:
            sub_case_str = "1a2a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 3:
            sub_case_str = "1a2b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 4:
            sub_case_str = "1b1a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 5:
            sub_case_str = "1b1b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 6:
            sub_case_str = "1b2a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 7:
            sub_case_str = "1b2b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 8:
            sub_case_str = "2a1a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 9:
            sub_case_str = "2a1b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 10:
            sub_case_str = "2a2a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 11:
            sub_case_str = "2a2b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 12:
            sub_case_str = "2b1a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 13:
            sub_case_str = "2b1b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 14:
            sub_case_str = "2b2a"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())
        elif self.tableWidget.currentRow() == 15:
            sub_case_str = "2b2b"
            self.med1comboBox.removeItem(0)
            self.med2comboBox.removeItem(0)
            self.med3comboBox.removeItem(0)
            self.med1comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 0).text())
            self.med2comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 1).text())
            self.med3comboBox.addItem(self.tableWidget.item(self.tableWidget.currentRow(), 2).text())

        self.tabWidget.setCurrentIndex(1)

    def on_btn_projektstruktur(self):
        self.treeDiag = TreeDialog()
        self.treeDiag.exec_()
    
    def on_btn_clearConsole(self):
        self.textEdit_OctaveConsole.clear()
    
    def on_btn_clearConsole(self):
        self.textEdit_OctaveConsole.clear()


    def on_btn_Abbrechen(self):
        print(self.__proc.pid())
        if(self.__proc.pid()):
            os.kill(self.__proc.pid(), signal.SIGKILL)


    def on_btn_Pause(self):
        print(self.__proc.pid())
        if (self.__proc.pid()):
            os.kill(self.__proc.pid(), signal.SIGSTOP)


    def on_btn_Weiter(self):
        print(self.__proc.pid())
        if (self.__proc.pid()):
            self.__proc.write(".")
            os.kill(self.__proc.pid(), signal.SIGCONT)
    

class LogWindow(QtGui.QDialog, log):
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setupUi(self)
        self.LogWindow = None

        global mainPath

        # Push Button
        self.connect(self.btn_close, QtCore.SIGNAL("clicked()"), self.closeIt)
        # text File View
        if (os.path.exists('Log.txt')):
            __text = open(mainPath + '/Log.txt').read()
            self.textBrowser.append(__text)
        else:
            f = open("Log.txt","w+")
            __text = open(mainPath + '/Log.txt').read()
            self.textBrowser.append(__text)

    def closeIt(self):
        self.close()

class TreeDialog(QtGui.QDialog, tree):
    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setupUi(self)
        self.LogWindow = None

        # Push Button
        self.connect(self.btn_close, QtCore.SIGNAL("clicked()"), self.closeIt)

        self.getDirTree()

    def getDirTree(self):
        output = os.popen('tree ../../').read()
        self.textBrowser.setText(output)

    def closeIt(self):
        self.close()


if __name__ == "__main__":
    app = QtGui.QApplication(sys.argv)
    app.setWindowIcon(QtGui.QIcon(os.getcwd()+'/images/Gui_icon1.png'))
    Window = MainDlg()
    Window.show()
    sys.exit(app.exec_())
