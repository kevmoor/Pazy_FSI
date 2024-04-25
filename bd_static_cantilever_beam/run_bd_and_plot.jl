import PyPlot
PyPlot.pygui(true)
PyPlot.close("all")
PyPlot.rc("figure", figsize=(4, 3))
PyPlot.rc("font", size=10.0)
PyPlot.rc("lines", linewidth=1.5)
PyPlot.rc("lines", markersize=4.0)
PyPlot.rc("legend", frameon=true)
PyPlot.rc("axes.spines", right=false, top=false)
PyPlot.rc("figure.subplot", left=.18, bottom=.17, top=0.9, right=.9)
PyPlot.rc("figure",max_open_warning=500)
# PyPlot.rc("axes", prop_cycle=["348ABD", "A60628", "009E73", "7A68A6", "D55E00", "CC79A7"])
plot_cycle=["#348ABD", "#A60628", "#009E73", "#7A68A6", "#D55E00", "#CC79A7"]
import DelimitedFiles

path = splitdir(@__FILE__)[1]


loads = [0.2,0.4,0.6,1.0,1.5,2.0] #kg
N_loads = length(loads)
gravity = 9.81
bendonly = false

tip_deflection_only = zeros(N_loads)
tip_deflection = zeros(N_loads)
tip_torsion = zeros(N_loads)

for (iload,load) in enumerate(loads)

    loadN = load*gravity
    if !bendonly
        moment = loadN*0.13/2
    else
        moment = 0.0
    end
    # change the file
    println(moment)

    input_string_array = "------- BEAMDYN Driver with OpenFAST INPUT FILE --------------------------------
Static analysis of a twisted beam
---------------------- SIMULATION CONTROL --------------------------------------
False         DynamicSolve  - Dynamic solve (false for static solve) (-)
          0   t_initial     - Starting time of simulation (s) [used only when DynamicSolve=TRUE]
         30   t_final       - Ending time of simulation   (s) [used only when DynamicSolve=TRUE]
      0.001   dt            - Time increment size         (s) [used only when DynamicSolve=TRUE]
---------------------- GRAVITY PARAMETER --------------------------------------
      0.0   Gx            - Component of gravity vector along X direction (m/s^2)
          0   Gy            - Component of gravity vector along Y direction (m/s^2)
          0   Gz            - Component of gravity vector along Z direction (m/s^2)
---------------------- FRAME PARAMETER --------------------------------------
          0   GlbPos(1)     - Component of position vector of the reference blade frame along X direction (m)
          0   GlbPos(2)     - Component of position vector of the reference blade frame along Y direction (m)
          0   GlbPos(3)     - Component of position vector of the reference blade frame along Z direction (m)
---The following 3 by 3 matrix is the direction cosine matirx ,GlbDCM(3,3),
---relates global frame to the initial blade root frame
1.0000000E+00  0.0000000E+00  0.0000000E+00  
0.0000000E+00  1.0000000E+00  0.0000000E+00  
0.0000000E+00  0.0000000E+00  1.0000000E+00  
T             GlbRotBladeT0 - Reference orientation for BeamDyn calculations is aligned with initial blade root?
---------------------- ROOT VELOCITY PARAMETER ----------------------------------
          0   RootVel(4)    - Component of angular velocity vector of the beam root about X axis (rad/s)
          0   RootVel(5)    - Component of angular velocity vector of the beam root about Y axis (rad/s)
          0   RootVel(6)    - Component of angular velocity vector of the beam root about Z axis (rad/s)
---------------------- APPLIED FORCE ----------------------------------
          0   DistrLoad(1)  - Component of distributed force vector along X direction (N/m)
          0   DistrLoad(2)  - Component of distributed force vector along Y direction (N/m)
          0   DistrLoad(3)  - Component of distributed force vector along Z direction (N/m)
          0   DistrLoad(4)  - Component of distributed moment vector along X direction (N-m/m)
          0   DistrLoad(5)  - Component of distributed moment vector along Y direction (N-m/m)
          0   DistrLoad(6)  - Component of distributed moment vector along Z direction (N-m/m)
          $loadN   TipLoad(1)    - Component of concentrated force vector at blade tip along X direction (N)
          0   TipLoad(2)    - Component of concentrated force vector at blade tip along Y direction (N)
          0   TipLoad(3)    - Component of concentrated force vector at blade tip along Z direction (N)
          0   TipLoad(4)    - Component of concentrated moment vector at blade tip along X direction (N-m)
          0   TipLoad(5)    - Component of concentrated moment vector at blade tip along Y direction (N-m)
          $moment   TipLoad(6)    - Component of concentrated moment vector at blade tip along Z direction (N-m)
          0   NumPointLoads - Number of point loads along blade
Non-dim blade-span eta   Fx          Fy            Fz           Mx           My           Mz
(-)                      (N)         (N)           (N)          (N-m)        (N-m)        (N-m)
---------------------- PRIMARY INPUT FILE --------------------------------------
\"bd_primary.inp\"    InputFile - Name of the primary BeamDyn input file
----- Output Settings -------------------------------------------------------------------
          2   WrVTK         - VTK visualization data output: (switch) {0=none; 1=init; 2=animation}
         15   VTK_fps       - Frame rate for VTK output (frames per second) {will use closest integer multiple of DT} [used only if WrVTK=2]

"

    open("$path/bd_driver_script$iload.inp", "w") do file
        write(file, input_string_array)
    end
    # Run beamdyn for the given load with no torsion
    run(`$path/../../openfast/build/modules/beamdyn/beamdyn_driver $path/bd_driver_script$iload.inp`)

    # load in the result
    BD_data = DelimitedFiles.readdlm("$path/bd_driver_script$iload.out",skipstart=8)
    BD_header = DelimitedFiles.readdlm("$path/bd_driver_script$iload.out",header=true,skipstart=6)[2]

    # find tip deflection index
    idx_TDxr = findfirst(x->x=="TipTDxr",BD_header)
    tip_deflection[iload] = BD_data[end,idx_TDxr[2]]

    # torsion
    idx_RDzr = findfirst(x->x=="TipRDzr",BD_header)
    tip_torsion[iload] = BD_data[end,idx_RDzr[2]]


end

if bendonly
    # load in experimental data from plot
    exp_bend_only = DelimitedFiles.readdlm("$path/tip_deflection_bend_only.csv",',',Float64)
    exp_bend_only_load = exp_bend_only[:,1]
    exp_bend_only_deflection = exp_bend_only[:,2]

    PyPlot.figure()
    PyPlot.plot(exp_bend_only_load,exp_bend_only_deflection,"k+",label = "Exp.")
    PyPlot.plot(loads,-tip_deflection,".",color=plot_cycle[1],label = "BD")
    PyPlot.xlabel("load (kg)")
    PyPlot.ylabel("Tip X-Deflection (m)")
    PyPlot.legend()
else

        # load in experimental data from plot
        exp_bend_twist = DelimitedFiles.readdlm("$path/tip_deflection_bend_twist.csv",',',Float64)
        exp_bend_twist_load = exp_bend_twist[:,1]
        exp_bend_twist_deflection = exp_bend_twist[:,2]
    
        PyPlot.figure()
        PyPlot.plot(exp_bend_twist_load,exp_bend_twist_deflection,"k+",label = "Exp.")
        PyPlot.plot(loads,-tip_deflection,".",color=plot_cycle[1],label = "BD")
        PyPlot.xlabel("load (kg)")
        PyPlot.ylabel("Tip X-Deflection (m)")
        PyPlot.legend()

        # load in experimental data from plot
        exp_bend_twist = DelimitedFiles.readdlm("$path/tip_torsion_bend_twist.csv",',',Float64)
        exp_bend_twist_load = exp_bend_twist[:,1]
        exp_bend_twist_torsion = exp_bend_twist[:,2]
    
        PyPlot.figure()
        PyPlot.plot(exp_bend_twist_load,exp_bend_twist_torsion,"k+",label = "Exp.")
        PyPlot.plot(loads,tip_torsion.*360/(2*pi),".",color=plot_cycle[1],label = "BD")
        PyPlot.xlabel("load (kg)")
        PyPlot.ylabel("Tip Torsion (deg)")
        PyPlot.legend()
                
        
end