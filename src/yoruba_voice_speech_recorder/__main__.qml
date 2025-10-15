import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia

ApplicationWindow {
    id: root
    visible: true
    width: 1440; height: 1080
    title: qsTr("Yorùbá Voice Recorder")
    
    property bool recording: false
    property string promptsName: ''
    property string scriptText: ''
    property string scriptFilename: ''
    property string saveDir: '.'
    property string currentTheme: "light"
    
    // Theme colors
    property color primaryColor: currentTheme === "dark" ? "#2b2b2b" : "#f5f5f6"
    property color secondaryColor: currentTheme === "dark" ? "#3c3c3c" : "#ffffff"
    property color textColor: currentTheme === "dark" ? "#ffffff" : "#333333"
    property color accentColor: currentTheme === "dark" ? "#4a9eff" : "#007acc"
    property color buttonColor: currentTheme === "dark" ? "#4a9eff" : "#007acc"
    property color buttonHoverColor: currentTheme === "dark" ? "#5ba8ff" : "#0088dd"
    
    color: primaryColor
    
    // Settings dialog
    Dialog {
        id: settingsDialog
        title: "Settings"
        width: 500
        height: 400
        anchors.centerIn: parent
        
        background: Rectangle {
            color: secondaryColor
            border.color: accentColor
            border.width: 2
            radius: 8
        }
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 20
            
            Text {
                text: "Settings"
                font.pixelSize: 24
                font.bold: true
                color: textColor
                Layout.alignment: Qt.AlignHCenter
            }
            
            // Theme selection
            RowLayout {
                Text {
                    text: "Theme:"
                    color: textColor
                    font.pixelSize: 16
                }
                
                ComboBox {
                    id: themeCombo
                    model: ["light", "dark"]
                    currentIndex: currentTheme === "dark" ? 1 : 0
                    onCurrentTextChanged: {
                        currentTheme = currentText
                        recorder.setTheme(currentText)
                    }
                    
                    background: Rectangle {
                        color: secondaryColor
                        border.color: accentColor
                        border.width: 1
                        radius: 4
                    }
                }
            }
            
            // Save directory
            RowLayout {
                Text {
                    text: "Save Directory:"
                    color: textColor
                    font.pixelSize: 16
                }
                
                Text {
                    text: recorder.getSaveDirectory()
                    color: textColor
                    font.pixelSize: 14
                    Layout.fillWidth: true
                    elide: Text.ElideMiddle
                }
                
                Button {
                    text: "Browse"
                    onClicked: recorder.selectSaveDirectory()
                    
                    background: Rectangle {
                        color: buttonColor
                        radius: 4
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            
            // Speaker name
            RowLayout {
                Text {
                    text: "Speaker Name:"
                    color: textColor
                    font.pixelSize: 16
                }
                
                Text {
                    text: recorder.getSpeakerName()
                    color: textColor
                    font.pixelSize: 14
                    Layout.fillWidth: true
                }
                
                Button {
                    text: "Set"
                    onClicked: recorder.setSpeakerName()
                    
                    background: Rectangle {
                        color: buttonColor
                        radius: 4
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            
            // Prompts count
            RowLayout {
                Text {
                    text: "Prompts Count:"
                    color: textColor
                    font.pixelSize: 16
                }
                
                Text {
                    text: recorder.getPromptsCount()
                    color: textColor
                    font.pixelSize: 14
                    Layout.fillWidth: true
                }
                
                Button {
                    text: "Set"
                    onClicked: recorder.setPromptsCount()
                    
                    background: Rectangle {
                        color: buttonColor
                        radius: 4
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            
            // Close button
            Button {
                text: "Close"
                Layout.alignment: Qt.AlignHCenter
                onClicked: settingsDialog.close()
                
                background: Rectangle {
                    color: buttonColor
                    radius: 4
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    
    // Quit confirmation dialog
    Dialog {
        id: quitDialog
        title: "Quit Application"
        width: 300
        height: 150
        anchors.centerIn: parent
        
        background: Rectangle {
            color: secondaryColor
            border.color: accentColor
            border.width: 2
            radius: 8
        }
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 20
            
            Text {
                text: "Are you sure you want to quit?"
                color: textColor
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                
                Button {
                    text: "Yes"
                    onClicked: {
                        quitDialog.close()
                        recorder.requestQuit()
                    }
                    
                    background: Rectangle {
                        color: "#ff4444"
                        radius: 4
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                
                Button {
                    text: "No"
                    onClicked: quitDialog.close()
                    
                    background: Rectangle {
                        color: buttonColor
                        radius: 4
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    Component.onCompleted: initTimer.start()
    Timer {
        id: initTimer
        interval: 0
        onTriggered: recorder.init(scriptModel)
    }

    onRecordingChanged: recorder.toggleRecording(recording)
    onScriptFilenameChanged: scriptModel.get(scriptListView.currentIndex).filename = scriptFilename

    // called by python code on init for each listview item: self.window.appendScript({'script': script, 'filename': ''})
    function appendScript(data) {
        scriptModel.append(data)
    }

    function gotoNextScript() {
        scriptListView.incrementCurrentIndex();
        scriptListView.positionViewAtIndex(scriptListView.currentIndex, ListView.Center);
    }
    
    function showQuitDialog() {
        quitDialog.open()
    }

    ListModel {
        id: scriptModel
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        // Header with title and controls
        RowLayout {
            Layout.fillWidth: true
            spacing: 20
            
            Text {
                text: "Yorùbá Voice Recorder"
                font.pixelSize: 32
                font.bold: true
                color: textColor
                Layout.fillWidth: true
            }
            
            // Settings button
            Button {
                text: "⚙️ Settings"
                onClicked: settingsDialog.open()
                
                background: Rectangle {
                    color: buttonColor
                    radius: 6
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            // Quit button
            Button {
                text: "❌ Quit"
                onClicked: showQuitDialog()
                
                background: Rectangle {
                    color: "#ff4444"
                    radius: 6
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        // Status bar
        Rectangle {
            Layout.fillWidth: true
            height: 40
            color: secondaryColor
            border.color: accentColor
            border.width: 1
            radius: 4
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 20
                
                Text {
                    text: "Speaker: " + recorder.getSpeakerName()
                    color: textColor
                    font.pixelSize: 14
                }
                
                Text {
                    text: "Save to: " + recorder.getSaveDirectory()
                    color: textColor
                    font.pixelSize: 14
                    Layout.fillWidth: true
                    elide: Text.ElideMiddle
                }
                
                Text {
                    text: "Theme: " + currentTheme
                    color: textColor
                    font.pixelSize: 14
                }
            }
        }

        // Main content area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: secondaryColor
            border.color: accentColor
            border.width: 2
            radius: 8
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                // Current script display
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 200
                    color: primaryColor
                    border.color: accentColor
                    border.width: 1
                    radius: 6
                    
                    ScrollView {
                        anchors.fill: parent
                        anchors.margins: 10
                        
                        Text {
                            id: scriptText
                            text: scriptListView.currentItem ? scriptListView.currentItem.script : ""
                            color: textColor
                            font.pixelSize: 24
                            wrapMode: Text.WordWrap
                            width: parent.width
                        }
                    }
                }

                // Recording controls
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20
                    
                    Button {
                        id: recordButton
                        text: recording ? "⏹️ Stop Recording" : "🎤 Start Recording"
                        onClicked: recording = !recording
                        
                        background: Rectangle {
                            color: recording ? "#ff4444" : buttonColor
                            radius: 8
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 18
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    
                    Button {
                        text: "➡️ Next Script"
                        onClicked: gotoNextScript()
                        enabled: !recording
                        
                        background: Rectangle {
                            color: enabled ? buttonColor : "#cccccc"
                            radius: 8
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                // Script list
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: primaryColor
                    border.color: accentColor
                    border.width: 1
                    radius: 6
                    
                    ListView {
                        id: scriptListView
                        anchors.fill: parent
                        anchors.margins: 10
                        model: scriptModel
                        spacing: 5
                        
                        delegate: Rectangle {
                            width: scriptListView.width
                            height: 60
                            color: index === scriptListView.currentIndex ? accentColor : secondaryColor
                            border.color: accentColor
                            border.width: 1
                            radius: 4
                            
                            Text {
                                anchors.fill: parent
                                anchors.margins: 10
                                text: script
                                color: index === scriptListView.currentIndex ? "white" : textColor
                                font.pixelSize: 14
                                wrapMode: Text.WordWrap
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: scriptListView.currentIndex = index
                            }
                        }
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
        }
        
        function onThemeChanged(theme) {
            currentTheme = theme
        }
    }
}