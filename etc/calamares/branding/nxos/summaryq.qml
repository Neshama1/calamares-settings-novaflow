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
    
    title: config.title
    subtitle: config.message
    
    Kirigami.Theme.textColor: "white"
    
     stackView.initialItem:  ListViewTemplate
        {
            width: parent.width            
            model: config.summaryModel            
           
            delegate: Maui.ItemDelegate
				{
					id: _delegate

					property bool isCurrentItem : ListView.isCurrentItem

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
                        isCurrentItem: parent.isCurrentItem
                        iconSource: "help-info"
                        label1.text: model.title
                        label2.text: model.message
					}
                    
                }        

    }
    
}
