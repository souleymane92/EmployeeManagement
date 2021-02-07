import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {
    id: root

    width: Screen.width
    height: 12 * Screen.pixelDensity
    color: "#4169e1"

    property bool listRequest: true

    // Employee list Button
    Rectangle {
        id: employeeListBtn
        width: 30 * Screen.pixelDensity
        height: parent.height
        color: parent.color

        Text {
            anchors.centerIn: parent
            color: "#ffffff"
            text: qsTr("Employee List")
            font.pixelSize: 12
            opacity: root.listRequest ? 1 : 0.5
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.listRequest = true;
            }
        }
    }

    // Add Employee Button
    Rectangle {
        anchors.left: employeeListBtn.right
        width: 30 * Screen.pixelDensity
        height: parent.height
        color: parent.color

        Text {
            anchors.centerIn: parent
            color: "#ffffff"
            text: qsTr("Add Employee")
            font.pixelSize: 12
            opacity: root.listRequest ? 0.5 : 1
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.listRequest = false;
            }
        }
    }
}

