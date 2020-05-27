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
    
     stackView.initialItem: Item
    {
        ListView
        {
            height: parent.height
            width: Math.min(parent.width, 500)   
            anchors.centerIn: parent
            
            model: config.summaryModel            
           
            delegate: ItemDelegate
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

					contentItem: RowLayout
					{
						width: parent.width
						height: parent.height

						Item
						{
							Layout.fillHeight: true
							Layout.preferredWidth: height

							Kirigami.Icon
							{
								source: "help-info"
								height:  32
								width: height
								anchors.centerIn: parent
								color: background.color
							}
						}

						ColumnLayout
						{
							Layout.fillWidth: true
							Layout.fillHeight: true

							spacing: 0

							Label
							{
								Layout.fillWidth: true
								Layout.fillHeight: true
								horizontalAlignment: Qt.AlignLeft
								text: model.title
							}

							Label
							{
								Layout.fillWidth: true
								Layout.fillHeight: true
								horizontalAlignment: Qt.AlignLeft
								text: model.message
								opacity: isCurrentItem ? 1 : 0.7
								font.weight: Font.Light
							}
						}
					}
				}

        }
        

    }
    
}
