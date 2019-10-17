import sqlite3
import sys, os
from PyQt4 import QtCore, QtGui
from DatabaseWindow import Ui_Database as maingui
from Eingabe import Ui_Eingabe as Eingabe_dialog
from Plot_dialog import Ui_Dialog as Plot_Dialog


class MainDlg(QtGui.QMainWindow, maingui):

    def __init__(self):
        QtGui.QMainWindow.__init__(self)
        self.setupUi(self)
        self.LogWindow = None
        self.__refreshFlag = False

        #Button
        self.connect(self.enter_btn, QtCore.SIGNAL("clicked()"), self.open_eingabe_Dialog)
        self.connect(self.refresh_btn, QtCore.SIGNAL("clicked()"), self.loadSQLData)
        self.connect(self.correct_btn, QtCore.SIGNAL("clicked()"), self.loadSQLData)
        self.connect(self.plotten_btn, QtCore.SIGNAL("clicked()"), self.on_plotten_btn)

        #ComboBox
        self.comboBox.addItem("ID")
        self.comboBox.addItem("Kategorie")
        self.comboBox.addItem("Materialname")
        self.comboBox.addItem("f_min")
        #self.connect(self.comboBox, QtCore.SIGNAL("highlighted()"), self.loadSQLData)
        self.comboBox.currentIndexChanged.connect(self.loadSQLData)

        #Search
        self.lineEdit.textChanged.connect(self.loadSQLData)

        #RadioButton
        self.connect(self.desc_btn, QtCore.SIGNAL("clicked()"), self.loadSQLData)
        self.connect(self.asc_btn, QtCore.SIGNAL("clicked()"), self.loadSQLData)

        #Tabelle
        self.tableWidget.setColumnCount(23)
        self.__col_Headers_Database = ['ID', 'Kategorie', 'Materialname', 'eps_r_fmin', 'eps_r_Fkt_Typ', 'eps_r_fmax', 'eps_r_a', 'eps_r_b', 'eps_r_c', 'kappa_fmin', 'kappa_Fkt_Typ', 'kappa_fmax', 'kappa_a', 'kappa_b', 'kappa_c', 'my_r_fmin', 'my_r_Fkt_Typ', 'my_r_fmax', 'my_r_a', 'my_r_b', 'my_r_c', 'f_min', 'f_max']
        self.__col_Headers_GUI = ['ID', 'Kategorie', 'Materialname', 'eps_r_fmin', 'eps_r_Fkt_Typ', 'eps_r_fmax', 'eps_r_a', 'eps_r_b', 'eps_r_c', 'kappa_fmin', 'kappa_Fkt_Typ', 'kappa_fmax', 'kappa_a', 'kappa_b', 'kappa_c', 'my_r_fmin', 'my_r_Fkt_Typ', 'my_r_fmax', 'my_r_a', 'my_r_b', 'my_r_c', 'f_min', 'f_max']
        self.tableWidget.setHorizontalHeaderLabels(self.__col_Headers_GUI)
        #self.tableWidget.setEditTriggers(QtGui.QAbstractItemView.NoEditTriggers)
        self.loadSQLData()
        #Signal and Slots
        self.tableWidget.cellChanged.connect(self.handleCellChanged)

    def open_eingabe_Dialog(self):
        self.dlg = Eingabe_Dialog()
        #proc = QtCore.QProcess(self)
        #proc.start(self.dlg.exec_())
        # self.dlg.exec_()
        self.dlg.show()
        self.loadSQLData()

    def loadSQLData(self):
        self.__refreshFlag = True
        connection = sqlite3.connect('material_db_01')

        if self.lineEdit.text() and self.desc_btn.isChecked():
            query_search = "SELECT * from materialien WHERE Materialname LIKE '%" + str(self.lineEdit.text()) + "%' ORDER BY " + str(self.comboBox.currentText()) + " DESC"
        elif self.lineEdit.text() and self.asc_btn.isChecked():
            query_search = "SELECT * from materialien WHERE Materialname LIKE '%" + str(self.lineEdit.text()) + "%' ORDER BY " + str(self.comboBox.currentText()) + " ASC"
        elif self.desc_btn.isChecked():
            query_search = "SELECT * from materialien ORDER BY " + str(self.comboBox.currentText()) + " DESC"
        else:
            query_search = "SELECT * from materialien ORDER BY " + str(self.comboBox.currentText()) + " ASC"

        result = connection.execute(query_search)
        self.tableWidget.setRowCount(0)
        for row_number, row_data in enumerate(result):
            self.tableWidget.insertRow(row_number)
            for column_number, data in enumerate(row_data):
                if column_number >= 21:
                    self.tableWidget.setItem(row_number, column_number, QtGui.QTableWidgetItem(str("{:.2e}".format(data))))
                else:
                    self.tableWidget.setItem(row_number, column_number, QtGui.QTableWidgetItem(str(data)))
        connection.close()
        self.__refreshFlag = False

    def handleCellChanged(self, row, column):
        if not self.__refreshFlag:
            if column == 0:
                self.loadSQLData()
                msgBox = QtGui.QMessageBox()
                msgBox.setIcon(QtGui.QMessageBox.Information)
                msgBox.setWindowTitle("Achtung!")
                msgBox.setText("ID kann nicht verändert werden!")
                msgBox.exec_()
            else:
                connection = sqlite3.connect('material_db_01')
                cursor = connection.cursor()
                if column == 1 or 2:
                    cursor.execute("UPDATE materialien SET " + str(self.__col_Headers_Database[column]) + " = " + "'" + str(
                        self.tableWidget.item(row, column).text()) + "'" + " WHERE ID = " + str(
                        self.tableWidget.item(row, 0).text()))
                else:
                    cursor.execute("UPDATE materialien SET " + str(self.__col_Headers_Database[column]) + " = " + str(
                        self.tableWidget.item(row, column).text()) + " WHERE ID = " + str(
                        self.tableWidget.item(row, 0).text()))


                connection.commit()
                connection.close()
            self.loadSQLData()

    def on_plotten_btn(self):
        if (self.tableWidget.currentRow()==-1):
            msgBox = QtGui.QMessageBox()
            msgBox.setIcon(QtGui.QMessageBox.Information)
            msgBox.setWindowTitle("Achtung!")
            msgBox.setText("Es wurde kein Datensatz ausgewählt!")
            msgBox.exec_() 
        else:
            self.dlg = Plot_Dialog(self.tableWidget.currentRow())
            self.dlg.exec_()
			    
			
            
class Eingabe_Dialog(QtGui.QDialog, Eingabe_dialog):

    def __init__(self):
        QtGui.QDialog.__init__(self)
        self.setupUi(self)
        self.LogWindow = None

        #Button
        self.connect(self.commit_btn, QtCore.SIGNAL("clicked()"), self.writeSQLData)

    def writeSQLData(self):
        connection = sqlite3.connect('material_db_01')
        cursor = connection.cursor()
        cursor.execute(
            "INSERT INTO materialien( Kategorie, Materialname, eps_r_fmin, eps_r_Fkt_Typ, eps_r_fmax, eps_r_a, eps_r_b, eps_r_c, kappa_fmin, kappa_Fkt_Typ, kappa_fmax, kappa_a, kappa_b, kappa_c, my_r_fmin, my_r_Fkt_Typ, my_r_fmax, my_r_a, my_r_b, my_r_c, f_min, f_max) VALUES(:kategorie, :materialname, :eps_r_fmin, :eps_r_Fkt_Typ, :eps_r_fmax, :eps_r_a, :eps_r_b, :eps_r_c, :kappa_fmin, :kappa_Fkt_Typ, :kappa_fmax, :kappa_a, :kappa_b, :kappa_c, :my_r_fmin, :my_r_Fkt_Typ, :my_r_fmax, :my_r_a, :my_r_b, :my_r_c, :f_min, :f_max)",
            {'kategorie': self.lineEdit_Category.text(), 'materialname': self.lineEdit_name.text(),
             'eps_r_fmin': self.lineEdit_epsilon_r_fmin.text(), 'eps_r_Fkt_Typ': self.lineEdit_eps_Fkt_Typ.text(),
             'eps_r_fmax': self.lineEdit_epsilon_r_fmax.text(),
             'eps_r_a': self.lineEdit_eps_a.text(), 'eps_r_b': self.lineEdit_eps_b.text(),
             'eps_r_c': self.lineEdit_eps_c.text(), 'kappa_fmin': self.lineEdit_kappa_fmin.text(),
             'kappa_Fkt_Typ': self.lineEdit_kappa_Fkt_Typ.text(), 'kappa_fmax': self.lineEdit_kappa_fmax.text(),
             'kappa_a': self.lineEdit_kappa_a.text(),
             'kappa_b': self.lineEdit_kappa_b.text(), 'kappa_c': self.lineEdit_kappa_c.text(),
             'my_r_fmin': self.lineEdit_my_r_fmin.text(), 'my_r_Fkt_Typ': self.lineEdit_my_Fkt_Typ.text(),
             'my_r_fmax': self.lineEdit_my_r_fmax.text(),
             'my_r_a': self.lineEdit_my_a.text(), 'my_r_b': self.lineEdit_my_b.text(),
             'my_r_c': self.lineEdit_my_c.text(), 'f_min': self.lineEdit_fmin.text(),
             'f_max': self.lineEdit_fmax.text()})
        connection.commit()
        connection.close()
        self.lineEdit_Category.clear()
        self.lineEdit_name.clear()
        self.lineEdit_epsilon_r_fmin.clear()
        self.lineEdit_eps_Fkt_Typ.clear()
        self.lineEdit_epsilon_r_fmax.clear()
        self.lineEdit_eps_a.clear()
        self.lineEdit_eps_b.clear()
        self.lineEdit_eps_c.clear()
        self.lineEdit_kappa_fmin.clear()
        self.lineEdit_kappa_Fkt_Typ.clear()
        self.lineEdit_kappa_fmax.clear()
        self.lineEdit_kappa_a.clear()
        self.lineEdit_kappa_b.clear()
        self.lineEdit_kappa_c.clear()
        self.lineEdit_my_r_fmin.clear()
        self.lineEdit_my_Fkt_Typ.clear()
        self.lineEdit_my_r_fmax.clear()
        self.lineEdit_my_a.clear()
        self.lineEdit_my_b.clear()
        self.lineEdit_my_c.clear()
        self.lineEdit_fmin.clear()
        self.lineEdit_fmax.clear()
        self.close()
        # self.loadSQLData()

class Plot_Dialog(QtGui.QDialog, Plot_Dialog):

    def __init__(self, currentRow):
        QtGui.QDialog.__init__(self)
        self.setupUi(self)
        self.LogWindow = None
        self.currentRow = currentRow
        print(self.currentRow+1)

        self.connect(self.btn_plot_dialog, QtCore.SIGNAL("clicked()"), self.__plot)
        self.spinBox.setMinimum(int(10))
        self.spinBox.setMaximum(int(10000))

    def __plot(self):
        connection = sqlite3.connect('material_db_01')
        query = "SELECT * FROM materialien WHERE ID=" + str(self.currentRow+1)
        result = connection.execute(query)
        self.proc = QtCore.QProcess(self)
        self.proc.setProcessChannelMode(self.proc.MergedChannels)
        # self.proc.start("octave test_epsmuekap_GUI.m " + str(self.spinBox.value()))
        # self.proc.readyReadStandardOutput.connect(lambda: self.readStdOutput(self.proc))
        for data in enumerate(result):
            self.proc.start("octave plot_epsmuekap_GUI.m " +
                            str(data[1][3]) + ' ' + str(data[1][4]) + ' ' + str(data[1][5]) + ' ' + str(data[1][6]) + ' '
                            + str(data[1][7]) + ' ' + str(data[1][8]) + ' ' + str(data[1][9]) + ' ' + str(data[1][10]) + ' '
                            + str(data[1][11]) + ' ' + str(data[1][12]) + ' ' + str(data[1][13]) + ' ' + str(data[1][14]) + ' '
                            + str(data[1][15]) + ' ' + str(data[1][16]) + ' ' + str(data[1][17]) + ' ' + str(data[1][18]) + ' '
                            + str(data[1][19]) + ' ' + str(data[1][20]) + ' ' + str(data[1][21]) + ' ' + str(data[1][22]) + ' '
                            + str(self.spinBox.value()))
            self.proc.readyReadStandardOutput.connect(lambda: self.readStdOutput(self.proc))
            print(data[1][3]) #bis data[1][22]
        
        self.accept()

    def readStdOutput(self, proc):
        output = bytes(proc.readAllStandardOutput().data()).decode('utf8')
        print(output)

if __name__ == "__main__":
    app = QtGui.QApplication(sys.argv)
    #app.setWindowIcon(QtGui.QIcon(os.getcwd()+'/images/Gui_icon1.png'))
    Window = MainDlg()
    Window.show()
    sys.exit(app.exec_())
