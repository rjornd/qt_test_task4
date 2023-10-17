import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/Entities"
import 'qrc:/DefaultElements'

ApplicationWindow {
    id: mainApplicationWindow
    width: 900
    height: 600
    minimumWidth: 900
    minimumHeight: 600

    visible: true
    title: qsTr("Family budget")

    property var colorPalette: Palette {}
    property real uiScaleFactor: 1.0

    onUiScaleFactorChanged: {
        if (uiScaleFactor >= 1.4) uiScaleFactor = 1.4
        if (uiScaleFactor <= 0.7) uiScaleFactor = 0.7
    }

    color: colorPalette.backgroundColor

    TopBar {
        id: topBar
    }

    Loader {
        id: appRouter
        anchors{
            top: topBar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        states: [
            State {
                name: "HOME"
                PropertyChanges { target: appRouter; source: "qrc:/Entities/Home.qml";}
            },
            State {
                name: "FAMILY"
                PropertyChanges { target: appRouter; source: "qrc:/Entities/Family.qml";}
            },
            State {
                name: "TRANSACTIONS"
                PropertyChanges { target: appRouter; source: "qrc:/Entities/Transactions.qml";}
            }
        ]
        Component.onCompleted: {
            appRouter.state = "HOME"
        }
    }

    SettingPopup {
        id: settingsPopup
    }
    LeftSideBarPopup{
        id: navigationPopup
    }
}




