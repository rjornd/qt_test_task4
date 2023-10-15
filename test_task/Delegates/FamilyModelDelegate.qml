import QtQuick 2.15
import QtQuick.Layouts 1.15
import ImageConnector 1.0

import "qrc:/DefaultElements"
import "qrc:/Entities"
Item {
    id: delegate
    width: ListView.view.width
    height: rowLayout.height

    MouseArea{
        anchors.fill: delegate
        onClicked: {
            console.log('<b>Имя:</b> ' + firstName)
            updatePopup.open()
        }
    }

    FamilyItemUpdatePopup {
        id: updatePopup
    }

    RowLayout {
        id: rowLayout
        spacing: 20

        anchors{
            left: parent.left
            top: parent.top
            right: parent.right
        }
        Column {

            AbstractText { text: '<b>Имя:</b> ' + firstName }
            AbstractText { text: '<b>Фамилия:</b> ' + lastName }
        }

        Item {
            Layout.alignment: Qt.AlignRight
            width: 150
            height: 150
            ImageFromBlobDisplayer {

                widthRescale: 150
                heightRescale: 150
                image: iconBlob
            }
        }
    }
}
