#ifndef FILEREADER_H
#define FILEREADER_H
#include <QObject>
#include <QFile>
#include <QUrl>
#include <QImage>
class FileReader : public QObject
{
    Q_OBJECT
public:
    explicit FileReader(QObject *parent = nullptr);

    Q_INVOKABLE QByteArray read(const QUrl &fileurl);
    Q_INVOKABLE QImage readAsImage(const QUrl &fileurl);
};

#endif // FILEREADER_H
