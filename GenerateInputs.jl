import PyPlot
PyPlot.pygui(true)
import FLOWMath
using Printf

span = 0.550 #m

spanAD = [0.0000000E+00,1.3667000E+00,4.1000000E+00,6.8333000E+00,1.0250000E+01,1.4350000E+01,1.8450000E+01,2.2550000E+01,2.6650000E+01,3.0750000E+01,3.4850000E+01,3.8950000E+01,4.3050000E+01,4.7150000E+01,5.1250000E+01,5.4666700E+01,5.7400000E+01,6.0133300E+01,6.1499900E+01]

spanAD = spanAD./maximum(spanAD) .* span

PyPlot.figure()
PyPlot.plot(spanAD,ones(length(spanAD)),".-")

println9=("AeroDyn Span")
for sp in spanAD
    @printf "\n%.7E" sp
end

spanBD = [0.0000000E+00,1.9987500E-01,1.1998650E+00,2.1998550E+00,3.1998450E+00,4.1998350E+00,5.1998250E+00,6.1998150E+00,7.1998050E+00,8.2010250E+00,9.1997850E+00,1.0199775E+01,1.1199765E+01,1.2199755E+01,1.3200975E+01,1.4199735E+01,1.5199725E+01,1.6199715E+01,1.8200925E+01,2.0200290E+01,2.2200270E+01,2.4200250E+01,2.6200230E+01,2.8200825E+01,3.0200190E+01,3.2200170E+01,3.4200150E+01,3.6200130E+01,3.8200725E+01,4.0200090E+01,4.2200070E+01,4.4200050E+01,4.6200030E+01,4.8201240E+01,5.0199990E+01,5.2199970E+01,5.4199950E+01,5.5199940E+01,5.6199930E+01,5.7199920E+01,5.7699915E+01,5.8201140E+01,5.8699905E+01,5.9199900E+01,5.9699895E+01,6.0199890E+01,6.0699885E+01,6.1199880E+01,6.1500000E+01]

spanBD = spanBD./maximum(spanBD) .* span

PyPlot.figure()
PyPlot.plot(spanBD,ones(length(spanBD)),".-")

println9=("ElastoDyn SpanBD")
for sp in spanBD
    @printf "\n%.7E" sp
end

# Inertia Matrix
# Keypoint	mass	cgx	cgy	cgz	Ixx	Iyy	Izz	Ixy	Ixz	Iyz

pazy_inertia_w_skin = [1	0.019118611	-6.09116E-06	0.006442847	-2.71488E-05	6.63182E-07	1.21417E-05	1.20938E-05	1.29099E-08	9.44646E-09	2.61327E-10
2	0.020678814	0.000903114	-0.001875011	-1.4896E-05	2.08435E-06	1.09721E-05	1.28287E-05	-4.29591E-08	2.45046E-09	-4.0502E-10
3	0.020682834	0.000913241	-0.00188019	-1.49442E-05	2.08701E-06	1.09788E-05	1.2838E-05	-4.66241E-08	2.45271E-09	-4.09114E-10
4	0.020682827	0.000913181	-0.001880211	-1.50172E-05	2.087E-06	1.09788E-05	1.2838E-05	-4.66239E-08	2.45762E-09	-4.0978E-10
5	0.020682857	0.000913136	-0.00188023	-1.50375E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66187E-08	2.45963E-09	-4.05575E-10
6	0.020682879	0.000913139	-0.001880211	-1.50375E-05	2.08702E-06	1.09789E-05	1.28381E-05	-4.66208E-08	2.45963E-09	-4.05572E-10
7	0.02068285	0.000913148	-0.001880205	-1.50377E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66181E-08	2.45978E-09	-4.05577E-10
8	0.020682853	0.000913134	-0.001880222	-1.50379E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66179E-08	2.45991E-09	-4.05587E-10
9	0.020682862	0.000913139	-0.001880228	-1.5038E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66201E-08	2.46005E-09	-4.05596E-10
10	0.020682862	0.000913138	-0.001880228	-1.50382E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66201E-08	2.46019E-09	-4.05603E-10
11	0.020682863	0.000913137	-0.001880227	-1.50384E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66201E-08	2.46033E-09	-4.0561E-10
12	0.020682863	0.000913137	-0.001880226	-1.50386E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66201E-08	2.46047E-09	-4.05617E-10
13	0.020682864	0.000913136	-0.001880225	-1.50387E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66202E-08	2.46061E-09	-4.05623E-10
14	0.020682864	0.000913136	-0.001880225	-1.50387E-05	2.08701E-06	1.09789E-05	1.2838E-05	-4.66202E-08	2.46062E-09	-4.05623E-10
15	0.025447952	-0.000811101	0.001342957	-3.00392E-05	1.68655E-06	1.45515E-05	1.55829E-05	-2.55762E-07	1.47231E-08	-2.22503E-09
16	0.043155893	0.005092725	0.00328783	-0.000143642	8.76965E-07	0.0001222	0.000122614	3.06994E-07	1.29956E-07	-7.38221E-09]

span_measured = [0, 0.038249998, 0.076499998, 0.114749997, 0.152999996, 0.191249995, 0.229499995, 0.267749994, 0.305999993, 0.344249993, 0.382499992, 0.420749991, 0.45899999, 0.49724999, 0.530718683, 0.549843728]
spanlen = diff(span_measured)
spanlen = [spanlen; spanlen[end]]
mass_measured = pazy_inertia_w_skin[:,2]./spanlen
cgx_measured = pazy_inertia_w_skin[:,3]
cgy_measured = pazy_inertia_w_skin[:,4]
cgz_measured = pazy_inertia_w_skin[:,5]
Ixx_measured = pazy_inertia_w_skin[:,6]./spanlen
Iyy_measured = pazy_inertia_w_skin[:,7]./spanlen
Izz_measured = pazy_inertia_w_skin[:,8]./spanlen
Ixy_measured = pazy_inertia_w_skin[:,9]./spanlen
Ixz_measured = pazy_inertia_w_skin[:,10]./spanlen
Iyz_measured = pazy_inertia_w_skin[:,11]./spanlen

# Spline onto the beamdyn 
mass_spl = FLOWMath.akima(span_measured,mass_measured,spanBD)
cgx_spl_tmp = FLOWMath.akima(span_measured,cgx_measured,spanBD)
cgy_spl_tmp = FLOWMath.akima(span_measured,cgy_measured,spanBD)
cgz_spl_tmp = FLOWMath.akima(span_measured,cgz_measured,spanBD)
Ixx_spl_tmp = FLOWMath.akima(span_measured,Ixx_measured,spanBD)
Iyy_spl_tmp = FLOWMath.akima(span_measured,Iyy_measured,spanBD)
Izz_spl_tmp = FLOWMath.akima(span_measured,Izz_measured,spanBD)
Ixy_spl_tmp = FLOWMath.akima(span_measured,Ixy_measured,spanBD)
Ixz_spl_tmp = FLOWMath.akima(span_measured,Ixz_measured,spanBD)
Iyz_spl_tmp = FLOWMath.akima(span_measured,Iyz_measured,spanBD)


PyPlot.figure()
PyPlot.plot(span_measured,mass_measured,".-",label="Input")
PyPlot.plot(spanBD,mass_spl,".-",label="Spline")
PyPlot.ylabel("mass")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,cgx_measured,".-",label="Input")
PyPlot.plot(spanBD,cgx_spl_tmp,".-",label="Spline")
PyPlot.ylabel("cgx")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,cgy_measured,".-",label="Input")
PyPlot.plot(spanBD,cgy_spl_tmp,".-",label="Spline")
PyPlot.ylabel("cgy")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,cgz_measured,".-",label="Input")
PyPlot.plot(spanBD,cgz_spl_tmp,".-",label="Spline")
PyPlot.ylabel("cgz")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,Ixx_measured,".-",label="Input")
PyPlot.plot(spanBD,Ixx_spl_tmp,".-",label="Spline")
PyPlot.ylabel("Ixx")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,Iyy_measured,".-",label="Input")
PyPlot.plot(spanBD,Iyy_spl_tmp,".-",label="Spline")
PyPlot.ylabel("Iyy")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,Izz_measured,".-",label="Input")
PyPlot.plot(spanBD,Izz_spl_tmp,".-",label="Spline")
PyPlot.ylabel("Izz")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,Ixy_measured,".-",label="Input")
PyPlot.plot(spanBD,Ixy_spl_tmp,".-",label="Spline")
PyPlot.ylabel("Ixy")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,Ixz_measured,".-",label="Input")
PyPlot.plot(spanBD,Ixz_spl_tmp,".-",label="Spline")
PyPlot.ylabel("Ixz")
PyPlot.legend()

PyPlot.figure()
PyPlot.plot(span_measured,Iyz_measured,".-",label="Input")
PyPlot.plot(spanBD,Iyz_spl_tmp,".-",label="Spline")
PyPlot.ylabel("Iyz")
PyPlot.legend()

# BeamDyn defines x as upward (edgewise rotation), y as downstream (flapwise rotation), and z and span (torsion)

# [m       0       0       0       0      −mYcm
# [0       m       0       0       0      mXcm]
# [0       0       m       mYcm    −mXcm  0 ]
# [0       0       mYcm    iEdg    −icp   0]
# [0       0       −mXcm   −icp    iFlp   0]
# [−mYcm   mXcm    0       0       0      iplr]

# 1. Coordinates and inertia distributions are given in the body frame that
# has x axis downstream, y axis along the wing span, and z axis upward

# So... for the cgs, BDx gets PZz, BDy gets PZx, and BDz gets PZy

cgx_spl = cgz_spl_tmp
cgy_spl = cgx_spl_tmp
cgz_spl = cgy_spl_tmp
Ixx_spl = Izz_spl_tmp
Iyy_spl = Ixx_spl_tmp
Izz_spl = Iyy_spl_tmp
Ixy_spl = Ixz_spl_tmp
Ixz_spl = Iyz_spl_tmp
Iyz_spl = Ixy_spl_tmp

# Questions: izz does not equal ixx+iyy...
# and should we include the Ixz and Iyz - no since they are so much smaller, and... I don't know what sign they should be...
# and the cg offsets for z ? - no since they are 5 orders of magnitude smaller

# Element	K11	K22	K33	K44	K12	K13	K14	K23	K24	K34
#Note: this is for the 15 elements, for simplicity, add a 16th with the same properties at the end for splining
pazy_stiffness_w_skin = [1	9794492.59	7.58259714	5.24743501	3317.57932	-0.569828967	-1.37141817	54485.5583	0.093308003	0.015291891	-0.11714116
2	9666690.55	7.58259714	4.50448461	3278.62894	-0.569828967	-1.85955625	53535.4102	0.093308003	0.015291891	-0.112442858
3	9647646.96	7.58259714	4.47822861	3282.87728	-0.569828967	-2.03745676	53207.1297	0.093308003	0.015291891	-0.115192612
4	9648770.85	7.58259714	4.47438433	3286.53821	-0.569828967	-2.36861943	53120.4588	0.093308003	0.015291891	-0.118950224
5	9649966.12	6.51183018	4.47481272	3288.81887	-0.244730557	-2.34621942	53068.8769	4.2266E-05	0.00394788	-0.120649484
6	9650620.48	6.51183018	4.47492882	3290.12279	-0.244730557	-2.33093397	53037.3657	4.2266E-05	0.00394788	-0.121389557
7	9650947.02	6.51183018	4.47492903	3290.7182	-0.244730557	-2.32194657	53022.4268	4.2266E-05	0.00394788	-0.121682056
8	9650920.85	6.51183018	4.47492905	3290.71311	-0.244730557	-2.31978268	53020.9363	4.2266E-05	0.00394788	-0.121652571
9	9650608.78	6.51583594	4.47492889	3290.15111	0.555131815	-2.32431249	53033.184	-0.001020123	-0.008696004	-0.121317479
10	9649975.19	6.51583594	4.47488638	3288.92576	0.555131815	-2.33594699	53060.3697	-0.001020123	-0.008696004	-0.120584487
11	9648871.83	6.51583594	4.47471764	3286.8598	0.555131815	-2.35794054	53106.1305	-0.001020123	-0.008696004	-0.119291993
12	9647158	6.51583594	4.47618354	3283.51136	0.555131815	-2.4228299	53175.5122	-0.001020123	-0.008696004	-0.11718496
13	9653447.06	7.11892627	4.48916524	3279.04566	1.14679646	-2.63402308	53360.3082	-0.080978073	0.010127797	-0.114807975
14	9699214.16	7.11892627	4.54819972	3271.6443	1.14679646	-2.79279201	54101.6226	-0.080978073	0.010127797	-0.116130851
15	10019632.8	17.3730728	4.77037999	3373.72291	6.1133995	-2.28331802	54451.9115	-1.39455813	0.424981724	-0.114249441
16	10019632.8	17.3730728	4.77037999	3373.72291	6.1133995	-2.28331802	54451.9115	-1.39455813	0.424981724	-0.114249441]

# span_measured # already defined
K11_measured = pazy_stiffness_w_skin[:,2] #./spanlen# axial stiffness
K22_measured = pazy_stiffness_w_skin[:,3] #./spanlen# torsional stiffness
K33_measured = pazy_stiffness_w_skin[:,4] #./spanlen# out of plane bending stiffness (flap bending)
K44_measured = pazy_stiffness_w_skin[:,5] #./spanlen# in plane bending stiffness (edge bending)
K12_measured = pazy_stiffness_w_skin[:,6] #./spanlen# axial torsion coupling
K13_measured = pazy_stiffness_w_skin[:,7] #./spanlen# axial out-of-plane coupling 
K14_measured = pazy_stiffness_w_skin[:,8] #./spanlen# axial in-plane coupling
K23_measured = pazy_stiffness_w_skin[:,9] #./spanlen# torsion out-of-plane coupling
K24_measured = pazy_stiffness_w_skin[:,10]#./spanlen # torsion in-plane coupling
K34_measured = pazy_stiffness_w_skin[:,11]#./spanlen # out-of-plane in-plane coupling

K11 = FLOWMath.akima(span_measured,K11_measured,spanBD)
K22 = FLOWMath.akima(span_measured,K22_measured,spanBD)
K33 = FLOWMath.akima(span_measured,K33_measured,spanBD)
K44 = FLOWMath.akima(span_measured,K44_measured,spanBD)
K12 = FLOWMath.akima(span_measured,K12_measured,spanBD)
K13 = FLOWMath.akima(span_measured,K13_measured,spanBD)
K14 = FLOWMath.akima(span_measured,K14_measured,spanBD)
K23 = FLOWMath.akima(span_measured,K23_measured,spanBD)
K24 = FLOWMath.akima(span_measured,K24_measured,spanBD)
K34 = FLOWMath.akima(span_measured,K34_measured,spanBD)


PyPlot.figure()
PyPlot.plot(span_measured,K11_measured,".-",label="Input")
PyPlot.plot(spanBD,K11,".-",label="Spline")
PyPlot.ylabel("K11")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K22_measured,".-",label="Input")
PyPlot.plot(spanBD,K22,".-",label="Spline")
PyPlot.ylabel("K22")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K33_measured,".-",label="Input")
PyPlot.plot(spanBD,K33,".-",label="Spline")
PyPlot.ylabel("K33")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K44_measured,".-",label="Input")
PyPlot.plot(spanBD,K44,".-",label="Spline")
PyPlot.ylabel("K44")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K12_measured,".-",label="Input")
PyPlot.plot(spanBD,K12,".-",label="Spline")
PyPlot.ylabel("K12")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K13_measured,".-",label="Input")
PyPlot.plot(spanBD,K13,".-",label="Spline")
PyPlot.ylabel("K13")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K14_measured,".-",label="Input")
PyPlot.plot(spanBD,K14,".-",label="Spline")
PyPlot.ylabel("K14")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K23_measured,".-",label="Input")
PyPlot.plot(spanBD,K23,".-",label="Spline")
PyPlot.ylabel("K23")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K24_measured,".-",label="Input")
PyPlot.plot(spanBD,K24,".-",label="Spline")
PyPlot.ylabel("K24")
PyPlot.legend()


PyPlot.figure()
PyPlot.plot(span_measured,K34_measured,".-",label="Input")
PyPlot.plot(spanBD,K34,".-",label="Spline")
PyPlot.ylabel("K34")
PyPlot.legend()




#          s_flap    s_edge   axial   b_edge  b_flap  torsion        
# s_flap  [ KShrFlp  0        0       0       0       0]
# s_edge  [ 0        KShrEdg  0       0       0       0]
# axial   [ 0        0        EA      0       0       0]
# b_edge  [ 0        0        0       EIEdg   0       0]
# b_flap  [ 0        0        0       0       EIFlp   0]
# torsion [ 0        0        0       0       0       GJ]

#          s_flap    s_edge   axial   b_edge  b_flap  torsion        
# s_flap  [ KShrFlp  0        0       0       0       0]
# s_edge  [ 0        KShrEdg  0       0       0       0]
# axial   [ 0        0        K11     K14     K13     K12]
# b_edge  [ 0        0        K14     K44     K34     K24]
# b_flap  [ 0        0        K13     K34     K33     K23]
# torsion [ 0        0        K12     K24     K23     K22]
 
println("Printing BeamDyn sectional properties")

nBD = length(spanBD)
for ispan = 1:nBD
    @printf "\n"
    println(spanBD[ispan]/spanBD[end])
    # TODO: get the shear stiffnesses
    stiffmatrix = [ K11[ispan]/1000        0        0              0              0              0
                            0 K11[ispan]/1000         0              0              0              0
                            0        0        K11[ispan]     K14[ispan]     K13[ispan]     K12[ispan]
                            0        0        K14[ispan]     K44[ispan]     K34[ispan]     K24[ispan]
                            0        0        K13[ispan]     K34[ispan]     K33[ispan]     K23[ispan]
                            0        0        K12[ispan]     K24[ispan]     K23[ispan]     K22[ispan]]

    for irow = 1:6
        for icol = 1:6
            @printf "%.7E " stiffmatrix[irow,icol]
            # print("$(massmatrix[irow,icol]) ")
        end
        @printf "\n"
    end

    @printf "\n"
    massmatrix = [mass_spl[ispan] 0 0 0 0 −mass_spl[ispan]*cgy_spl[ispan] 
                    0 mass_spl[ispan] 0 0 0 mass_spl[ispan]*cgx_spl[ispan] 
                    0 0 mass_spl[ispan] mass_spl[ispan]*cgy_spl[ispan] −mass_spl[ispan]*cgx_spl[ispan] 0  
                    0 0 mass_spl[ispan]*cgy_spl[ispan]  Ixx_spl[ispan] −Ixy_spl[ispan] 0  
                    0 0 −mass_spl[ispan]*cgx_spl[ispan] −Ixy_spl[ispan]  Iyy_spl[ispan] 0
                    −mass_spl[ispan]*cgy_spl[ispan] mass_spl[ispan]*cgx_spl[ispan] 0 0 0  Izz_spl[ispan]]
    for irow = 1:6
        for icol = 1:6
            @printf "%.7E " massmatrix[irow,icol]
            # print("$(massmatrix[irow,icol]) ")
        end
        @printf "\n"
    end

end

mass_splED = FLOWMath.akima(span_measured,mass_measured,spanBD)
K33ED = FLOWMath.akima(span_measured,K33_measured,spanBD)
K44ED = FLOWMath.akima(span_measured,K44_measured,spanBD)
println("\nPrinting ElastoDyn Sectional Properties\n")
println("    BlFract      PitchAxis      StrcTwst       BMassDen        FlpStff        EdgStff")
println("      (-)           (-)          (deg)          (kg/m)         (Nm^2)         (Nm^2)")
for ispan = 1:length(spanBD)
    @printf "%.7E %.7E %.7E %.7E %.7E %.7E\n" spanBD[ispan]/spanBD[end] 2.5000000E-01 0.0000000E-00 mass_splED[ispan] K33ED[ispan] K44ED[ispan]
end