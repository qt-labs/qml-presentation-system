/*          DO WHAT THE FRAK YOU WANT TO PUBLIC LICENSE (WTFPL)
                    Version 4, October 2012
	    Based on the wtfpl: http://sam.zoy.org/wtfpl/

 Copyright (C) 2012 Alan Ezust

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FRAK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FRAK YOU WANT TO.
  1. It is provided "as is" without any warranty whatsoever.
*/

#include <QtQml>
#include <QQuickItem>
#include <QDebug>
#include <QPixmap>
#include <QScreen>
#include "slideview.h"

SlideView::SlideView(QWindow* parent): QQuickView(parent),
m_slidesLeft(0), m_printedSlides(0) {
    connect (this, SIGNAL(statusChanged(QQuickView::Status)),
        this, SLOT(updateStatus(QQuickView::Status)));
}

void SlideView::updateStatus(QQuickView::Status status) {
    if (m_slidesLeft > 0) return;
    if (status != QQuickView::Ready) return;
    QQuickItem *ri = rootObject();
    QString superClass = ri->metaObject()->superClass()->className();
    if (!superClass.startsWith("Presentation")) {
        qWarning("Warning: Superclass appears to not be a Presentation: %s. ", superClass.toLocal8Bit().constData());
    }
    else qDebug() << "Found qml Presentation as rootObject";

    QList<QVariant> slides = ri->property("slides").toList();
    m_slidesLeft = slides.size();
    qDebug() << "SlideCount: " << m_slidesLeft;
    qDebug() << "Printer's Page rect size (and suggested resolution of your presentation): " << m_printer.pageRect().size();
    m_printer.setOrientation(QPrinter::Landscape);
    m_printer.setFullPage(true);
    m_printer.setOutputFileName("slides.pdf");
    m_painter.begin(&m_printer);

    // it would be better if we used the printer resolution here and forced
    // the presentation to be in the same resolution but when I try that,
    // the timer doesn't work properly for some reason?

    setHeight(ri->height());
    setWidth(ri->width());

    // Try uncommenting the below 4 lines and see what happens.
    //setHeight(m_printer.pageRect().height());
    //setWidth(m_printer.pageRect().width());
    //ri->setHeight(height());
    //ri->setWidth(width());

    // start timer to print out pages once every 2 seconds.
    m_tid = startTimer(2000);
}

void SlideView::timerEvent(QTimerEvent*) {
    printCurrentSlide();
    ++m_printedSlides;
    --m_slidesLeft;
    if (m_slidesLeft > 0) {
        m_printer.newPage();
        goToNextSlide();
    }
    else {
        killTimer(m_tid);
        m_painter.end();
        qDebug() << "Printed to file: " << m_printer.outputFileName();
        qApp->exit();
    }

}


void SlideView::printCurrentSlide() {
    QImage pix = grabWindow();
    qDebug() << "Printing slide#" << m_printedSlides + 1 << "Resolution:" << pix.size();
    QSize targetSize = m_printer.pageRect().size();
    m_painter.drawImage(m_printer.pageRect().x(), m_printer.pageRect().y(), pix.scaled(targetSize, Qt::KeepAspectRatio, Qt::SmoothTransformation) );
}

void SlideView::goToNextSlide() {
    static const QMetaObject* meta = rootObject()->metaObject();
    meta->invokeMethod(rootObject(), "goToNextSlide");
}
