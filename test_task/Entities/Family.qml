import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/DefaultElements"
import "qrc:/Delegates"
Item {
    anchors.fill: parent
    FamilyAddMemberPopup {
        id: addPopup
    }
        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width/1.3
            anchors.bottom: parent.bottom
            anchors.margins: 20
            spacing: 20
            AbstractText {
                text: "<b>Родственники<b>"
                Layout.alignment: Qt.AlignCenter
            }

            ScrollView {
                ScrollBar.horizontal.interactive: false
                ScrollBar.vertical.interactive: true
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                clip: true
                Layout.preferredHeight: parent.height/1.5
                width: parent.width
                ListView {
                    id: list_view1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 10
                    delegate: FamilyModelDelegate {}
                    model: familyModel
                }
                Layout.alignment: Qt.AlignCenter
            }
            AbstractButton {
                Layout.alignment: Qt.AlignCenter
                text: "Добавить"
                onClicked: {
                    addPopup.open()
                }
            }
        }
}
