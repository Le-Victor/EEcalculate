function mpc=caseJZ251SCEPFWHPE
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1ĸ���� 2ĸ���й� 3ĸ���޹� 4ĸ��ʯ�Ͳ��� 5ĸ����Ȼ������ 6�Ƿ�ᵼ��ƽ̨ȫͣ�� 7�������й� 8�������޹� 9��̬�й� 10��̬�޹�
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
%1��·��� 2ʼ��ĸ�� 3�ն�ĸ�� 4������ 5�����޸�ʱ�� 6���ɿ���
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
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
    13	1	7500	6000	0.0167	5	0.083094	0.042999	0.1277	0.0958	0.0035	0.1234	0.0133	0.1234	2.0324	0.026176	0.0012261	0.10927	0.05526;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,0.727+0.526i,1.1+0.4i,2+0.8i,2+1.2i,1.1+0.4i,0.9+0.4i,0,0,0,0,0,0.8+0.4i,0,2.2+1.4i;
];
end