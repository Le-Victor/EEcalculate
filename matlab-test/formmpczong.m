function mpczong=formmpczong
%总系统结构体
mpczong = extcase14;
%联络母线
lianluomuxiandata=[1,1,zeros(1,23)];
mpczong.busstate(1).data=lianluomuxiandata;
mpc=caseJZ251WHPB;
mpczong.busstate(2).data=lianluomuxiandata;
mpczong.busstate(3).data=lianluomuxiandata;
mpc=caseJZ251SWHPB;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(4).data=peidianyudubiao;
mpczong.busstate(5).data=lianluomuxiandata;
mpc=caseJX11CEPA;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(6).data=peidianyudubiao;
mpc=caseJX11WHPB;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(7).data=peidianyudubiao;
mpczong.busstate(8).data=lianluomuxiandata;
mpc=caseJZ251SWHPC;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(9).data=peidianyudubiao;
mpc=caseJZ251SWHPD;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(10).data=peidianyudubiao;
mpc=caseJZ251CEPWHPA;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(11).data=peidianyudubiao;
mpc=caseJZ251SCEPFWHPE;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(12).data=peidianyudubiao;
mpc=caseJZ251SCEPWHPA;
peidianyudubiao = formpeidianyundubiao(mpc);
mpczong.busstate(13).data=peidianyudubiao;

end