import QtQuick 2.15
import QtQuick.Layouts 1.15
import ImageConnector 1.0
Item {
    id: delegate
    width: delegate.ListView.view.width;
    height: rowLayout.height
    clip: false
    anchors.margins: 4
    RowLayout {
        id: rowLayout
        anchors{
            left: parent.left
            top: parent.top
        }

        Text {
            text: firstName

        }
        Text {
            text: lastName
        }
        Item {
            width: 50
            height: 50
            ImageFromBlobDisplayer {
                widthRescale: 50
                heightRescale: 50
                image: iconBlob
            }
        }


    }
}
