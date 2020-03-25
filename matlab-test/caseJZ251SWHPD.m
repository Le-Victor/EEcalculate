function mpc=caseJZ251SWHPD
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1母线名 2母线有功 3母线无功 4母线石油产量 5母线天然气产量 6是否会导致平台全停电 7虚拟电机有功 8虚拟电机无功 9静态有功 10静态无功
mpc.bus=[
    1 0 0 0 0 0  0 0 0 0;
    2 0.941622631145290,0.161679694750954 0 0 1 0.941622631145290,0.161679694750954 0 0;
    3 0.127780991608046,0.222000000000000 481/3 11.745/3*1e4 0 0.127780991608046 0.222000000000000 0 0;
    4 0.127780991608046,0.326000000000000 481/3 11.745/3*1e4 0 0.127780991608046 0.326000000000000 0 0;
    5 0.141730562754535,0.113978240692998 481/3 11.745/3*1e4 0  0.141730562754535 0.113978240692998 0 0;
    6 0.148707454029372,0.119625141796432  0 0 0  0.048707454029372,0.019625141796432 0.1,0.1;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1线路编号 2始端母线 3终端母线 4故障率 5故障修复时间 6不可靠度
mpc.branch=[
    1 1 2 tranlinefailrate tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 4 tranlinefailrate tranlinerepairtime;
    4 1 5 tranlinefailrate tranlinerepairtime;
    5 3 4 switchfailrate switchrepairtime;
    6 4 5 switchfailrate switchrepairtime;
    7 5 6 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%负荷特性矩阵
%节点标识	开机情况	铭牌额定P	额定电压	额定转差率sn	极对数p	额定有功	额定无功	有功小计	无功小计	标幺Rs	标幺Xs	标幺Rr	标幺Xr	标幺xm	静态有功	静态无功	平台有功	平台无功
mpc.load=[
     11	1	5000	6000	0.0167	5	0.005108	0.01099	0.00446	0.015328	0.0035	0.1234	0.0133	0.1234	2.0324	0.001	0.001	0.01199	0.00546;
];
%有限脱扣等级负荷
%1到15级依次累计功率（1，1+2，1+2+3.....）
mpc.youxiantuokou=[
    0,0,0.8876+0.5433i,0,0.3+0.2i,0,0,0,0,0,0,0,0,0,0.3+0.2i;
];
end