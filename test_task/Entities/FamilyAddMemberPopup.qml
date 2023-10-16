import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ImageConnector 1.0
import QtQuick.Dialogs 1.3 //sudo apt install qml-module-qtquick-dialogs
import "qrc:/DefaultElements"


Item {
    function open(){
        familyAddMemberPopup.open()
    }
    function close(){
        familyAddMemberPopup.close()
    }
    property variant savedImageByteArray;

FileDialog {
    id: fileDialog
    title: "Please choose a file"
    folder: shortcuts.home
    onAccepted: {
        fileDialog.close()
        imgFromFile.image = FileReader.readAsImage(fileDialog.fileUrl)
        savedImageByteArray = FileReader.read(fileDialog.fileUrl)
    }
    onRejected: {
       fileDialog.close()
    }
}


Popup {
    id: familyAddMemberPopup
    modal: true
    focus: true
    property var overlay: Overlay.overlay
    anchors.centerIn: overlay
    width: updateLayout.width + 80
    height: updateLayout.height + 80


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
            id: updateLayout
            anchors.centerIn: parent
            spacing: 15
            Column {
                spacing: 20
                Row {
                    AbstractText {
                        text: "Имя: "
                        width: 150
                        Layout.alignment: Qt.AlignCenter
                    }
                    Rectangle {
                        width: overlay.width/3
                        height: textInput1.font.pixelSize*2
                        clip: true
                        AbstractTextInput {
                            id: textInput1
                            text: "Введите имя"
                            width: parent.width
                            verticalAlignment: TextInput.AlignVCenter
                        }
                    }
                }
                Row {
                    AbstractText {
                        width: 150
                        text: "Фамилия: "
                        Layout.alignment: Qt.AlignCenter
                    }
                    Rectangle {
                        width: overlay.width/3
                        height: textInput2.font.pixelSize*2
                        clip: true
                        AbstractTextInput {
                            id: textInput2
                            text: "Введите фамилию"
                            width: parent.width
                        }
                    }
                }
                AbstractButton {
                    text: "Подтвердить"
                    onClicked: {
                        DatabaseProxy.onAddFamilyMember(textInput1.text , textInput2.text, savedImageByteArray)
                        familyAddMemberPopup.close();
                    }
                }
            }
            Item {
                width: 150
                height: 150
                ImageFromBlobDisplayer {
                    id: imgFromFile
                    widthRescale: 150
                    heightRescale: 150
                    image: FileReader.readAsImage("qrc:/icons/missingImage")
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        fileDialog.open()
                    }
                }
            }
        }
    }
}
}
