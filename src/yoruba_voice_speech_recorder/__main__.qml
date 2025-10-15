import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia

ApplicationWindow {
    id: root
    visible: true
    width: 1600; height: 1000
    title: qsTr("Yorùbá Voice Recorder")
    
    property bool recording: false
    property string promptsName: ''
    property string scriptText: ''
    property string scriptFilename: ''
    property string saveDir: '.'
    property string currentTheme: "light"
    
    // Modern theme colors
    property color primaryColor: currentTheme === "dark" ? "#1a1a1a" : "#f8f9fa"
    property color secondaryColor: currentTheme === "dark" ? "#2d2d2d" : "#ffffff"
    property color cardColor: currentTheme === "dark" ? "#3a3a3a" : "#ffffff"
    property color textColor: currentTheme === "dark" ? "#ffffff" : "#2c3e50"
    property color textSecondaryColor: currentTheme === "dark" ? "#b0b0b0" : "#6c757d"
    property color accentColor: currentTheme === "dark" ? "#4a9eff" : "#007bff"
    property color successColor: currentTheme === "dark" ? "#28a745" : "#28a745"
    property color dangerColor: currentTheme === "dark" ? "#dc3545" : "#dc3545"
    property color warningColor: currentTheme === "dark" ? "#ffc107" : "#ffc107"
    property color borderColor: currentTheme === "dark" ? "#4a4a4a" : "#e9ecef"
    property color shadowColor: currentTheme === "dark" ? "#000000" : "#000000"
    
    // Active item colors with proper contrast
    property color activeItemBackground: currentTheme === "dark" ? "#1e3a8a" : "#dbeafe"
    property color activeItemText: currentTheme === "dark" ? "#ffffff" : "#1e40af"
    property color activeItemBorder: currentTheme === "dark" ? "#3b82f6" : "#2563eb"
    
    color: primaryColor
    
    // Modern shadow component (simplified)
    component ModernShadow: Rectangle {
        color: "transparent"
        border.color: shadowColor
        border.width: 1
        opacity: 0.1
    }
    
    // Modern card component
    component ModernCard: Rectangle {
        color: cardColor
        border.color: borderColor
        border.width: 1
        radius: 12
    }
    
    // Modern button component
    component ModernButton: Button {
        property color buttonColor: accentColor
        property color hoverColor: Qt.lighter(buttonColor, 1.1)
        property color pressColor: Qt.darker(buttonColor, 1.2)
        property bool isDanger: false
        property bool isSuccess: false
        
        background: Rectangle {
            color: {
                if (isDanger) return dangerColor
                if (isSuccess) return successColor
                return parent.pressed ? pressColor : (parent.hovered ? hoverColor : buttonColor)
            }
            radius: 8
            border.color: Qt.lighter(parent.background.color, 1.2)
            border.width: 1
        }
        
        contentItem: Text {
            text: parent.text
            color: "white"
            font.pixelSize: 14
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
    }
    
    // Settings dialog with modern design
    Dialog {
        id: settingsDialog
        title: "Settings"
        width: 600
        height: 500
        anchors.centerIn: parent
        modal: true
        
        background: ModernCard {
            anchors.fill: parent
        }
        
        header: Rectangle {
            height: 60
            color: "transparent"
            
            Text {
                text: "Settings"
                font.pixelSize: 24
                font.weight: Font.Bold
                color: textColor
                anchors.centerIn: parent
            }
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 25
            
            // Theme selection with modern design
            ModernCard {
                Layout.fillWidth: true
                height: 80
                color: "transparent"
                border.width: 0
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20
                    
                    Text {
                        text: "Theme"
                        color: textColor
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        Layout.preferredWidth: 120
                    }
                    
                    ComboBox {
                        id: themeCombo
                        model: ["light", "dark"]
                        currentIndex: currentTheme === "dark" ? 1 : 0
                        onCurrentTextChanged: {
                            currentTheme = currentText
                            recorder.setTheme(currentText)
                        }
                    }
                }
            }
            
            // Save directory with modern design
            ModernCard {
                Layout.fillWidth: true
                height: 80
                color: "transparent"
                border.width: 0
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20
                    
                    Text {
                        text: "Save Directory"
                        color: textColor
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        Layout.preferredWidth: 120
                    }
                    
                    Text {
                        id: saveDirText
                        text: recorder.getSaveDirectory()
                        color: textSecondaryColor
                        font.pixelSize: 14
                        Layout.fillWidth: true
                        elide: Text.ElideMiddle
                    }
                    
                    ModernButton {
                        text: "Browse"
                        onClicked: recorder.selectSaveDirectory()
                        Layout.preferredWidth: 100
                    }
                }
            }
            
            // Speaker name with modern design
            ModernCard {
                Layout.fillWidth: true
                height: 80
                color: "transparent"
                border.width: 0
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20
                    
                    Text {
                        text: "Speaker Name"
                        color: textColor
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        Layout.preferredWidth: 120
                    }
                    
                    Text {
                        id: speakerNameText
                        text: recorder.getSpeakerName()
                        color: textSecondaryColor
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }
                    
                    ModernButton {
                        text: "Set"
                        onClicked: recorder.setSpeakerName()
                        Layout.preferredWidth: 100
                    }
                }
            }
            
            // Prompts count with modern design
            ModernCard {
                Layout.fillWidth: true
                height: 80
                color: "transparent"
                border.width: 0
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20
                    
                    Text {
                        text: "Prompts Count"
                        color: textColor
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        Layout.preferredWidth: 120
                    }
                    
                    Text {
                        text: recorder.getPromptsCount()
                        color: textSecondaryColor
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }
                    
                    ModernButton {
                        text: "Set"
                        onClicked: recorder.setPromptsCount()
                        Layout.preferredWidth: 100
                    }
                }
            }
            
            // Close button
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                ModernButton {
                    text: "Close"
                    onClicked: settingsDialog.close()
                    Layout.preferredWidth: 120
                }
            }
        }
    }
    
    // Quit confirmation dialog with modern design
    Dialog {
        id: quitDialog
        title: "Quit Application"
        width: 400
        height: 200
        anchors.centerIn: parent
        modal: true
        
        background: ModernCard {
            anchors.fill: parent
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 25
            
            Text {
                text: "Are you sure you want to quit?"
                color: textColor
                font.pixelSize: 18
                font.weight: Font.Medium
                Layout.alignment: Qt.AlignHCenter
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                
                ModernButton {
                    text: "Yes, Quit"
                    isDanger: true
                    onClicked: {
                        quitDialog.close()
                        recorder.requestQuit()
                    }
                    Layout.preferredWidth: 120
                }
                
                ModernButton {
                    text: "Cancel"
                    onClicked: quitDialog.close()
                    Layout.preferredWidth: 120
                }
            }
        }
    }

    Component.onCompleted: {
        initTimer.start()
        // Load initial text after a short delay
        loadInitialText.start()
    }
    
    Timer {
        id: initTimer
        interval: 0
        onTriggered: recorder.init(scriptModel)
    }
    
    Timer {
        id: loadInitialText
        interval: 100
        onTriggered: {
            if (scriptModel.count > 0 && scriptListView.currentIndex >= 0) {
                scriptText.text = scriptModel.get(scriptListView.currentIndex).script || ""
            }
        }
    }

    onRecordingChanged: recorder.toggleRecording(recording)
    onScriptFilenameChanged: scriptModel.get(scriptListView.currentIndex).filename = scriptFilename

    // called by python code on init for each listview item: self.window.appendScript({'script': script, 'filename': ''})
    function appendScript(data) {
        scriptModel.append(data)
    }

    function gotoNextScript() {
        if (scriptListView.currentIndex < scriptModel.count - 1) {
            scriptListView.incrementCurrentIndex();
            scriptListView.positionViewAtIndex(scriptListView.currentIndex, ListView.Center);
        }
    }
    
    function gotoPreviousScript() {
        if (scriptListView.currentIndex > 0) {
            scriptListView.decrementCurrentIndex();
            scriptListView.positionViewAtIndex(scriptListView.currentIndex, ListView.Center);
        }
    }
    
    function deleteCurrentScript() {
        if (scriptModel.count > 0) {
            scriptModel.remove(scriptListView.currentIndex);
            if (scriptListView.currentIndex >= scriptModel.count) {
                scriptListView.currentIndex = scriptModel.count - 1;
            }
        }
    }
    
    function showQuitDialog() {
        quitDialog.open()
    }

    ListModel {
        id: scriptModel
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Modern header with title and controls
        ModernCard {
            Layout.fillWidth: true
            height: 80
            color: "transparent"
            border.width: 0
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 25
                spacing: 20
                
                Text {
                    text: "Yorùbá Voice Recorder"
                    font.pixelSize: 28
                    font.weight: Font.Bold
                    color: textColor
                    Layout.fillWidth: true
                }
                
                // Settings button
                ModernButton {
                    text: "⚙️ Settings"
                    onClicked: settingsDialog.open()
                    Layout.preferredWidth: 120
                }
                
                // Quit button
                ModernButton {
                    text: "❌ Quit"
                    isDanger: true
                    onClicked: showQuitDialog()
                    Layout.preferredWidth: 100
                }
            }
        }

        // Modern status bar
        ModernCard {
            Layout.fillWidth: true
            height: 60
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 20
                
                RowLayout {
                    spacing: 8
                    Text {
                        text: "👤"
                        font.pixelSize: 14
                    }
                    Text {
                        id: statusSpeakerText
                        text: "Speaker: " + recorder.getSpeakerName()
                        color: textColor
                        font.pixelSize: 14
                        font.weight: Font.Medium
                    }
                }
                
                Rectangle {
                    width: 1
                    height: 20
                    color: borderColor
                }
                
                RowLayout {
                    spacing: 8
                    Text {
                        text: "📁"
                        font.pixelSize: 14
                    }
                    Text {
                        id: statusSaveDirText
                        text: "Save to: " + recorder.getSaveDirectory()
                        color: textSecondaryColor
                        font.pixelSize: 12
                        Layout.fillWidth: true
                        elide: Text.ElideMiddle
                    }
                }
                
                Rectangle {
                    width: 1
                    height: 20
                    color: borderColor
                }
                
                RowLayout {
                    spacing: 8
                    Text {
                        text: "🎨"
                        font.pixelSize: 12
                    }
                    Text {
                        text: "Theme: " + currentTheme
                        color: textSecondaryColor
                        font.pixelSize: 14
                    }
                }
            }
        }

        // Main content area with modern design
        ModernCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 25
                spacing: 25

                // Script list - MAXIMIZED (shows all prompts)
                ModernCard {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 500
                    
                    ListView {
                        id: scriptListView
                        anchors.fill: parent
                        anchors.margins: 15
                        model: scriptModel
                        spacing: 4
                        clip: true
                        
                        onCurrentIndexChanged: {
                            // Scroll to current item
                            if (currentIndex >= 0) {
                                positionViewAtIndex(currentIndex, ListView.Center);
                            }
                        }
                        
                        delegate: ModernCard {
                            width: scriptListView.width
                            height: 60
                            // PROPER ACTIVE ITEM HIGHLIGHTING WITH CONTRAST
                            color: index === scriptListView.currentIndex ? activeItemBackground : secondaryColor
                            border.color: index === scriptListView.currentIndex ? activeItemBorder : borderColor
                            border.width: index === scriptListView.currentIndex ? 3 : 1
                            radius: 6
                            
                            // Add glow effect for active item
                            Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                                border.color: index === scriptListView.currentIndex ? Qt.lighter(activeItemBorder, 1.3) : "transparent"
                                border.width: 2
                                radius: 8
                                visible: index === scriptListView.currentIndex
                                opacity: 0.8
                            }
                            
                            Text {
                                anchors.fill: parent
                                anchors.margins: 10
                                text: script
                                color: index === scriptListView.currentIndex ? activeItemText : textColor
                                font.pixelSize: 14
                                font.weight: index === scriptListView.currentIndex ? Font.Bold : Font.Normal
                                wrapMode: Text.WordWrap
                                verticalAlignment: Text.AlignVCenter
                                lineHeight: 1.2
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: scriptListView.currentIndex = index
                                hoverEnabled: true
                                onEntered: if (index !== scriptListView.currentIndex) parent.color = Qt.lighter(parent.color, 1.05)
                                onExited: if (index !== scriptListView.currentIndex) parent.color = secondaryColor
                            }
                        }
                    }
                }

                // Control buttons - BELOW TEXT
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20
                    Layout.preferredHeight: 80
                    
                    ModernButton {
                        id: recordButton
                        text: recording ? "⏹️ Stop Recording" : "🎤 Start Recording"
                        onClicked: recording = !recording
                        isSuccess: recording
                        Layout.preferredWidth: 180
                        Layout.preferredHeight: 40
                        
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 18
                            font.weight: Font.Bold
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    
                    ModernButton {
                        text: "⬅️ Previous"
                        onClicked: gotoPreviousScript()
                        enabled: !recording && scriptListView.currentIndex > 0
                        Layout.preferredWidth: 130
                        Layout.preferredHeight: 40
                    }
                    
                    ModernButton {
                        text: "➡️ Next"
                        onClicked: gotoNextScript()
                        enabled: !recording
                        Layout.preferredWidth: 130
                        Layout.preferredHeight: 40
                    }
                    
                    ModernButton {
                        text: "🗑️ Delete"
                        isDanger: true
                        onClicked: deleteCurrentScript()
                        enabled: !recording && scriptModel.count > 0
                        Layout.preferredWidth: 130
                        Layout.preferredHeight: 40
                    }
                }

            }
        }
    }
    
    
    // Connect signals
    Connections {
        target: recorder
        function onSettingsChanged() {
            // Refresh UI when settings change
            console.log("Settings changed - refreshing UI")
            // Force QML to re-evaluate the property bindings
            themeCombo.currentIndex = currentTheme === "dark" ? 1 : 0
            // Refresh text elements
            saveDirText.text = recorder.getSaveDirectory()
            speakerNameText.text = recorder.getSpeakerName()
            // Refresh status bar
            statusSpeakerText.text = "Speaker: " + recorder.getSpeakerName()
            statusSaveDirText.text = "Save to: " + recorder.getSaveDirectory()
        }
        
        function onThemeChanged(theme) {
            console.log("Theme changed to:", theme)
            currentTheme = theme
        }
    }
    
}