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

    Row {
        id: baseRow
        anchors.fill: parent

        Column {
            id: firstCol
            anchors.left:  blank.right
            width: 0.14*baseRow.width
            spacing: baseRow.height/100

            Button {
                width: firstCol.width
                text: "Applying Changes"
                // enable: false
                onClicked: {  
                    if (Julia.read_xml_file_dir(caseXml.currentText)){
                        viscosity.value = 0.1;
                        surfaceTension.value = 0.7;
                        Julia.parsing_xml_file();
                        if (guiproperties.parsing_check){
                            runButton.text = "RUN!"    
                        }
                        else
                        {
                            runButton.text = "CHECK XML"    
                        }
                        // runButton.text = guiproperties.parsing_check.toString();
                    } 
                }
            }

            Text {
                text: "CASE:"
            }
            ComboBox
            {
                id: caseXml
                width: firstCol.width
                model: ["run.xml", "DamBreak.xml", "RecBubble.xml"]
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
            
            Button {
                id: "runButton"
                width: firstCol.width
                text: "CHECK XML"
                onClicked: {
                    if (guiproperties.parsing_check){
                        Julia.model_run() // 풀어서 onclick안에 모두 넣어야해... 그래야 중간에 취소가능..!
                    } 
                }
            }
        } //Col1
        
        Rectangle {
            id: blank3
            color:"grey"
            // text: "under Dvlp..."
            // anchors.fill: parent
            anchors.left:  firstCol.right
            width: 0.85* baseRow.width
            height: baseRow.height

            Text {
                anchors.fill: parent
                text: "under Dvlp..."
                // font: textMetrics.font
            }
        }
    } // Row
}
