function mpc=caseJZ251SWHPD
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
    3 0.127780991608046,0.222000000000000 481/3 11.745/3*1e4 0 0.127780991608046 0.222000000000000 0 0;
    4 0.127780991608046,0.326000000000000 481/3 11.745/3*1e4 0 0.127780991608046 0.326000000000000 0 0;
    5 0.141730562754535,0.113978240692998 481/3 11.745/3*1e4 0  0.141730562754535 0.113978240692998 0 0;
    6 0.148707454029372,0.119625141796432  0 0 0  0.048707454029372,0.019625141796432 0.1,0.1;
];
mpc.bus(:,4)=mpc.bus(:,4)./24;
%1��·��� 2ʼ��ĸ�� 3�ն�ĸ�� 4������ 5�����޸�ʱ�� 6���ɿ���
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
%�������Ծ���
%�ڵ��ʶ	�������	���ƶP	���ѹ	�ת����sn	������p	��й�	��޹�	�й�С��	�޹�С��	����Rs	����Xs	����Rr	����Xr	����xm	��̬�й�	��̬�޹�	ƽ̨�й�	ƽ̨�޹�
mpc.load=[
     11	1	5000	6000	0.0167	5	0.005108	0.01099	0.00446	0.015328	0.0035	0.1234	0.0133	0.1234	2.0324	0.001	0.001	0.01199	0.00546;
];
%�����ѿ۵ȼ�����
%1��15�������ۼƹ��ʣ�1��1+2��1+2+3.....��
mpc.youxiantuokou=[
    0,0,0.8876+0.5433i,0,0.3+0.2i,0,0,0,0,0,0,0,0,0,0.3+0.2i;
];
end