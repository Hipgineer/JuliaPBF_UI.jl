# module JuliaPBF_UI
using Test
using QML
using Qt5QuickControls_jll
using Observables
push!(LOAD_PATH,pwd()) # Hard coded, need to be changed
using JuliaPBF
using Printf

##
## PARAMETERS ##
dirExamples = "C:\\Users\\geosr\\Desktop\\work\\JuliaPBF_UI.jl\\examples\\" # Hard coded, need to be changed
dirCaseXml  = ""
const parseCheck = Observable(false)
const runCheck   = Observable(false)

function read_xml_file_dir(caseXML)
  global dirExamples
  global dirCaseXml = dirExamples*caseXML
  global parseCheck
  out = false
  if isfile(dirCaseXml)
    print("\nXML DIR: "*dirCaseXml*"\n")
    out = true
    parseCheck[]  = true
  else
    print("\nXML DIR: The case does not exist.\n") 
    out = false
    parseCheck[]  = false
  end
  return out
end

function parsing_xml_file()
  print("XML PARSED...")
  global dirCaseXml
  try
    global ANALYDATA   = JuliaPBF.IO_dev.Parsing_xml_file(dirCaseXml) # Parsing Inputs
    global SIMULDATA   = JuliaPBF.Solver.PreProcessing(ANALYDATA) # FillInitialBox, GenInitGrid   
    print("DONE.\n")
  finally
    print("CHECK XML.\n")
  end
end

function model_run()
  print("RUNNING MODEL...\n")
  runCheck[] = true
  curr_time = 0.0 
  ii        = 0 
  while curr_time < ANALYDATA.endTime
    curr_time += ANALYDATA.timeStep.dt
    @printf("Time = %10.5f \n",curr_time)
    @printf("  Update for          :")
    @time JuliaPBF.Solver.Update(SIMULDATA, ANALYDATA)

    ii += 1
    @printf("  Writing Output for  :")
    @time JuliaPBF.IO_dev.Writing_ascii_file(SIMULDATA, "out__"*lpad(ii,5,"0"))
    if runCheck == false
      break
    end
  end 
  print("END MODEL.\n")
end


@qmlfunction read_xml_file_dir parsing_xml_file model_run

# absolute path in case working dir is overridden
qml_file = joinpath(dirname(@__FILE__), "qml", "gui.qml")

# Load the QML file
loadqml(qml_file, guiproperties=JuliaPropertyMap("parsing_check" => parseCheck, "running_check" => runCheck))

# Run the application
exec()