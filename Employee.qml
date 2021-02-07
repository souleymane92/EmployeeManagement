import QtQuick 2.0
import QtQuick.Controls 2.15


Rectangle {
    id: root

    width: 500
    height: root.cellHeight
    color: (root.myIndex % 2)? "lightgrey" : "white"

    property real cellWidth: 80
    property real cellHeight: 40
    property real btnHeight: 25
    property real btnWidth: 60

    property int myIndex
    property string firstName
    property string lastName
    property string emailAddress

    signal deleteRequest(int index)
    signal updateRequest(var employee)
    signal detailsRequest(var employee)


    Row {
        spacing: 10

        anchors {
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }

        /*!
            FirstName column
        */
        Rectangle {
            width: root.cellWidth
            height: root.cellHeight
            color: root.color
            Text {
                text: qsTr(root.firstName)
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        /*!
            LastName column
        */
        Rectangle {
            width: root.cellWidth
            height: root.cellHeight
            color: root.color
            Text {
                text: qsTr(root.lastName)
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        /*!
            Email Address column
        */
        Rectangle {
            width: 2*root.cellWidth
            height: root.cellHeight
            color: root.color
            Text {
                text: qsTr(root.emailAddress)
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        /*!
            Delete button column
        */
        RoundButton {
            text: "Delete"
            palette.button: "red"
            width: root.btnWidth
            height: root.btnHeight
            radius: 4
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                root.deleteRequest(root.myIndex)
            }
        }

        /*!
            Update button column
        */
        RoundButton {
            text: "Update"
            palette.button: "steelblue"
            width: root.btnWidth
            height: root.btnHeight
            radius: 4
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                 root.updateRequest({   "index": root.myIndex,
                                        "firstName": root.firstName,
                                        "lastName": root.lastName,
                                        "emailAddress": root.emailAddress,
                                       })
            }
        }

        /*!
            Details button column
        */
        RoundButton {
            text: "Details"
            palette.button: "steelblue"
            width: root.btnWidth
            height: root.btnHeight
            radius: 4
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                root.detailsRequest({   "index": root.myIndex,
                                        "firstName": root.firstName,
                                        "lastName": root.lastName,
                                        "emailAddress": root.emailAddress,
                                       });
            }
        }
    }
}

