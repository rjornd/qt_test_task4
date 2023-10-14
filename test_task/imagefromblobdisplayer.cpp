#include "imagefromblobdisplayer.h"

ImageFromBlobDisplayer::ImageFromBlobDisplayer(QQuickPaintedItem *parent)
    : QQuickPaintedItem{parent}
{

}

void ImageFromBlobDisplayer::setImage(const QImage &image){
    m_image = image;
    emit imageChanged();
    update();
    setImplicitHeight(image.height());
    setImplicitWidth(image.width());
}

void ImageFromBlobDisplayer::paint(QPainter *painter){

    m_image = m_image.scaled(widthRescale, heightRescale, Qt::KeepAspectRatio);
    if(m_image.isNull()) return;
    painter->drawImage(0,0,m_image);
}

int ImageFromBlobDisplayer::getWidthRescale() const
{
    return widthRescale;
}

void ImageFromBlobDisplayer::setWidthRescale(int newWidthRescale)
{
    if (widthRescale == newWidthRescale)
        return;
    widthRescale = newWidthRescale;
    emit widthRescaleChanged();
}

int ImageFromBlobDisplayer::getHeightRescale() const
{
    return heightRescale;
}

void ImageFromBlobDisplayer::setHeightRescale(int newHeightRescale)
{
    if (heightRescale == newHeightRescale)
        return;
    heightRescale = newHeightRescale;
    emit heightRescaleChanged();
}
