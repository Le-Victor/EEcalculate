function mpc=caseJZ251SWHPC
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1ĸ���� 2ĸ���й� 3ĸ���޹� 4ĸ��ʯ�Ͳ��� 5ĸ����Ȼ������ 6�Ƿ�ᵼ��ƽ̨ȫͣ�� 7�������й� 8�������޹� 9��̬�й� 10��̬�޹�
mpc.bus=[
    1 0 0 0 0 0  0 0 0 0;
    2 0.941622631145290,0.161679694750954 0 0 1 0.941622631145290,0.161679694750954 0 0;
    3 0.650056577863224,0.968889347220790 2448/2 14.827/2*1e4 0 0.650056577863224,0.968889347220790 0.2 0.1;
    4 0.163801153529250,0.0282345055171703 2448/2 14.827/2*1e4 0 0.163801153529250,0.0282345055171703 0.2 0.1;
    5 0.665500686624554,0.113978240692998 0 0 0  0 0 0.665500686624554,0.113978240692998;
    6 0.698260917330404,0.119625141796432  0 0 0  0 0 0.698260917330404,0.119625141796432;
    7 0.288758033507278,0.0485930700216562 0 0 0 0 0 0.288758033507278,0.0485930700216562;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1��·��� 2ʼ��ĸ�� 3�ն�ĸ�� 4������ 5�����޸�ʱ�� 6���ɿ���
mpc.branch=[
    1 1 2 tranlinefailrate^2 2*tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 4 tranlinefailrate tranlinerepairtime;
    4 1 5 tranlinefailrate tranlinerepairtime;
    5 1 6 tranlinefailrate tranlinerepairtime;
    6 1 7 tranlinefailrate tranlinerepairtime;
    7 1 8 tranlinefailrate tranlinerepairtime;
    8 3 4 switchfailrate switchrepairtime;
    9 5 6 switchfailrate switchrepairtime;
    10 6 7 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5)/8760;
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
     10	1	5000	6000	0.0167	5	0.017555	0.011588	0.017555	0.011588	0.0035	0.1234	0.0133	0.1234	2.0324	0.016525	0.02822	0.016525	0.02822;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,1+0.441i,0.708+0.3i,0,0.7+0.3i,0,0,0,0,0,0,0,0.8+0.3i,0,0.2+0.1i;
];
end