import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "../utils"

Rectangle {
    id: root

    width: 500
    height: 200
    border.color: "lightgrey"
    radius: 5

    readonly property alias showDetails: internal.detailsRequest

    QtObject {
        id: internal
        property bool listRequest: true
        property bool detailsRequest: false
        property var employee: {
            "index": 0, "firstName": "", "lastName": "", "emailAddress": ""
        }
    }


    Column {
        id: subTitle
        visible: internal.listRequest
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 30
        spacing: 10

        // Page Title
        Text {
            topPadding: 15
            text: qsTr("Employee List")
            font {
                family: "Arial"
                pixelSize: 16
            }
        }

        MyUnderline {
            width: parent.width
        }
    }

    // Employee List
    ListView {
        id: listView

        visible: internal.listRequest
        width: subTitle.width
        height: parent.height - subTitle.height
        clip: true

        anchors {
            top: subTitle.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 10

        model: employeeModel

        delegate: Employee {
            width: listView.width

            myIndex: index
            firstName: rFirstName
            lastName: rLastName
            emailAddress: rEmail

            onDeleteRequest: {
                employeeModel.remove(index);
            }

            onUpdateRequest: {
                internal.employee = employee;
                internal.listRequest = false;
                internal.detailsRequest = false;
            }

            onDetailsRequest: {
                internal.employee = employee;
                internal.detailsRequest = true;
                internal.listRequest = false;
            }
        }
    }

    // Update Employee
    UpdateEmployee {
        id: update

        visible: !internal.listRequest && !internal.detailsRequest
        anchors {
            fill: parent
            horizontalCenter: parent.horizontalCenter
        }

        employee: internal.employee

        onSubmitted: {
            employeeModel.set(internal.employee.index, employee);
            internal.listRequest = true;
        }

        onUpdateCancelled: {
            internal.listRequest = true;
        }
    }

    // Employee Details
    EmployeeDetails {
        visible: internal.detailsRequest
        anchors.fill: parent

        employee: internal.employee

        onBackToList: {
            internal.detailsRequest = false;
            internal.listRequest = true;
        }
    }
}
