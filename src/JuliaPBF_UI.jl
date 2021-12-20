# module JuliaPBF_UI
using Test
using QML
using Qt5QuickControls_jll
using Observables
using Printf
push!(LOAD_PATH,pwd()) # Hard coded, need to be changed
using JuliaPBF

## PARAMETERS ##
dirExamples = "D:\\work\\JuliaPBF_UI.jl\\examples\\" # Hard coded, need to be changed
dirCaseXml  = ""
const bParseCheck = Observable(false)
const bRunCheck   = Observable(false)

## TIME VARIABLE ##
endTime = 0.0
timeStep = 0.0

## XML 파일의 존재 유무를 확인합니다.
function read_xml_file_dir(caseXML)
  global dirExamples
  global dirCaseXml = dirExamples*caseXML
  global parseCheck
  out = false
  if isfile(dirCaseXml)
    print("\nXML DIR: "*dirCaseXml*"\n")
    out = true
    bParseCheck[]  = true
  else
    print("\nXML DIR: "*dirCaseXml*"\n")
    print("\nXML DIR: The case does not exist.\n") 
    out = false
    bParseCheck[]  = false
  end
  return out
end

## 파일이 존재하면 XML을 파싱해 모의정보를 생성합니다.
function parsing_xml_file()
  print("XML PARSED...")
  global dirCaseXml, endTime, timeStep
  try
    global ANALYDATA   = JuliaPBF.IO_dev.Parsing_xml_file(dirCaseXml) # Parsing Inputs  
    endTime = ANALYDATA.endTime
    timeStep= ANALYDATA.timeStep.dt
    print("DONE.\n")
  catch err
    print("\n\n")
    println(err)
    print("Please, check XML file..\n")
  end
end

## 생성된 모의정보로 모의데이터를 생성합니다.
function initializing_simulation_data()
  print("INITIALIZING SIMULATION...")
  try 
    global SIMULDATA   = JuliaPBF.Solver.PreProcessing(ANALYDATA) # FillInitialBox, GenInitGrid
  catch err
    print("\n\n")
    println(err)
    print("Please, check XML file..\n")
  end
end

function stop_run()
  bRunCheck[] = false
end

function model_run()
  print("RUNNING MODEL...\n")
  bRunCheck[] = true
  curr_time = 0.0 
  ii        = 0 
  while curr_time >=0# ANALYDATA.endTime
    curr_time += ANALYDATA.timeStep.dt
    @printf("Time = %10.5f \n",curr_time)
    # @printf("  Update for          :")
    # @time JuliaPBF.Solver.Update(SIMULDATA, ANALYDATA)

    ii += 1
    # @printf("  Writing Output for  :")
    # @time JuliaPBF.IO_dev.Writing_ascii_file(SIMULDATA, "out__"*lpad(ii,5,"0"))
    println(bRunCheck)
    # if check_run() == false
    #   break
    # end
  end 
  print("END MODEL.\n")
end


@qmlfunction read_xml_file_dir parsing_xml_file initializing_simulation_data model_run stop_run

# absolute path in case working dir is overridden
qml_file = joinpath(dirname(@__FILE__), "qml", "gui.qml")

# Load the QML file
properties = JuliaPropertyMap("parsing_check" => bParseCheck, 
                              "running_check" => bRunCheck,
                              "tims_step" => timeStep,
                              "end_time" => endTime)
loadqml(qml_file, guiproperties=properties)

# Run the application
exec()