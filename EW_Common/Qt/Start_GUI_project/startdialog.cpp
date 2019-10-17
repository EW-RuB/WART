#include "startdialog.h"
#include "ui_startdialog.h"
#include <QDebug>
#include <QString>

QString modeStatus;

StartDialog::StartDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::StartDialog)
{
    ui->setupUi(this);

    connect(ui->btn_demo, SIGNAL(clicked()), this, SLOT(on_demo()));
    connect(ui->btn_expert, SIGNAL(clicked()), this, SLOT(on_expert()));

}

StartDialog::~StartDialog()
{
    delete ui;
}

void StartDialog::on_demo() {
    modeStatus = "Demo";
    close();
}

void StartDialog::on_expert() {
    modeStatus = "Expert";
    close();
}

QString StartDialog::getMode() {
    qDebug() << modeStatus;
    return modeStatus;
}


