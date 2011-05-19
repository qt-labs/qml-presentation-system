import QtQuick 2.0

Item
{
    height: 640
    width: 360
    Item {
        rotation: 90
        SlideDeck {
            y: -360
            width: 640
            height: 360
        }
    }
}
