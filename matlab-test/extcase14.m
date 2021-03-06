function mpc = extcase14
%EXTCASE14

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax
%	Vmin	lam_P	lam_Q	mu_Vmax	mu_Vmin 有功下垂系数	无功下垂系数	有功频率参数	无功频率参数
%	有功电压系数	无功电压系数 原油产量 天然气产量
mpc.bus = [
    1	1	0	0	0	0	1	1	0	35	1	1.3	0.7	0	0	0.0000 	0	0	0 0	0;
    2	1	0	0	0	0	1	1	0	35	1	1.3	0.7	0	0	0.0000 	0	0	0 0	0;
    3	1	0	0	0	0	1	1	0	10.5	1	1.3	0.7	0	0	0.0000 	0	0	0 0	0;
    4	1	0.361	0	0	0	1	1	0	10.5	1	1.3	0.7	0	0	1.0000 	1.5	1.6	1 435	56;
    5	1	0	0	0	0	1	1	0	35	1	1.3	0.7	0	0	0.0000 	0	0	0 0	0;
    6	1	5.393	2.179	0	0	1	1	0	35	1	1.3	0.7	0	0	1.0000 	1.5	1.6	1 1285.37	8.897
    7	1	1.48	0.158	0	0	1	1	0	35	1	1.3	0.7	0	0	1.0000 	1.5	1.6	1 449.97	25.8;
    8	1	0	0	0	0	1	1	0	35	1	1.3	0.7	0	0	0.0000 	0	0	0 0	0;
    9	1	3.408 	1.441	0	0	1	1	0	35	1	1.3	0.7	0	0	1.0000 	1.5	1.6	1 2448	14.827;
    10	1	1.199 	0.546	0	0	1	1	0	35	1	1.3	0.7	0	0	1.0000 	1.5	1.6	1 481	11.745;
    11	2	4.3	2.5	0	0	1	1	0	6.3	1	1.3	0.7	24.86	1.243	1.0000 	1.5	1.6	1 813	32;
    12	2	10.827 	5.526	0	0	1	1	0	6.3	1	1.3	0.7	24.86	1.243	1.0000 	1.5	1.6	1 1327.02 16.18;
    13	3	8.037 	3.377	0	0	1	1	0	6.3	1	1.3	0.7	24.86	1.243	1.0000 	1.5	1.6	1 1923.88 93.034;
    ];
mpc.bus(:,21)=mpc.bus(:,21).*1e4;
mpc.bus(:,20)=mpc.bus(:,20)./24;
%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2
%	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
%	故障率 修复率
genfailrate=1.38/8760;
genrepairrate=1/23.5;
mpc.gen = [
    13	9.96780571	4.82986857	12.431	-12.431	1	100	1	12.431	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    13	9.96780571	4.82986857	12.431	-12.431	1	100	0	12.431	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    13	9.96780571	4.82986857	12.431	-12.431	1	100	0	12.431	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    13	9.96780571	4.82986857	12.431	-12.431	1	100	1	12.431	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    11	9.96780571	4.82986857	12.431	-12.431	1	100	0	12.431	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    11	9.96780571	4.82986857	12.431	-12.431	1	100	1	12.431	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    12	9.96780571	4.82986857	12.431	-12.431	1	100	0	12.98	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    12	9.96780571	4.82986857	12.431	-12.431	1	100	1	12.98	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    12	9.96780571	4.82986857	12.431	-12.431	1	100	1	12.98	0	0	0	0	0	0	0	0	0	0	0	0 genfailrate  genrepairrate;
    ];

mpc.gen(:,2:5)=mpc.gen(:,2:5)/mpc.baseMVA;
mpc.gen(:,9:10)=mpc.gen(:,9:10)/mpc.baseMVA;
%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
switchfailrate=0.002/8760;
switchrepairrate=1/4.67;
transformerfailrate=0.1113/8760;
transformerrepairrate=1/12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairrate=1/((2*switchfailrate/switchrepairrate+transformerfailrate/transformerrepairrate)/tranlinefailrate);
% submarinerepairrate=1/400;
mpc.branch = [
%     1	2	0.000004	0.000004	0	0	0	0	0	0	1	360	-360 0.0175/8760   1/120;
    1	2	0.1833	0.1309	0.008	0   0	0	0	0	1	360	-360 0.0304/8760   1/450.12;
%     9	2	0.0816	0.0838	0.0067	0	0	0	0	0	1	360	-360 0.0175/8760   1/120;
    2	8	0.0023	0.002	0.0001	0	0	0	0	0	1	360	-360 0.0175/8760   1/290.68;
    4	3	0.5867	0.5388	0.0007	0	0	0	0	0	1	360	-360 0.0175/8760   1/290.68;
    5	6	0.1698	0.2634	0.0251	0	0	0	0	0	1	360	-360 0.0933/8760   1/898.54;
    7	6	0.0245	0.038	0.0036	0	0	0	0	0	1	360	-360 0.0175/8760   1/230;
    9	8	0.1116	0.0746	0.0036	0	0	0	0	0	1	360	-360 0.0175/8760   1/280;
    8	10	0.1296	0.0867	0.0041	0	0	0	0	0	1	360	-360 0.0175/8760   1/306.4;
    1	11	0.029	0.4233	0	0	0	0	1	0	1.0068	360	-360 tranlinefailrate/1000   tranlinerepairrate;
    8	12	0.0379	0.5	    0	0	0	0	1	0	1.0068	360	-360 tranlinefailrate/1000   tranlinerepairrate;
    2	13	0.029	0.4233	0	0	0	0	1	0	1.0068	360	-360 tranlinefailrate/1000   tranlinerepairrate;
    3	13	0.0668	0.75	0	0	0	0	1	0	1	360	-360 tranlinefailrate/1000   tranlinerepairrate;
    5	13	0.0225	0.4	    0	0	0	0	1	0	1.0068	360	-360 tranlinefailrate/1000  tranlinerepairrate;
    ];


%负荷特性矩阵
%节点标识	开机情况	铭牌额定P	额定电压	额定转差率sn	极对数p	额定有功	额定无功	有功小计	无功小计	标幺Rs	标幺Xs	标幺Rr	标幺Xr	标幺xm	静态有功	静态无功	平台有功	平台无功
mpc.load=[
    4	1	1000	6000	0.0167	5	0	0	0	0	0.0035	0.1234	0.0133	0.1234	2.0324	0.00361	0	0.00361	0;
    6	1	5000	6000	0.0167	5	0.03393	0.02079	0.05393	0.02179	0.0035	0.1234	0.0133	0.1234	2.0324	0.02	0.001	0.05393	0.02179;
    7	1	2000	6000	0.0167	5	0.01	0.00158	0.01	0.00158	0.0035	0.1234	0.0133	0.1234	2.0324	0.0048	0.00	0.0148	0.00158;
    9	1	5000	6000	0.0167	5	0.017555	0.011588	0.017555	0.011588	0.0035	0.1234	0.0133	0.1234	2.0324	0.016525	0.02822	0.016525	0.02822;
    10	1	5000	6000	0.0167	5	0.005108	0.01099	0.00446	0.015328	0.0035	0.1234	0.0133	0.1234	2.0324	0.001	0.001	0.01199	0.00546;
    11	1	5000	6000	0.0167	5	0.029	0.019	0.029	0.019	0.0035	0.1234	0.0133	0.1234	2.0324	0.014	0.006	0.043	0.025;
    12	1	7500	6000	0.0167	5	0.083094	0.042999	0.1277	0.0958	0.0035	0.1234	0.0133	0.1234	2.0324	0.026176	0.0012261	0.10927	0.05526;
    13	1	7500	6000	0.0167	5	0.065335	0.024058	0.065335	0.024058	0.0035	0.1234	0.0133	0.1234	2.0324	0.005003	0.002903	0.070339	0.026961;
    ];

%混合法配电网裕度表
%1累计概率 2确切概率 3有功负荷 4无功负荷 5原油减产量 6天然气减产量 7虚拟电机有功 8虚拟电机无功 9静态有功 10静态无功
%11一级负荷累计功率 12二级负荷累计功率（1+2两级）......以此类推直至15级
mpc.busstate(1).data=[
    ];
%失负荷等级设定
mpc.klossset=4;
mpc.kstop=2;
%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    2	0	0	2	0	1;
    ];
%生产线子系统
mpc.oilsubgroup=[1,11,0,0,0;2,3,4,5,13;6,7,0,0,0;8,9,10,12,0];
mpc.importbus=[6,11,12,13];
mpc.unimportbus=[1,0,0,0;2,3,4,5;7,0,0,0;8,9,10,0];
mpc.xitongtingyun=[0.175/8760,1/120];

%% 导入数据电网数据
mpc.NL=size(mpc.branch,1);%线路数量
mpc.Ngen=size(mpc.gen,1);%发电机数量
mpc.Nbus=size(mpc.bus,1);%母线数据
% 总电量数据
mpc.allload=sum(mpc.bus(:,3))+sum(mpc.bus(:,4))*1i;
% 总产油量数据
mpc.alloilloss=sum(mpc.bus(:,20));
mpc.maxoillosslimit=mpc.alloilloss*24*10;



