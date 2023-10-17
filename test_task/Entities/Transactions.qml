import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/DefaultElements"
import "qrc:/Delegates"
Item {
    anchors.fill: parent
    TransactionAddPopup{
        id: addPopup
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        spacing: 20
        AbstractText {
            text: "<b>Транзакции<b>"
            Layout.alignment: Qt.AlignCenter
        }

        ScrollView {
            ScrollBar.horizontal.interactive: false
            ScrollBar.vertical.interactive: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            clip: true
            Layout.preferredHeight: parent.height/1.5
            Layout.fillWidth: true
            ListView {
                id: list_view1
                anchors.left: parent.left
                spacing: 10
                delegate: TransactionsModelDelegate {}
                model: transactionsModel
            }
        }
        AbstractButton {
            Layout.alignment: Qt.AlignCenter
            text: "Добавить запись"
            onClicked: {
                addPopup.open()
            }
        }
    }
}
