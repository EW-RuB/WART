#include "startdialog.h"
#include <QApplication>
#include <QProcess>
#include <QDebug>
#include <QDir>
#include <QIcon>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    a.setWindowIcon(QIcon("Gui_icon1.png"));
    //StartDialog w;
    //w.show();
    StartDialog *dialog = new StartDialog;
    dialog->exec();

    QString modeStatus;
    modeStatus = dialog->getMode();
    //qDebug() << modeStatus;
    //Demo-Mode
    if ( modeStatus == "Demo" ) {
        // current dir
        QDir dir;
        qDebug() << dir.absolutePath();
        // change dir
        if (!dir.cd("EW_Demo/Python")) {
            qWarning("Cannot find the \"Demo_GUI\" directory");
            qDebug() << dir.absolutePath();
        } else {
            // Starte QProcess
            QString argument = "python3 main.py";
            QProcess p;
            p.setWorkingDirectory(dir.absolutePath());
            p.start(argument);
            p.waitForFinished(-1);
            //qDebug() << "Start_Demo";
            //qDebug() << dir.absolutePath();
        }
    } else if ( modeStatus == "Expert" ) {
        // current dir
        QDir dir;
        qDebug() << dir.absolutePath();
        // change dir
        if (!dir.cd("EW_Advanced/Python")) {
            qWarning("Cannot find the \"Expert_GUI\" directory");
            //qDebug() << dir.absolutePath();
        } else {
            // Starte QProcess
            QString argument = "python3 main.py";
            QProcess p;
            qDebug() << dir.absolutePath();
            p.setWorkingDirectory(dir.absolutePath());
            p.start(argument);
            p.waitForFinished(-1);
            //qDebug() << "Start_Demo";
        }
    }

    return 0;
}
