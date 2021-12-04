import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.julialang 1.0

ApplicationWindow {
    title: "JuliaPBF"
    x: 100
    y: 100
    width: 1000
    height: 600
    visible: true

    Connections {
      target: guiproperties.timer
      function onTimeout() { Julia.counter_slot(); }
    }

    RowLayout {
        // spacing: 100
        anchors.fill: parent 
        // color:"gray"
        // anchors.centerIn: parent

        ColumnLayout {
            id: firstCol
            anchors.4:   parent.top   
            anchors.left:  parent.left + 10
            anchors.right: parent.left + 100  
            // spacing: 5
            // Layout.fillWidth: true // "100"
            // Layout.alignment: Qt.AlignCenter


            Text {
                text: "Backend"
            }

            ComboBox
            {
                id: backendBox
                model: ["None", "DamBreak"]
                // onCurrentIndexChanged: {
                // root.init_and_plot()
                // }
            }

            RowLayout{
                // anchors.left:  parent.left
                // anchors.right: parent.right
                // width: 0.5*parent.width 
                Text {
                    text: "time step (sec):"
                }
                // Text {
                //     // Layout.alignment: Qt.AlignCenter
                //     Layout.width: 300
                //     text: dt.value
                //     // placeholderText: qsTr("Start typing, Julia does the rest...")
                // }
            }

            Slider {
                id: dt
                width: 100
                value: 0.1
                stepSize: 0.01
                minimumValue: 0.01
                maximumValue: 1.
                // onValueChanged: root.do_plot()
            }

            Text {
                text: "Frequency:"
            }

            Slider {
                id: frequency
                width: 10
                value: 1.
                minimumValue: 1.
                maximumValue: 50.
                // onValueChanged: root.do_plot()
            }
        } //Col1

        Column {
            anchors.left:  firstCol.right
            anchors.right: parent.right
            spacing: 5

            Text {
                id: juliaHello
                Layout.alignment: Qt.AlignCenter
                text: Julia.hello()
            }

            Button {
                Layout.alignment: Qt.AlignCenter
                text: "Push Me"
                onClicked: { resultDisplay.text = Julia.increment_counter().toString(); }
            }

            Text {
                id: resultDisplay
                Layout.alignment: Qt.AlignCenter
                text: "Push button for result"
            }

            TextField {
                id: lowerIn
                Layout.alignment: Qt.AlignCenter
                Layout.minimumWidth: 300
                placeholderText: qsTr("Start typing, Julia does the rest...")
            }

            Text {
                id: upperOut
                Layout.alignment: Qt.AlignCenter
                text: Julia.uppercase(lowerIn.text)
            }

            Text {
                Layout.alignment: Qt.AlignCenter
                text: "Concatenation, showing multiple arguments:"
            }

            Text {
                Layout.alignment: Qt.AlignCenter
                text: Julia.string(guiproperties.oldcounter, ", ", upperOut.text)
            }

            Button {
                Layout.alignment: Qt.AlignCenter
                text: "Start counting"
                onClicked: guiproperties.timer.start()
            }

            Text {
                Layout.alignment: Qt.AlignCenter
                text: guiproperties.bg_counter.toString()
            }

            Button {
                Layout.alignment: Qt.AlignCenter
                text: "Stop counting"
                onClicked: guiproperties.timer.stop()
            }
        } //Col2
    } // Row
}
