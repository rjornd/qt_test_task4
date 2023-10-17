import QtQuick 2.15
import QtQuick.Layouts 1.15
import "qrc:/DefaultElements"
Item {

    anchors.fill: parent
    AbstractText{
        id: toptxt
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Тестовое задание"

    }
    Column {
        anchors.left: parent.left
        anchors.top: toptxt.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20

        AbstractText {
            text: "Навигация: "
        }

        AbstractTextArea{
            text: "* По нажатию на кнопку в левом верхнем углу, открывается навигационное меню"
            width: parent.width
            wrapMode: Text.Wrap
        }
        AbstractTextArea{
            text: "* В правом верхнем углу расположены настройки отображения интерфейса"
            width: parent.width
            wrapMode: Text.Wrap
        }
        AbstractText {
            text: "Управление: "
        }
        AbstractTextArea{
            text: "* Клик по записи из меню 'Родственники' открывает окно редактирования, где также имеется возможность удалить запись"
            width: parent.width
            wrapMode: Text.Wrap
        }
        AbstractTextArea{
            text: "* Клик по записи из меню 'Транзакции' открывает окно просмотра дополнительной информации"
            width: parent.width
            wrapMode: Text.Wrap
        }
    }
}
