function LMat=solveLMat(Graph,possiablePaths,NL)
%��С·����
Llength=length(possiablePaths(:,1));
%��·����,��С·����
LMat=zeros(length(possiablePaths(:,1)),NL);
for num1=1:length(possiablePaths(:,1))
    num2=1;
    while(possiablePaths(num1,num2+1)~=0)
        num3=Graph(possiablePaths(num1,num2),possiablePaths(num1,num2+1));
        LMat(num1,num3)=1;
        num2=num2+1;
    end
end
end