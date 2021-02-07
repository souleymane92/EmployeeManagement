import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    id: root

    property string label
    property var validPatern: /.*/
    property int maxLength: 30
    property string lastText
    property alias input: control

    Label { text: root.label + qsTr(":") }

    TextField {
        id: control
        background: Rectangle {
            width: 250; height: 30; radius: 4
            border.color: control.activeFocus ? "blue" : "lightgrey"
        }
        text: root.lastText

        validator: RegExpValidator
        { regExp: root.validPatern }

        maximumLength: root.maxLength
    }
}
