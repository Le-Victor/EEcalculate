function mpc=caseJZ251SCEPWHPA
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1母线名 2母线有功 3母线无功 4母线石油产量 5母线天然气产量 6是否会导致平台全停电 7虚拟电机有功 8虚拟电机无功 9静态有功 10静态无功
mpc.bus=[
    1 3.67334229517476 1.18331536388140 0 0 1  3.67334229517476 1.18331536388140 0 0;
    2 2.26541729163719 1.00854878706199 0 0 1 2.26541729163719 1.00854878706199 0 0;
    3 0.594785764822414 0.213907008086253 1923.88/3 93.034/3*1e4 0 0.594785764822414 0.213907008086253 0.1 0.05;
    4 0.200157351068346 0.120152021563342 1923.88/3 93.034/3*1e4 0 0 0  0.200157351068346 0.120152021563342;
    5 0.200157351068346 0.120152021563342 1923.88/3 93.034/3*1e4 0  0 0 0.200157351068346 0.120152021563342;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
mpc.bus(:,2)=mpc.bus(:,2)/sum(mpc.bus(:,2))*8.037;
mpc.bus(:,3)=mpc.bus(:,3)/sum(mpc.bus(:,3))*3.777;
%1线路编号 2始端母线 3终端母线 4故障率 5故障修复时间 6不可靠度
mpc.branch=[
    1 1 2 tranlinefailrate tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 5 tranlinefailrate tranlinerepairtime;
    4 2 3 switchfailrate switchrepairtime;
    5 3 4 switchfailrate switchrepairtime;
    6 4 5 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%负荷特性矩阵
%节点标识	开机情况	铭牌额定P	额定电压	额定转差率sn	极对数p	额定有功	额定无功	有功小计	无功小计	标幺Rs	标幺Xs	标幺Rr	标幺Xr	标幺xm	静态有功	静态无功	平台有功	平台无功
mpc.load=[
    14	1	7500	6000	0.0167	5	0.065335	0.024058	0.065335	0.024058	0.0035	0.1234	0.0133	0.1234	2.0324	0.005003	0.002903	0.070339	0.026961;
];
%有限脱扣等级负荷
%1到15级依次累计功率（1，1+2，1+2+3.....）
mpc.youxiantuokou=[
    0,1.037+0.777i,2+0.8i,1+0.4i,1+0.4i,1.1+0.6i,0.9+0.4i,0,0,0,0,0,0,0,1+0.4i;
];
end