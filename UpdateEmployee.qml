import QtQuick 2.15
import QtQuick.Controls 2.15

AddEmployee {
    id: root

    width: 500
    height: 300

    title: "Update Employee"

    firstNameField.lastText: root.employee.firstName
    lastNameField.lastText: root.employee.lastName
    emailField.lastText: root.employee.emailAddress

    property var employee: {
        "index": "", "firstName": "", "lastName": "", "emailAddress": ""
    }

}
