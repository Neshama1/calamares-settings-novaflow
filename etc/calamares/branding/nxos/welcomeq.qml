import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import org.kde.mauikit 1.0 as Maui

import QtGraphicalEffects 1.0
import "."

ResponsiveBase
{
    id: control
    
    title: stackView.currentItem.title
    subtitle: stackView.currentItem.subtitle
    message: stackView.currentItem.message
    
    header: Item
    {
        width: parent.width
        height: 150
        
        Image
        {
            anchors.centerIn: parent
            source: Branding.imagePath(Branding.ProductWelcome)
            height: Math.min(100, parent.height)
            width: height
            sourceSize.width: width
            sourceSize.height: height
        }
    }
    
    stackView.initialItem:   ListViewTemplate
    {
        id: _requirementsList
        property string title: qsTr("Welcome to ") + Branding.string(Branding.ProductName) + " " + Branding.string(Branding.Version)
        property string subtitle: config.genericWelcomeMessage
        property string message: config.requirementsModel.satisfiedRequirements ? "All requierements have been satisfied" :  qsTr("<p>This computer does not satisfy some of the recommended requirements for setting up %1.<br/>
        Setup can continue, but some features might be disabled.</p>").arg(Branding.string(Branding.VersionedName))
        
        model: config.requirementsModel
        
        delegate: Maui.ItemDelegate
        {
            id: _delegate
            
            isCurrentItem : ListView.isCurrentItem
            
            background: Rectangle
            {
                color: model.satisfied ? Kirigami.Theme.positiveTextColor : Kirigami.Theme.negativeTextColor
                opacity: 0.2
            }
            
            width: parent.width
            height: 48
            
            Maui.ListItemTemplate
            {
                anchors.fill: parent
                iconSource: model.satisfied ? "checkmark" : (model.mandatory ? "error" : "dialog-warning-symbolic")
                iconSizeHint: Maui.Style.iconSizes.big
                label1.text: model.name
                label2.text: !model.satisfied ?  model.negatedText : model.details
            }
        }
        
        RowLayout
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            
            spacing: Kirigami.Units.largeSpacing* 2
            
            Button
            {
                Layout.fillWidth: true
                text: "About"
                icon.name: "documentinfo"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"
                
                visible: Branding.string(Branding.ProductUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.ProductUrl))
            }
            
            Button
            {
                Layout.fillWidth: true
                text: qsTr("Support")
                icon.name: "help-contents"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"
                visible: Branding.string(Branding.SupportUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.SupportUrl))
            }
            
            Button
            {
                Layout.fillWidth: true
                text: qsTr("Known issues")
                icon.name: "tools-report-bug"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"
                visible: Branding.string(Branding.KnownIssuesUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.KnownIssuesUrl))
            }
            
            Button
            {
                Layout.fillWidth: true
                text: qsTr("Release notes")
                icon.name: "answer"
                Kirigami.Theme.backgroundColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.4)
                Kirigami.Theme.textColor: "#fff"
                visible: Branding.string(Branding.ReleaseNotesUrl).length
                onClicked: Qt.openUrlExternally(Branding.string(Branding.ReleaseNotesUrl))
            }
        }
        Button
        {
            Layout.fillWidth: true
            text: qsTr("Language")
            icon.name: "go-previous"
            onClicked: control.stackView.push(_langComponent)
            enabled: true
        }
    }
    
    
    Component
    {	
        id: _langComponent
        ListViewTemplate
        {
            id: _langList
            
            property string title : qsTr("Language")
            property string subtitle:  qsTr("Select your preferred language to continue with the installation")
            
            currentIndex: config.localeIndex                
            model: config.languagesModel                
            delegate: ListItemDelegate
            {
                id: _delegate
                label1.text: model.label
                label2.text: model.englishLabel
                
                onClicked: config.localeIndex = index
            }
            
            Button
            {
                Layout.fillWidth: true
                text: qsTr("Welcome")
                icon.name: "go-previous"
                onClicked: control.stackView.pop()
            }
        }        
    }    
}
