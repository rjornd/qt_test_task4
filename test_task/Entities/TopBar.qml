import QtQuick 2.15
import QtQuick.Layouts 1.15

import "qrc:/DefaultElements"

Item {
    id: topBar

    anchors {
        top: parent.top
        right: parent.right
        left: parent.left
    }

    height: contextMenuLayout.height

    Rectangle {
        anchors.fill: parent
        color: colorPalette.accentBackgroundColor
        id: contextMenu

        RowLayout {
            id: contextMenuLayout
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10
            }
            spacing: 10

            AbstractImage {
                id: menuBtn
                source: "qrc:/icons/menuBlack"
                function onClickedAction () {
                    navigationPopup.open()
                }
            }

            AbstractImage {
                id: homeBtn
                source: "qrc:/icons/homeBlack"
                function onClickedAction () {
                    appRouter.state = "HOME"
                }
            }

        }
        RowLayout {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 10
            }
            AbstractImage {
                id: settingsBtn
                source: "qrc:/icons/settingsBlack"
                function onClickedAction () {
                    settingsPopup.open()
                }
            }
        }
    }
}

