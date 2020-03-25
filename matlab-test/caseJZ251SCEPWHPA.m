function mpc=caseJZ251SCEPWHPA
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1ĸ���� 2ĸ���й� 3ĸ���޹� 4ĸ��ʯ�Ͳ��� 5ĸ����Ȼ������ 6�Ƿ�ᵼ��ƽ̨ȫͣ�� 7�������й� 8�������޹� 9��̬�й� 10��̬�޹�
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
%1��·��� 2ʼ��ĸ�� 3�ն�ĸ�� 4������ 5�����޸�ʱ�� 6���ɿ���
mpc.branch=[
    1 1 2 tranlinefailrate tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 5 tranlinefailrate tranlinerepairtime;
    4 2 3 switchfailrate switchrepairtime;
    5 3 4 switchfailrate switchrepairtime;
    6 4 5 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
    14	1	7500	6000	0.0167	5	0.065335	0.024058	0.065335	0.024058	0.0035	0.1234	0.0133	0.1234	2.0324	0.005003	0.002903	0.070339	0.026961;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,1.037+0.777i,2+0.8i,1+0.4i,1+0.4i,1.1+0.6i,0.9+0.4i,0,0,0,0,0,0,0,1+0.4i;
];
end