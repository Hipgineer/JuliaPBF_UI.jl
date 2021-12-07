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

    Row {
        id: firstRow
        anchors.fill: parent
        spacing:parent.width/100

        Rectangle {
            id: blank
            width:0.01*parent.width
        }

        Column {
            id: firstCol
            anchors.left:  blank.right
            width: 0.14*firstRow.width
            spacing: firstRow.height/100

            Button {
                width: firstCol.width
                text: "Applying Changes"
                // onClicked: { resultDisplay.text = Julia.increment_counter().toString(); }
            }

            Text {
                text: "CASE:"
            }
            ComboBox
            {
                id: backendBox
                width: firstCol.width
                model: ["run.xml", "DamBreak", "Static"]
                // onCurrentIndexChanged: {
                // root.init_and_plot()
                // }
            }
            Text {
                text: "Viscosity"
            }
            Slider {
                id: viscosity
                width: firstCol.width
                value: 0.5
                stepSize: 0.01
                minimumValue: 0.0
                maximumValue: 1.0
                // onValueChanged: root.do_plot()
            }

            Text {
                text: "Surface Tension"
            }

            Slider {
                id: surfaceTension
                width: firstCol.width
                value: 0.5
                stepSize: 0.01
                minimumValue: 0.0
                maximumValue: 1.0
                // onValueChanged: root.do_plot()
            }
        } //Col1
        
        Rectangle {
            id: blank3
            color:"black"
            // anchors.fill: parent
            anchors.left:  firstCol.right
            width: 0.85* firstRow.width
            height: firstRow.height
        }

        // Column {
        //     anchors.left:  firstCol.right
        //     // spacing: 5

        //     Text {
        //         id: juliaHello
        //         // Layout.alignment: Qt.AlignCenter
        //         // text: Julia.hello()
        //     }

        //     Button {
        //         // Layout.alignment: Qt.AlignCenter
        //         text: "Push Me"
        //         // onClicked: { resultDisplay.text = Julia.increment_counter().toString(); }
        //     }

        //     Text {
        //         id: resultDisplay
        //         // Layout.alignment: Qt.AlignCenter
        //         text: "Push button for result"
        //     }

        //     TextField {
        //         id: lowerIn
        //         // Layout.alignment: Qt.AlignCenter
        //         // Layout.minimumWidth: 300
        //         // placeholderText: qsTr("Start typing, Julia does the rest...")
        //     }

        //     Text {
        //         id: upperOut
        //         // Layout.alignment: Qt.AlignCenter
        //         // text: Julia.uppercase(lowerIn.text)
        //     }

        //     Text {
        //         // Layout.alignment: Qt.AlignCenter
        //         text: "Concatenation, showing multiple arguments:"
        //     }

        //     Text {
        //         // Layout.alignment: Qt.AlignCenter
        //         // text: Julia.string(guiproperties.oldcounter, ", ", upperOut.text)
        //     }

        //     Button {
        //         // Layout.alignment: Qt.AlignCenter
        //         text: "Start counting"
        //         // onClicked: guiproperties.timer.start()
        //     }

        //     Text {
        //         // Layout.alignment: Qt.AlignCenter
        //         // text: guiproperties.bg_counter.toString()
        //     }

        //     Button {
        //         // Layout.alignment: Qt.AlignCenter
        //         text: "Stop counting"
        //         // onClicked: guiproperties.timer.stop()
        //     }
        // } //Col2
    } // Row
}
