import QtQuick 2.15
import QtQuick.Controls 2.15

import "../utils"

Rectangle {
    id: root

    width: 500
    height: 200
    border.color: "lightgrey"
    radius: 5

    property string firstName
    property string lastName
    property string emailAddres

    property var employee: {
        "index": "", "firstName": "", "lastName": "", "emailAddress": ""
    }

    signal backToList()

    Column {
        id: title
        spacing: 10
        width: parent.width - 30
        topPadding: 15
        anchors.horizontalCenter: parent.horizontalCenter

        // Page Title
        Text {
            text: qsTr("Employee Details")
            font {
                family: "Arial"
                pixelSize: 16
            }
        }

        MyUnderline {
            width: parent.width
        }
    }

    Column {
        id: details
        spacing: 10
        width: parent.width - 30
        anchors {
            top: title.bottom
            topMargin: 15
            horizontalCenter: parent.horizontalCenter
        }

        Text { text: "<b>First Name:  </b>" + root.employee.firstName }
        Text { text: "<b>Last Name:  </b>" + root.employee.lastName }
        Text { text: "<b>Email Address:  </b>" + root.employee.emailAddress }
    }

    RoundButton {
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            left: parent.left
            leftMargin: 15
        }

        text: "Back to Employee List"
        palette.button: "#4169e1"
        radius: 4

        onClicked: {
            backToList();
        }
    }
}



