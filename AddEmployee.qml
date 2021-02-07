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

    property string title: "Create Employee"
    property alias firstNameField: firstName
    property alias lastNameField: lastName
    property alias emailField: emailAddress

    QtObject {
        id: internal
        readonly property var emailPatern: /^[a-z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$/
        readonly property var namePatern: /^[a-zA-Zéèï\- ]+$/
    }

    signal submitted(var employee)
    signal updateCancelled()

    /*!
        Validate input data
    */
    function validateInputData() {
        if (!Boolean(firstName.input.text)
                || firstName.input.text.length < 2)
            return false;

        if (!Boolean(lastName.input.text)
                || lastName.input.text.length < 2)
            return false;

        if (!Boolean(emailAddress.input.text)
                || !internal.emailPatern.test(emailAddress.input.text))
            return false;

        return true;
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 30
        spacing: 20

        // Page Title
        Text {
            topPadding: 15
            text: qsTr(root.title)
            font {
                family: "Arial"
                pixelSize: 16
            }
        }

        // TextFields
        MyTextField {
            id: firstName
            label: "First Name"
            validPatern: internal.namePatern
        }

        MyTextField {
            id: lastName
            label: "Last Name"
            validPatern: internal.namePatern
        }

        MyTextField {
            id: emailAddress
            label: "Email Address"
            validPatern: internal.emailPatern
        }
    }

    /*!
        Submitting button
    */
    RoundButton {
        id: submitBtn
        width: 60; height: 30; radius: 4
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            left: parent.left
            leftMargin: 15
        }

        text: "Submit"
        palette.button: "green"

        enabled: root.validateInputData()

        onClicked: {
            let employee = {
                "firstName": firstName.input.text,
                "lastName": lastName.input.text,
                "emailAddress": emailAddress.input.text
            }
            root.submitted(employee)
            firstName.input.clear();
            lastName.input.clear();
            emailAddress.input.clear();
        }
    }

    /*!
        Cancelling button
    */
    RoundButton {
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
            left: submitBtn.right
            leftMargin: 30
        }

        text: "Cancel"
        palette.button: "#4169e1"
        width: 60; height: 30; radius: 4

        onClicked: {
            updateCancelled();
        }
    }
}
