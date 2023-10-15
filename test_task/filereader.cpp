#include "filereader.h"

FileReader::FileReader(QObject *parent)
    : QObject{parent}
{

}

QByteArray FileReader::read(const QUrl &fileurl)
{
    QFile file(fileurl.toLocalFile());
    if (!file.open(QIODevice::ReadOnly))
        return QByteArray();

    return file.readAll();
}

QImage FileReader::readAsImage(const QUrl &fileurl)
{
    QImage img;
    if(img.load(fileurl.toLocalFile()))
        return img;
    else {
        img.load(":/icons/missingImage");
    }
    return img;
}
