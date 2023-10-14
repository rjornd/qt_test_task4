#ifndef IMAGEFROMBLOBDISPLAYER_H
#define IMAGEFROMBLOBDISPLAYER_H

#include <QObject>
#include <QPainter>
#include <QQuickPaintedItem>
class ImageFromBlobDisplayer : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(int widthRescale READ getWidthRescale WRITE setWidthRescale NOTIFY widthRescaleChanged)
    Q_PROPERTY(int heightRescale READ getHeightRescale WRITE setHeightRescale NOTIFY heightRescaleChanged)
public:
    explicit ImageFromBlobDisplayer(QQuickPaintedItem *parent = nullptr);
    QImage image() const { return m_image;}
    void setImage(const QImage& image);
    void paint(QPainter *painter);
    int getWidthRescale() const;
    void setWidthRescale(int newWidthRescale);
    int getHeightRescale() const;
    void setHeightRescale(int newHeightRescale);

private:
    QImage m_image;
    int widthRescale = 100;
    int heightRescale = 100;

signals:
    void imageChanged();
    void widthRescaleChanged();
    void heightRescaleChanged();
};

#endif // IMAGEFROMBLOBDISPLAYER_H
