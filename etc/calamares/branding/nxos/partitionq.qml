import io.calamares.ui 1.0

import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import QtGraphicalEffects 1.0
import QtQuick.Window 2.3
import org.kde.mauikit 1.0 as Maui
import "."

ResponsiveBase
{
    id: control
    
    
    title: "Install"
    subtitle: qsTr("Pick where to install the OS or choose a manual partition")
    message: config.prettyStatus
    
    Kirigami.Theme.textColor: "white"
    
    stackView.initialItem: Item
    {
        ColumnLayout
        {
            height: parent.height
            width: Math.min(parent.width, 500)   
            anchors.centerIn: parent
            
            ItemDelegate
            {   
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                
                background: Rectangle
                {                 
                    color: Kirigami.Theme.backgroundColor
                    radius: 5
                    opacity: 0.3     
                }
                
                Maui.ListBrowser
                {
                    id: _listView
                    orientation: ListView.Horizontal
                    anchors.centerIn: parent
                    height: parent.height
                    width: Math.min(contentWidth, parent.width)
                    model: config.devices
                    currentIndex: model.currentIndex
                    
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
                            checked: index === _listView.model.currentIndex
                            
                        }  
                        
                        onClicked: _listView.model.currentIndex = index
                        
                    }            
                    background: Item {}
                }
            }
            
            ItemDelegate
            {
                property var opt : config.eraseOption
                Layout.fillWidth: true
                Layout.preferredHeight: 64
                visible: config.eraseOption.visible
                enabled: config.eraseOption.enabled
                onClicked:
                {
//                     config.installChoice = 2
                    config.eraseOption.checked = !config.eraseOption.checked 
                }
                
                background: Rectangle
                {
                    color: Kirigami.Theme.backgroundColor
                    radius: 5
                    opacity: 0.3     
                }
                
                Maui.ListItemTemplate
                {                    
                    anchors.fill: parent
                    iconSource: "drive-harddisk"
                    iconSizeHint: 32
                    checkable: false
                    checked: config.eraseOption.checked

                    label1.text: config.eraseOption.label
                    label2.text: config.eraseOption.message
                    label2.wrapMode: Text.WrapAnyWhere
                }
            }
            
            ItemDelegate
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 64
                visible: config.alongsideOption.visible
                enabled: config.alongsideOption.enabled
                
                onClicked:
                {
//                     config.installChoice = 2
                    config.alongsideOption.checked = true
                }
                
                background: Rectangle
                {
                    color: Kirigami.Theme.backgroundColor
                    radius: 5
                    opacity: 0.3     
                }
                
                Maui.ListItemTemplate
                {                    
                    anchors.fill: parent
                    iconSource: "drive-harddisk"
                    iconSizeHint: 32
                    checkable: false
                    checked: config.alongsideOption.checked
                    
                    label1.text: config.alongsideOption.label
                    label2.text: config.alongsideOption.message
                    label2.wrapMode: Text.WrapAnyWhere
                }
            }
            
            ItemDelegate
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 64
                visible: config.replaceOption.visible
                enabled: config.replaceOption.enabled
                
                onClicked:
                {
                    config.replaceOption.checked = true
                }

onToggled:  config.replaceOption.checked 
                
                background: Rectangle
                {
                    color: Kirigami.Theme.backgroundColor
                    radius: 5
                    opacity: 0.3     
                }
                
                Maui.ListItemTemplate
                {                    
                    anchors.fill: parent
                    iconSource: "drive-harddisk"
                    iconSizeHint: 32
                    checkable: false
                    checked: config.replaceOption.checked
                    
                    label1.text: config.replaceOption.label
                    label2.text: config.replaceOption.message
                    label2.wrapMode: Text.WrapAnyWhere
                }
            }
            
            ItemDelegate
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 64
                visible: config.somethingElseOption.visible
                enabled: config.somethingElseOption.enabled
                
                onClicked:
                {
                    config.somethingElseOption.checked = true
                }
                
                background: Rectangle
                {
                    color: Kirigami.Theme.backgroundColor
                    radius: 5
                    opacity: 0.3     
                }
                
                Maui.ListItemTemplate
                {                    
                    anchors.fill: parent
                    iconSource: "drive-harddisk"
                    iconSizeHint: 32
                    checkable: false
                    checked: config.somethingElseOption.checked
                    
                    label1.text: config.somethingElseOption.label
                    label2.text: config.somethingElseOption.message
                    label2.wrapMode: Text.WrapAnyWhere
                }
            }
            
            Item
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                
                ComboBox
                {
                    width: parent.width
                    model: config.bootloaders
                    textRole: "display"
                }
                
            }
            
            CheckBox
            {
                Layout.fillWidth: true                    
                enabled: config.reuseHomeOption.enabled
                visible: config.reuseHomeOption.visible
                checked: config.reuseHomeOption.checked
                text: config.reuseHomeOption.label
            }   
            
            ColumnLayout
            {
                Layout.fillWidth: true              
                enabled: config.encryptOption.enabled
                visible: config.encryptOption.visible
                               
                
                CheckBox
                {
                    Layout.fillWidth: true
                    checked: config.encryptOption.checked
                    text: config.encryptOption.label
                    onToggled: config.encryptOption.checked = checked
                }
                
                TextField
                {
                    visible: config.encryptOption.checked
                    Layout.fillWidth: true
                    placeholderText: qsTr("Passphrase")
                    onTextChanged: config.encryptOption.passphrase = text
                }
                
                TextField
                {
                    visible: config.encryptOption.checked                    
                    Layout.fillWidth: true
                    placeholderText: qsTr("Confirm Passphrase")
                    onTextChanged: config.encryptOption.confirmPassphrase = text
                } 
            }
            
            ColumnLayout
            {
                
                Layout.fillWidth: true
                
                Label
                {
                    Layout.fillWidth: true
                    text: qsTr("Before")
                }
                
                Rectangle
                {
                    id: _previewRec1
                    Layout.fillWidth: true
                    Layout.preferredHeight: 64
                    radius: 6
                    color: "orange"
                    border.color: "red"
                    
                    SplitView
                    {
                        anchors.fill: parent
                        Repeater
                        {
                            model: 3
                            
                            Rectangle
                            {
                                SplitView.preferredWidth: 100
                                SplitView.preferredHeight: parent.height
                                SplitView.minimumWidth: 0
                                color: "yellow"
                                opacity: 0.5
                                
                                Label
                                {
                                    anchors.centerIn: parent
                                    text: parent.width
                                }
                            }
                        }
                    }
                    
                    layer.enabled: true
                    layer.effect: OpacityMask
                    {
                        maskSource: Item
                        {
                            width: _previewRec1.width
                            height: _previewRec1.height
                            
                            Rectangle
                            {
                                anchors.fill: parent
                                radius: _previewRec1.radius
                            }
                        }
                    }  
                    
                }
                
                Label
                {
                    Layout.fillWidth: true
                    text: qsTr("After")
                }
                
                Rectangle
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 64
                    radius: 6
                    color: "orange"
                    border.color: "red"
                }
                
            }
        }        
    }    
}
