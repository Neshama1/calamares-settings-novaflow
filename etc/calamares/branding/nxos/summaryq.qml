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
    
}