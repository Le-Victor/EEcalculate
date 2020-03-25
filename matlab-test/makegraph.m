function c=makegraph(mpc)
c=zeros(size(mpc.bus,1));
for num=1:size(mpc.branch,1)
    c(mpc.branch(num,2),mpc.branch(num,3))=mpc.branch(num,1);
    c(mpc.branch(num,3),mpc.branch(num,2))=mpc.branch(num,1);
end
end