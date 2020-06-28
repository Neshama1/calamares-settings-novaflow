import io.calamares.ui 1.0

import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import QtGraphicalEffects 1.0
import QtQuick.Window 2.3
import "."

ResponsiveBase
{
    id: control
    
    // 	nextButton.enabled:  config.isNextEnabled
    
    title: qsTr("Finished")
    subtitle: qsTr("Installation process has finished")
    message: config.message
    
    Kirigami.Theme.textColor: "white"
    
    Item
    {
        Layout.fillHeight: true
        Layout.fillWidth: true
        
        
        CheckBox
        {
            id: _checkBox
            anchors.centerIn: parent
            checked: config.restartOption.checked
            onCheckedChanged: config.restartOption.checked = checked
            
            visible: config.restartOption.visible
            text: config.restartOption.label
            enabled: config.restartOption.enabled
        }
    }
    
}
