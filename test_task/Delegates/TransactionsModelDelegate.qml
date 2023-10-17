import QtQuick 2.15
import QtQuick.Layouts 1.15

import "qrc:/DefaultElements"
import "qrc:/Entities"
Rectangle {
    id: delegate
    width: ListView.view.width
    height: rowLayout.height
    border.width: 2

    MouseArea{
        anchors.fill: delegate
        onClicked: {
            extInfoPopup.open()
        }
        TransactionExtendedInfoPopup {
            id: extInfoPopup
        }
    }
    RowLayout {
        id: rowLayout
        anchors.leftMargin: 5
        anchors.fill: parent
        height: columnItem.height

        Column {
            id: columnItem
            Layout.preferredWidth: parent.width/2
            clip: true
            AbstractText {
                onFontChanged: delegate.height = font.pixelSize*3
                id: textitem
                text: "<b>Имя:</b> " + firstName
            }
            AbstractText {

                text: "<b>Фамилия:</b> " + lastName
            }
        }
            AbstractText {
                Layout.preferredWidth: parent.width/4
                text:"<b>Тип:</b> " +  type
            }

            AbstractText {
                Layout.preferredWidth: parent.width/4
                text: "<b>Сумма:</b> " + operationAmount
            }
    }

}

