import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/DefaultElements"
Popup {
    id: navBar
    modal: true
    focus: true
    clip: true
    parent: Overlay.overlay
    height: parent.height
    width: parent.width/2.5
    x: 0
    enter: Transition {
            NumberAnimation { properties: "width"; from: 0; to: parent.width/2.5; duration: 500}
    }
    exit: Transition {
            NumberAnimation { properties: "width"; from: parent.width/2.5; to: 0; duration: 500}
    }

    contentItem: Item{
        id: contentItm
        ColumnLayout {
            id: navbarLayout
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: 20

            AbstractText{
                id: navmenuText
                text: "Меню навигации"
                Layout.alignment: Qt.AlignRight
            }
            Item {
                Layout.preferredHeight: txtFamily.height + 10
                Layout.preferredWidth: navbarLayout.width
                AbstractText{
                    id: txtFamily
                    text: "Семья"
                    anchors.verticalCenter: parent.verticalCenter
                    color: colorPalette.linkColor
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Семья")
                        appRouter.state = "FAMILY"
                        navBar.close()
                    }
                }
            }
            Item {
                Layout.preferredHeight: txtFamily.height + 10
                Layout.preferredWidth: navbarLayout.width
                AbstractText{
                    id: txtIncomes
                    text: "Доходы"
                    anchors.verticalCenter: parent.verticalCenter
                    color: colorPalette.linkColor
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Доходы")
                        appRouter.state = "INCOMES"
                        navBar.close()
                    }
                }
            }
            Item {
                Layout.preferredHeight: txtFamily.height + 10
                Layout.preferredWidth: navbarLayout.width
                AbstractText{
                    id: txtOutcomes
                    text: "Расходы"
                    anchors.verticalCenter: parent.verticalCenter
                    color: colorPalette.linkColor
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Расходы")
                        appRouter.state = "OUTCOMES"
                        navBar.close()
                    }
                }
            }
        }
    }
}
