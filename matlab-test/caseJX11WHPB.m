function mpc=caseJX11WHPB
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1母线名 2母线有功 3母线无功 4母线石油产量 5母线天然气产量 6是否会导致平台全停电 7虚拟电机有功 8虚拟电机无功 9静态有功 10静态无功
mpc.bus=[
    1 0 0 0 0 0     0 0 0 0;
    2 0 0 0 0 0     0 0 0 0;
    3 0.681732283464567 0.0793891625615764 449.97/2 2.58/2*1e4 0 0.681732283464567 0.0793891625615764 0 0;
    4 0.524409448818898 0.0526666666666667 449.97/2 2.58/2*1e4 0 0.524409448818898 0.0526666666666667 0 0;
    5 0.273858267716535 0.0259441707717570 0 0 0  0.259058267716535 0.0259441707717570-0.00158 0.0148 0.00158;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1线路编号 2始端母线 3终端母线 4故障率 5故障修复时间 6不可靠度
mpc.branch=[
    1 1 2 tranlinefailrate tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 4 tranlinefailrate tranlinerepairtime;
    4 1 5 switchfailrate switchrepairtime;
    5 3 4 switchfailrate switchrepairtime;
    6 4 5 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%负荷特性矩阵
%节点标识	开机情况	铭牌额定P	额定电压	额定转差率sn	极对数p	额定有功	额定无功	有功小计	无功小计	标幺Rs	标幺Xs	标幺Rr	标幺Xr	标幺xm	静态有功	静态无功	平台有功	平台无功
mpc.load=[
   8	1	2000	6000	0.0167	5	0.01	0.00158	0.01	0.00158	0.0035	0.1234	0.0133	0.1234	2.0324	0.0048	0.00	0.0148	0.00158;
];
%有限脱扣等级负荷
%1到15级依次累计功率（1，1+2，1+2+3.....）
mpc.youxiantuokou=[
    0,0,0,0,0,0,0,0,0,0,0,0.38+0.1i,0,0,1.1+0.058*1i;
];
end