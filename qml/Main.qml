/*
 * Copyright (C) 2023  Sander Klootwijk
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * contenthubtest is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Content 1.1
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Example 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'contenthubtest.sanderklootwijk'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    ContentStore {
        id: contentStore
        scope: ContentScope.App
    }

    PageStack {
        id: pageStack

        anchors.fill: parent

        Component.onCompleted: push(mainPage)
    }

    Page {
        id: mainPage

        visible: false

        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('ContentHubTest')
        }

        Image {
            id: contentImage

            anchors {
                fill: parent
                topMargin: header.height
                bottomMargin: importButton.height
            }
        }

        Button {
            id: importButton

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            text: "Import single item"
            onClicked: {
                var pickerPage = pageStack.push(Qt.resolvedUrl("PickerPage.qml"))

                pickerPage.imported.connect(function(fileUrl) {
                    // Resource optimizations for low-end devices
                    pageStack.pop()

                    console.log("File" << fileUrl << "has been imported!")
                    contentImage.source = fileUrl
                })
            }
        }
    }
}
