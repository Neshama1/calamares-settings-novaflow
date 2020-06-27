import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import QtGraphicalEffects 1.0
import "."

ResponsiveBase
{
    id: control

    title: stackView.currentItem.title
    subtitle: stackView.currentItem.subtitle
    message: config.prettyStatus

    stackView.initialItem:   GridView
        {
            property string title: qsTr("Theme")
            property string subtitle: qsTr("Pick your preferred theme or use the default one")
            
            id:_gridView
            width: parent.width
            implicitHeight: contentHeight
            model: config.themesModel
            cellWidth: width * 0.5
            cellHeight: cellWidth

            Rectangle
            {
                z: parent.z - 1
                anchors.fill: parent
                color: Kirigami.Theme.backgroundColor
                radius: 5
                opacity: 0
            }

            delegate: ItemDelegate
            {
                id: _delegate
                property bool isCurrentItem: GridView.isCurrentItem

                width: _gridView.cellWidth
                height: _gridView.cellHeight

                background: Rectangle
                {
                    color: "transparent"
                }

                onClicked: _gridView.model.currentIndex = index

                contentItem: ColumnLayout
                {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing

                    Item
                    {
                        id: _previewContent
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Kirigami.Icon
                        {
                            id: _preview

                            anchors.fill: parent
                            source: model.image
//                             sourceSize.height: height
//                             sourceSize.width: width
                            smooth: true
//                             fillMode: Image.PreserveAspectCrop
                            color: isCurrentItem || hovered ? Kirigami.Theme.highlightColor : Kirigami.Theme.backgroundColor
                            isMask: true

                            layer.enabled: true
                            layer.effect: OpacityMask
                            {
                                maskSource: Item
                                {
                                    width: _preview.width
                                    height: _preview.height

                                    Rectangle
                                    {
                                        anchors.centerIn: parent
                                        width: _preview.width
                                        height: _preview.height
                                        radius: _delegate.background.radius
                                    }
                                }
                            }

                        }


//                         CheckBox
//                         {
//                             height: 32
//                             width: 32
//                             z:  parent.z + 1
//                             anchors.bottom: parent.bottom
//                             anchors.horizontalCenter: parent.horizontalCenter
//                             anchors.margins: Kirigami.Units.largeSpacing
//                             checked: isCurrentItem
// //                             ckeckable: false
//                         }
                    }

                    DropShadow
                    {
                        anchors.fill: _previewContent
                        horizontalOffset: 0
                        verticalOffset: 0
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: _previewContent
                    }


                    Label
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Math.min(parent.height * 0.2, implicitHeight)
                         color:"white"
                         font.bold: true
                         wrapMode: Text.Wrap
                         font.pointSize: 12
                         horizontalAlignment: Qt.AlignHCenter
                        text: model.name
                    }
                }
            }
        
    }
}
