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
    message: stackView.currentItem.message
    
    stackView.initialItem: ListViewTemplate
    {
        id: _regionListView
        
        
        property string title: qsTr("Region")
        property string subtitle: qsTr("Pick your preferred region or use the default one based on your current location")
        property string message:  qsTr("Select your preferred zone within your location to continue with the installation")
        
        
        currentIndex: model.currentIndex
        model: config.regionModel
        
        delegate: ListItemDelegate
        {
            id: _delegate
            label1.text: model.label
            onClicked:
            {
                _regionListView.model.currentIndex = index
                control.stackView.push(_zonesListComponent)
            }
        }
        
        Button
        {
            Layout.fillWidth: true
            text: qsTr("Timezones")
            icon.name: "go-previous"
            onClicked: control.stackView.push(_zonesListComponent)
        }
    }    
    
    Component
    {
        id: _zonesListComponent
        
        ListViewTemplate
        {
            id: _zonesListView
            property string title: qsTr("Timezone")
            property string subtitle: config.prettyStatus
            property string message: ""
            
            currentIndex: model.currentIndex
            model: config.zonesModel
            
            delegate: ListItemDelegate
            {
                id: _delegate
                label1.text: model.label
                onClicked:
                {
                    _zonesListView.model.currentIndex = index
                    positionViewAtIndex(index, ListView.Center)
                }
            }
            Button
            {
                Layout.fillWidth: true
                icon.name: "go-previous"
                text: qsTr("Regions")
                onClicked: control.stackView.pop()
            }            
        }        
    }
}

