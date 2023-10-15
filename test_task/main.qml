import QtQuick 2.15
import QtQuick.Controls 2.15

import "qrc:/Entities"
import 'qrc:/DefaultElements'

ApplicationWindow {
    id: mainApplicationWindow
    width: 800
    height: 600
    minimumWidth: 800
    minimumHeight: 600

    visible: true
    title: qsTr("Family budget")

    property var colorPalette: Palette {}
    property real uiScaleFactor: 1.0

    onUiScaleFactorChanged: {
        if (uiScaleFactor >= 1.5) uiScaleFactor = 1.5
        if (uiScaleFactor <= 0.8) uiScaleFactor = 0.8
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
                name: "INCOMES"
                PropertyChanges { target: appRouter; source: "qrc:/Entities/Incomes.qml";}
            },
            State {
                name: "OUTCOMES"
                PropertyChanges { target: appRouter; source: "qrc:/Entities/Outcomes.qml";}
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




