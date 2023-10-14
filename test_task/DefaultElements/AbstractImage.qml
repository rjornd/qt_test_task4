import QtQuick 2.15
import QtQuick.Layouts 1.15
Item {
    id: itm
    property variant source
    function onClickedAction() {} // onClicked event handler

    Layout.preferredWidth: 40 * uiScaleFactor
    Layout.preferredHeight: 40 * uiScaleFactor

    MouseArea{
        anchors.fill: parent
        onPressed: anim.start()
        onClicked: {
            onClickedAction()
        }

        Image {
            id: img
            anchors.fill: parent
            source: itm.source
        }
    }

    SequentialAnimation {
        id: anim

        PropertyAnimation {
            target: img
            property: "scale"
            to: 1.2
            duration: 200
            easing.type: Easing.InOutQuad
        }

        PropertyAnimation {
            target: img
            property: "scale"
            to: 1.0
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
}
