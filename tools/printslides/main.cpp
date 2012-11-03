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

#include <QtGui>
#include "slideview.h"

/** PrintSlides main program.
    A program to print qt-labs qml-presentation-system Presentations.
    @author ezust@ics.com
*/
int main (int argc, char* argv[]) {
    QGuiApplication app(argc, argv);
    app.setOrganizationDomain("com");
    app.setOrganizationName("ics");
    app.setApplicationName("printslides");
    app.setApplicationVersion("0.2");
    app.setApplicationDisplayName("QML Presentation Slide Printer");
    SlideView mainView;
    mainView.setSource(app.arguments()[1]);
    mainView.show();
    return app.exec();
}
