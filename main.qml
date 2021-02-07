import QtQuick 2.15
import QtQuick.Window 2.15

import "utils"
import "contents"

Window {
    id: root

    visible: true
    visibility: qsTr("Maximized")
    title: qsTr("Management App")

    // Header section
    AppHeader {
        id: header
        width: parent.width;
        height: 12 * Screen.pixelDensity
    }

    // Content Section
    Column {
        id: appTitle
        width: 600
        spacing: 10
        anchors {
            top: header.bottom;
            topMargin: 15
            horizontalCenter: parent.horizontalCenter
        }

        // Title
        Text {
            id: titleText
            text: qsTr("Employee Management App")
            font { family: "Arial"; pixelSize: 18 }
        }

        MyUnderline {
            anchors.horizontalCenter: parent.horizontalCenter
            width: appTitle.width
        }

        // Employee list Page
        EmployeeList {
            id: employeeList
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: employeeList.showDetails ? 250 : 300
            visible: header.listRequest
            clip: true
        }

        // Add Employee Page
        AddEmployee {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 300
            visible: !header.listRequest

            onSubmitted: {
                employeeModel.add(employee);
                header.listRequest = true;
            }

            onUpdateCancelled: {
                header.listRequest = true;
            }
        }
    }
}
