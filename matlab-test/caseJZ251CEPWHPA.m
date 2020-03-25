function mpc=caseJZ251CEPWHPA
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1母线名 2母线有功 3母线无功 4母线石油产量 5母线天然气产量 6是否会导致平台全停电 7虚拟电机有功 8虚拟电机无功 9静态有功 10静态无功
mpc.bus=[
    1 0.516361724500526,0.256026532923475 0 0 1  0.516361724500526,0.256026532923475 0 0;
    2 1.99943217665615,1.41037049021194 0 0 1 1.99943217665615,1.41037049021194 0 0;
    3 0.630757097791798,0.315078466267594 813/3 32/3*1e4 0 0.430757097791798,0.215078466267594 0.2 0.1;
    4 0.304752891692955,0.113654748422585 813/3 32/3*1e4 0 0.204752891692955,0.063654748422585 0.1 0.05;
    5 0.0379810725552050,0.0169875424688562 813/3 32/3*1e4 0  0.0279810725552050,0.0119875424688562 0.1 0.05;
    6 0.339568874868559,0.154505743407216  0 0 0  0 0 0.816995822676897,0.342961200585652;
    7 0.292092534174553,0.142371784500890 0 0 0 0.192092534174553,0.102371784500890 0.1,0.04;
    8 0.179053627760252,0.0910046917974438 0         0           0 0.099053627760252,0.0510046917974438  0.08,0.04;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1线路编号 2始端母线 3终端母线 4故障率 5故障修复时间 6不可靠度
mpc.branch=[
    1 1 3 tranlinefailrate tranlinerepairtime;
    2 1 4 tranlinefailrate tranlinerepairtime;
    3 1 2 tranlinefailrate tranlinerepairtime;
    4 1 6 tranlinefailrate tranlinerepairtime;
    5 3 4 switchfailrate switchrepairtime;
    6 4 5 switchfailrate switchrepairtime;
    7 5 6 switchfailrate switchrepairtime;
    8 2 7 tranlinefailrate tranlinerepairtime;
    9 2 8 tranlinefailrate tranlinerepairtime;
    10 7 8 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%负荷特性矩阵
%节点标识	开机情况	铭牌额定P	额定电压	额定转差率sn	极对数p	额定有功	额定无功	有功小计	无功小计	标幺Rs	标幺Xs	标幺Rr	标幺Xr	标幺xm	静态有功	静态无功	平台有功	平台无功
mpc.load=[
    12	1	5000	6000	0.0167	5	0.029	0.019	0.029	0.019	0.0035	0.1234	0.0133	0.1234	2.0324	0.014	0.006	0.043	0.025;
];
%有限脱扣等级负荷
%1到15级依次累计功率（1，1+2，1+2+3.....）
mpc.youxiantuokou=[
    0,0.4+0.2i,0,0.6+0.3i,0.7+0.3i,0.5+0.3i,0,0,0,0,0.8+0.5i,0,1+0.7i,0,0.3+0.2*1i;
];
end