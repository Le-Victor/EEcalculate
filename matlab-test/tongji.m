fadianmat=[];
fadiannum=0;
shudianmat=[];
shudiannum=0;
peidianmat=[];
peidiannum=0;
hunhemat=[];
hunhenum=0;
for num1=1:length(stateMat)
    errmat=stateMat(num1).st;
    errnum=stateMat(num1).num;
    if (isempty(find(errmat(1,:)>0, 1))==0)&&(isempty(find(errmat(2,:)>0, 1)))&&(isempty(find(errmat(3,:)>1, 1)))
        shudianmat=[shudianmat;errmat];
        shudiannum=shudiannum+errnum;
    elseif (isempty(find(errmat(2,:)>0, 1))==0)&&(isempty(find(errmat(1,:)>0, 1)))&&(isempty(find(errmat(3,:)>1, 1)))
        fadianmat=[fadianmat;errmat];
        fadiannum=fadiannum+errnum;
    elseif (isempty(find(errmat(3,:)>1, 1))==0)&&(isempty(find(errmat(1,:)>0, 1)))&&(isempty(find(errmat(2,:)>0, 1)))
        peidianmat=[peidianmat;errmat];
        peidiannum=peidiannum+errnum;
    else
        hunhemat=[hunhemat;errmat];
        hunhenum=hunhenum+errnum;
    end
end