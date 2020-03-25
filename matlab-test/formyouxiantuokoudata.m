function youxiantuokoudata=formyouxiantuokoudata(mpc)
errlossmat=makeerrlossmat(mpc);
youxiantuokoudata=zeros(size(errlossmat,1),25);
youxiantuokoudata(:,2:5)=errlossmat(:,1:4);
youxiantuokoudata(:,7:10)=errlossmat(:,5:8);
youxiantuokoudata(:,25)=errlossmat(:,2)+errlossmat(:,3)*1i;
youxiantuokoudata(1,11:25)=mpc.youxiantuokou;
%ฑ๊็Ûปฏ
youxiantuokoudata(:,3:4)=youxiantuokoudata(:,3:4)/100;
youxiantuokoudata(:,11:25)=youxiantuokoudata(:,11:25)/100;
leijigailv=0;
for num=length(youxiantuokoudata(:,3)):-1:1
    leijigailv=leijigailv+youxiantuokoudata(num,2);
    youxiantuokoudata(num,1)=leijigailv;
end
end