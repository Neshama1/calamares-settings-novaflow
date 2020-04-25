import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import QtGraphicalEffects 1.0
import QtQuick.Window 2.3
import org.kde.mauikit 1.0 as Maui
import "."

ResponsiveBase
{
    id: control
    
    
    title: config.prettyStatus
    subtitle: qsTr("Pick where to install the OS or choose a manual partition")
    message: config.devices.count
    
    Kirigami.Theme.textColor: "white"
    
    stackView.initialItem: Item
    {
        Page
    {   
        height: parent.height
        width: Math.min(parent.width, 500)
        background: Item {}
        anchors.centerIn: parent
        
         Rectangle
                {
                    anchors.centerIn: _listView
                    width: parent.width
                    height: _listView.height
                    color: Kirigami.Theme.backgroundColor
                    radius: 5
                    opacity: 0.3     
                }
        
            Maui.ListBrowser
            {
                id: _listView
                orientation: ListView.Horizontal
                anchors.centerIn: parent
                height: 150
                width: Math.min(contentWidth, parent.width)
                model: config.devices
                
                delegate: Maui.ItemDelegate
                {
                    id: _delegate
                    height: 120
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter
                    isCurrentItem: ListView.isCurrentItem
                    
                    Maui.GridItemTemplate
                    {
                        anchors.fill: parent
                        iconSizeHint: 64
                        iconSource: "drive-harddisk"
                        label1.text: model.name
//                         checkable: true
                        checked: index === _listView.currentIndex
                       
                    }  
                    
                    onClicked: _listView.currentIndex = index

                }            
                background: Item {}
            }
            
            
            
            //         ComboBox
            //         {
            //             Layout.fillWidth: true
            //             
            //         }
            //     
            
            footer: RowLayout
            {
                width: parent.width
                height: 64
                
                
                ItemDelegate
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 64
                    onClicked:
                    {
                      config.installChoice = 2
                        _manualOption.checked = false
                        _eraseDiskOption.checked = true
                    }
                    background: Rectangle
                        {
                            color: Kirigami.Theme.backgroundColor
                            radius: 5
                            opacity: 0.3     
                        }
                        
                    Maui.ListItemTemplate
                    {
                        id: _eraseDiskOption

                        anchors.fill: parent
                        iconSource: "drive-harddisk"
                        iconSizeHint: 32
                        checkable: false
                        

                        label1.text: qsTr("Erase disk")
                        label2.text: qsTr("This will delete all data currently present on the selected storage device.")
                        label2.wrapMode: Text.WrapAnyWhere
                    }
                }
                
                ItemDelegate
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 64
                    onClicked:
                    {
                        config.installChoice = 4
                        _manualOption.checked = true
                        _eraseDiskOption.checked = false
                    }
                   background: Rectangle
                        {
                            color: Kirigami.Theme.backgroundColor
                            radius: 5
                            opacity: 0.3     
                        }
                        
                    Maui.ListItemTemplate
                    {
                        id: _manualOption
                        anchors.fill: parent

                        iconSource: "drive-harddisk"

                        checkable: false
                        iconSizeHint: 32
                        
                        label1.text: qsTr("Manual partitioning")
                        label2.text: qsTr("You can create or resize partitions yourself.")
                        label2.wrapMode: Text.WrapAnyWhere

                    }
                }
            }
        }
        
    }
    
}
