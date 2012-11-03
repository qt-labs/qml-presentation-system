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

#ifndef SLIDEVIEW_H
#define SLIDEVIEW_H

#include <QQuickView>
#include <QPrinter>
#include <QPainter>

/** A class for viewing and printing a QML Presentation with Slides.
    Assumes the root object of the QML file that was loaded is derived from
    Presentation from qt-labs qml-presentation-system
    git clone git://gitorious.org/qt-labs/qml-presentation-system.git
*/
class SlideView : public QQuickView {
    Q_OBJECT
public:
    SlideView(QWindow* parent=0);
public slots:
    void updateStatus(QQuickView::Status);
    void timerEvent(QTimerEvent* evt);
    void printCurrentSlide();
    void goToNextSlide();

private:
    int m_slidesLeft;
    int m_printedSlides;
    int m_tid;

    QPrinter m_printer;
    QPainter m_painter;
};

#endif        //  #ifndef SLIDEVIEW_H
