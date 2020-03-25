function mpc=caseJZ251CEPWHPA
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1ĸ���� 2ĸ���й� 3ĸ���޹� 4ĸ��ʯ�Ͳ��� 5ĸ����Ȼ������ 6�Ƿ�ᵼ��ƽ̨ȫͣ�� 7�������й� 8�������޹� 9��̬�й� 10��̬�޹�
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
%1��·��� 2ʼ��ĸ�� 3�ն�ĸ�� 4������ 5�����޸�ʱ�� 6���ɿ���
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
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
    12	1	5000	6000	0.0167	5	0.029	0.019	0.029	0.019	0.0035	0.1234	0.0133	0.1234	2.0324	0.014	0.006	0.043	0.025;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,0.4+0.2i,0,0.6+0.3i,0.7+0.3i,0.5+0.3i,0,0,0,0,0.8+0.5i,0,1+0.7i,0,0.3+0.2*1i;
];
end