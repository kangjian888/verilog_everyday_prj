This project template is used for digital circuit simulation and synthesis now period.
#### 1. How to run the example 
1. open the dc_shell_prj_temp and open terminal in this folder
2. run vcs simulation:
cd /behav_sim
./run
3. run dc_shell synthesis
cd ./..
cd /syn
./run
#### 2. put your own project to in this template
Replace your own files to the example design. 
1. replace the source code in the "rtl" folder.
2. modify the run script and run.tcl
You could refer the folder structure so you will know how to do in details

#### 3. Folder Structure
#####-dc_shell_prj_temp
######--behave_sim: the files used in vcs simulation is putted in this folder.
######---run: sh script used to run vcs simulation. input "./run"then the simulation could be run. But before you run it. you need open it and replace the files name with your own.
######---clean: sh script used to clean the temporary files generated in the simulation. input "./clean" then the temporay files will be cleaned so you can begin next time simulation
######---BCD_encoder_tb: the testbench example. You should use your own testbench to replace it.
#####--rtl: put your own rtl source code in this file
######---BCD_encoder: example source code, you could replace it with your own design
#####--syn: the files used in dc synthesis is putted in this folder
######---run:sh script used to run dc synthesis. input "./run"then the synthesis could be run. But before you run it. you need open run.tcl to replace the file and module name with your own
######---clean:sh script used to clean the temporary files generated in the synthesis. input "./clean" then the temporay files will be cleaned so you can begin next time synthesis
######---BCD_encoder.constrains.tcl: this file include the time and IO constrains information of the design. You could change the name to "xxx.tcl" as your requirment.
######---run.tcl: This is the most important file. It control the dc_shell runnung progress. Before the systhesis running, you must open it to modify the including files name and the output files name as your requirment. Then you could used in two ways. First is open the terminal in "/syn" folder. Then input "./run" to run the synthesis. Or you can open the terminal in "\syn" folder. Then input "design_vision" to open the gui version of dc_shell. Then click "file", then click "excute script". Then choose the "run.tcl" to run in the gui of dc_shell.

#### 4. this is created by KANG Jian, if you have any questions about that. contact 906641639@qq.com

