function mpc=caseJX11CEPA
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1ĸ���� 2ĸ���й� 3ĸ���޹� 4ĸ��ʯ�Ͳ��� 5ĸ����Ȼ������ 6�Ƿ�ᵼ��ƽ̨ȫͣ�� 7�������й� 8�������޹� 9��̬�й� 10��̬�޹�
mpc.bus=[
    1 0 0 0 0 0  0 0 0 0;
    2 2.32547263427110,0.900073755490483 0 0 1 2.32547263427110,0.900073755490483 0 0;
    3 0.384360443307758,0.155130124450952 1285.37/3 8.897/3*1e4 0 0.184360443307758,0.055130124450952 0.2 0.1;
    4 0.337005029838022,0.168689055636896 1285.37/3 8.897/3*1e4 0 0.137005029838022,0.068689055636896 0.2 0.1;
    5 0.384360443307758,0.155130124450952 1285.37/3 8.897/3*1e4 0  0.184360443307758,0.055130124450952 0.2 0.1;
    6 0.816995822676897,0.342961200585652  0 0 0  0 0 0.816995822676897,0.342961200585652;
    7 0.755847570332481,0.306671120058565 0 0 0 0 0 0.755847570332481,0.306671120058565;
    8 0.388958056265985,0.150344619326501 0         0           1 0 0  0.388958056265985,0.150344619326501;
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
    8 3 4 switchfailrate switchrepairtime;
    9 4 5 switchfailrate switchrepairtime;
    10 6 7 switchfailrate switchrepairtime;
    11 7 8 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
    7	1	5000	6000	0.0167	5	0.03393	0.02079	0.05393	0.02179	0.0035	0.1234	0.0133	0.1234	2.0324	0.02	0.001	0.05393	0.02179;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,0,0,0,0,1.1+0.4i,0,0,0,0,0,0,2+0.7i,0,2.293+1.179*1i;
];
end