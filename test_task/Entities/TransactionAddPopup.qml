import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/DefaultElements"

Popup {
    id: transactionAddMemberPopup
    modal: true
    focus: true
    property var overlay: Overlay.overlay
    anchors.centerIn: overlay
    width: columnLayout.width + 80
    height: columnLayout.height + 80


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
                        text: "Пользователь: "
                    }
                    AbstractComboBox{
                        id: userComboBox
                        width: overlay.width/3
                        model: familyModel
                        textRole: "firstName"
                        property variant selectedUserId
                        Component.onCompleted: {
                            selectedUserId = model.getItemByIndexName(currentIndex, "id")
                        }

                        onActivated: {
                            if (currentIndex >= 0)
                            {
                                selectedUserId = model.getItemByIndexName(currentIndex, "id")
                                console.log("Selected ID: " + selectedUserId)
                            }
                        }
                    }
                }
                Column {
                    AbstractText {
                        text: "Тип: "
                    }
                    AbstractComboBox{
                        id: typeComboBox
                        model: ListModel {
                            ListElement { name: "Income" }
                            ListElement { name: "Outcome" }
                        }
                    }
                }
                Column {
                    AbstractText {
                        text: "Категория: "
                    }
                    Rectangle {

                        width: overlay.width/3
                        height: parent.height/2
                        color: 'white'
                        clip: true
                        AbstractTextInput {
                            id: categoryText
                            text: ""
                            anchors.fill: parent
                        }
                    }

                }
                Column {
                    AbstractText {
                        text: "Сумма: "
                    }
                    Rectangle {

                        width: overlay.width/5
                        height: parent.height/2
                        color: 'white'
                        clip: true
                        AbstractTextInput {
                            id: amountText
                            text: ""
                            anchors.fill: parent
                            inputMethodHints: Qt.ImhDigitsOnly
                            validator: IntValidator {
                                bottom: 0
                                top: 10000000
                            }
                        }
                    }
                }
            }

            Column {
                Layout.alignment: Qt.AlignCenter
                width: parent.width
                AbstractText {
                    text: "Описание: "

                }

                Rectangle {
                    width: overlay.width/2
                    height: overlay.height/4
                    color: 'white'
                    clip: true
                    AbstractTextArea {
                        id: desctiptionText
                        text: ""
                        anchors.fill: parent

                        wrapMode: Text.Wrap
                        verticalAlignment: Text.AlignTop
                    }
                }
            }
            AbstractButton{
                text: "Подтвердить"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    DatabaseProxy.onAddTransactionItem(userComboBox.selectedUserId, typeComboBox.currentText,
                                                       categoryText.text, amountText.text, desctiptionText.text)
                    transactionAddMemberPopup.close()


                    categoryText.text=""
                    amountText.text=""
                    desctiptionText.text=""
                }
            }

        }

       }
}
