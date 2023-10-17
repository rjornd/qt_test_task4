import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/DefaultElements"

Popup {
    id: extInfoPopup
    modal: true
    focus: true
    parent: Overlay.overlay
    property var overlay: Overlay.overlay
    anchors.centerIn: overlay
    width: columnLayout.width + 80
    height: columnLayout.height + 80

    function unixTimeToText(unixTimestamp) {
        var date = new Date(unixTimestamp * 1000);
        return date.toLocaleString();
     }
    background: Rectangle {
        radius: 10
        color: colorPalette.accentBackgroundColor
        opacity: 0.9
        border {
            color: colorPalette.textColor
            width: 2
        }
    }

    contentItem: Item {
        anchors.fill: parent
        anchors.centerIn: parent
        ColumnLayout {
            spacing: 10
            id: columnLayout
            anchors.centerIn: parent
            GridLayout {
                rows: 2
                columns: 2
                id: addItmLayout
                Column {

                    AbstractText {
                        width: overlay.width/4
                        text: "ФИО: "
                    }
                    AbstractText{
                        width: overlay.width/4
                        text: firstName
                    }
                    AbstractText{
                        width: overlay.width/4
                        text: lastName
                    }
                }
                Column {

                    AbstractText {
                        width: overlay.width/4
                        text: "Тип: "
                    }
                    AbstractText{
                        width: overlay.width/4
                        text: type
                    }
                }
                Column {

                    AbstractText {
                        width: overlay.width/4
                        text: "Категория: "
                    }

                    AbstractText {
                        width: overlay.width/4
                        height: parent.height/2
                        id: categoryText
                        text: category
                    }
                }
                Column {

                    AbstractText {
                        width: overlay.width/4
                        text: "Сумма: "
                    }
                    AbstractText {
                        width: overlay.width/4
                        height: parent.height/2
                        text: operationAmount
                    }
                }
            }
            Column {
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth: true
                AbstractText {
                    text: "Описание: "
                }
                Rectangle {
                    width: overlay.width /2
                    height: overlay.height/4
                    color: 'white'
                    clip: true
                    AbstractTextArea {
                        id: desctiptionText
                        text: description
                        anchors.fill: parent
                        readOnly: true
                        wrapMode: Text.Wrap
                        verticalAlignment: Text.AlignTop
                    }
                }
                AbstractText {
                    text: "Время транзакции: "
                    horizontalAlignment: Text.AlignHCenter
                    width: overlay.width /2

                }
                AbstractText {
                    horizontalAlignment: Text.AlignHCenter
                    width: overlay.width /2
                    text: unixTimeToText(datetime)
                }
            }
        }

   }
}
