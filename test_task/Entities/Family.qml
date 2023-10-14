import QtQuick 2.15
import "qrc:/DefaultElements"
import "qrc:/Delegates"
Item {
    anchors.fill: parent
    ListView {
        id: list_view1
        anchors.fill: parent

        delegate: FamilyModelDelegate {}
        model: familyModel
    }
}
