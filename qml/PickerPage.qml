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

Page {
    id: picker

    property ContentTransfer activeTransfer

    signal cancel()
    signal imported(var fileUrl)

    header: PageHeader {
        title: i18n.tr("Choose from")
    }

    ContentPeerPicker {
        anchors { fill: parent; topMargin: picker.header.height }
        visible: parent.visible
        showTitle: false
        contentType: ContentType.Pictures
        handler: ContentHandler.Source

        onPeerSelected: {
            peer.selectionType = ContentTransfer.Single;
            activeTransfer = peer.request(contentStore);
            activeTransfer.stateChanged.connect(function() {
                if (activeTransfer && activeTransfer.state === ContentTransfer.Charged) {
                    picker.imported(activeTransfer.items[0].url);
                    activeTransfer = null;
                }
            });
        }

        onCancelPressed: {
            pageStack.pop();
        }
    }

    ContentTransferHint {
        id: transferHint
        activeTransfer: picker.activeTransfer
    }
}

