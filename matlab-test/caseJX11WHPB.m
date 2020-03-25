function mpc=caseJX11WHPB
switchfailrate=0.002/8760;
switchrepairtime=4.67;
transformerfailrate=0.1113/8760;
transformerrepairtime=12;
tranlinefailrate=switchfailrate*2+transformerfailrate;
tranlinerepairtime=(2*switchfailrate*switchrepairtime+transformerfailrate*transformerrepairtime)/tranlinefailrate;
%1ĸ���� 2ĸ���й� 3ĸ���޹� 4ĸ��ʯ�Ͳ��� 5ĸ����Ȼ������ 6�Ƿ�ᵼ��ƽ̨ȫͣ�� 7�������й� 8�������޹� 9��̬�й� 10��̬�޹�
mpc.bus=[
    1 0 0 0 0 0     0 0 0 0;
    2 0 0 0 0 0     0 0 0 0;
    3 0.681732283464567 0.0793891625615764 449.97/2 2.58/2*1e4 0 0.681732283464567 0.0793891625615764 0 0;
    4 0.524409448818898 0.0526666666666667 449.97/2 2.58/2*1e4 0 0.524409448818898 0.0526666666666667 0 0;
    5 0.273858267716535 0.0259441707717570 0 0 0  0.259058267716535 0.0259441707717570-0.00158 0.0148 0.00158;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1��·��� 2ʼ��ĸ�� 3�ն�ĸ�� 4������ 5�����޸�ʱ�� 6���ɿ���
mpc.branch=[
    1 1 2 tranlinefailrate tranlinerepairtime;
    2 1 3 tranlinefailrate tranlinerepairtime;
    3 1 4 tranlinefailrate tranlinerepairtime;
    4 1 5 switchfailrate switchrepairtime;
    5 3 4 switchfailrate switchrepairtime;
    6 4 5 switchfailrate switchrepairtime;
];
mpc.branch(:,6)=mpc.branch(:,4).*mpc.branch(:,5);
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
   8	1	2000	6000	0.0167	5	0.01	0.00158	0.01	0.00158	0.0035	0.1234	0.0133	0.1234	2.0324	0.0048	0.00	0.0148	0.00158;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,0,0,0,0,0,0,0,0,0,0,0.38+0.1i,0,0,1.1+0.058*1i;
];
end