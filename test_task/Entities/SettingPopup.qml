import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/DefaultElements"



Popup {
    id: settingsPopup
    modal: true
    focus: true
    anchors.centerIn: parent
    width: settingsLayout.width + 80
    height: settingsLayout.height + 80


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
        RowLayout {
            id: settingsLayout
            anchors.centerIn: parent

            AbstractText {
                text: "Размер интерфейса: "
                Layout.alignment: Qt.AlignCenter
            }

            Slider {
                from: 0.7
                to: 1.4
                value: 0.9
                Layout.alignment: Qt.AlignCenter
                live: false
                onValueChanged: {
                    uiScaleFactor = value
                }
            }
        }
    }

}
