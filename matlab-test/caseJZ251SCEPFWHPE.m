function mpc=caseJZ251SCEPFWHPE
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1母线名 2母线有功 3母线无功 4母线石油产量 5母线天然气产量 6是否会导致平台全停电 7虚拟电机有功 8虚拟电机无功 9静态有功 10静态无功
mpc.bus=[
    1 7.17578247974417 3.71121558092680 0 0 1  7.17578247974417 3.71121558092680 0 0;
    2 0.942419432339735 0.472384726086539 0 0 1 0.942419432339735 0.472384726086539 0 0;
    3 0.261916060510662 0.109745946464550 1327.02/3 16.18/3*1e4 0 0.161916060510662 0.059745946464550 0.1 0.05;
    4 0.0292413136049575 0.106564904538041 1327.02/3 16.18/3*1e4 0 0.0292413136049575 0.056564904538041 0.1 0.05;
    5 0.300186900402631 0.133603760913365 1327.02/3 16.18/3*1e4 0  0 0 0.300186900402631 0.133603760913365;
    6 0.983680181598263 0.466552815887940  0 0 0  0 0 0.983680181598263 0.466552815887940;
    7 1.00700147465743 0.471854552432121 0 0 0 0 0 1.00700147465743 0.471854552432121;
    8 0.126772157142147,0.0540777127506476 0         0           1 0 0  0.126772157142147,0.0540777127506476;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1线路编号 2始端母线 3终端母线 4故障率 5故障修复时间 6不可靠度
mpc.branch=[
    1 1 2 tranlinefailrate tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 5 tranlinefailrate tranlinerepairtime;
    4 2 3 switchfailrate switchrepairtime;
    5 3 4 switchfailrate switchrepairtime;
    6 4 5 switchfailrate switchrepairtime;
    7 1 6 tranlinefailrate tranlinerepairtime;
    8 1 7 tranlinefailrate tranlinerepairtime;
    9 1 8 tranlinefailrate tranlinerepairtime;
    10 6 7 tranlinefailrate tranlinerepairtime;
    11 7 8 tranlinefailrate tranlinerepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%负荷特性矩阵
%节点标识	开机情况	铭牌额定P	额定电压	额定转差率sn	极对数p	额定有功	额定无功	有功小计	无功小计	标幺Rs	标幺Xs	标幺Rr	标幺Xr	标幺xm	静态有功	静态无功	平台有功	平台无功
mpc.load=[
    13	1	7500	6000	0.0167	5	0.083094	0.042999	0.1277	0.0958	0.0035	0.1234	0.0133	0.1234	2.0324	0.026176	0.0012261	0.10927	0.05526;
];
%有限脱扣等级负荷
%1到15级依次累计功率（1，1+2，1+2+3.....）
mpc.youxiantuokou=[
    0,0.727+0.526i,1.1+0.4i,2+0.8i,2+1.2i,1.1+0.4i,0.9+0.4i,0,0,0,0,0,0.8+0.4i,0,2.2+1.4i;
];
end