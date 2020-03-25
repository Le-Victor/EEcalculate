function mpc=caseJZ251WHPB
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1ĸ���� 2ĸ���й� 3ĸ���޹� 4ĸ��ʯ�Ͳ��� 5ĸ����Ȼ������ 6�Ƿ�ᵼ��ƽ̨ȫͣ�� 7�������й� 8�������޹� 9��̬�й� 10��̬�޹�
mpc.bus=[
    1 0 0 0 0 0  0 0 0 0;
    2 1.5 0.6 1285.37/3 8.897/3*1e4 0 1.5 0.6 0 0;
    3 1.5 0.6 1285.37/3 8.897/3*1e4 0 1.5 0.6 0 0;
    4 0.2 0.1 1285.37/3 8.897/3*1e4 0 0 0 0.2 0.1;
    5 0.2 0.1 1285.37/3 8.897/3*1e4 0  0 0 0.2 0.1;
    6 0.2 0.05  0 0 0  0 0 0.2 0.05;
    7 0.2 0.05 0 0 0 0 0 0.2 0.05;
    8 0.2 0    0 0 1 0 0 0.2 0;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1��·��� 2ʼ��ĸ�� 3�ն�ĸ�� 4������ 5�����޸�ʱ�� 6���ɿ���
mpc.branch=[
    1 1 2 tranlinefailrate tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 4 tranlinefailrate tranlinerepairtime;
    4 1 5 tranlinefailrate tranlinerepairtime;
    5 1 6 tranlinefailrate tranlinerepairtime;
    6 1 7 tranlinefailrate tranlinerepairtime;
    7 1 8 tranlinefailrate tranlinerepairtime;
    8 2 3 switchfailrate switchrepairtime;
    9 4 5 switchfailrate switchrepairtime;
    10 6 7 switchfailrate switchrepairtime;
    11 7 8 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
  2	1	5000	6000	0.0167	5	0.03	0.012	0.03	0.012	0.0035	0.1234	0.0133	0.1234	2.0324	0.01	0.003	0.04	0.015;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,0,0,0,0,1.5+0.6i,0,0,0,0,0,0,1.5+0.6i,0,1+0.3i;
];
end