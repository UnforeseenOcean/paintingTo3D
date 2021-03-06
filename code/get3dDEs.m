function DEs=get3dDEs(P,DEs,X,isValidMap)
N_DEs=length(DEs.scale_ids);
[W H]=size(X);
DEs.bbox_3d=zeros([N_DEs 4 3]);
isValid=[];
for DE_id =1:N_DEs
    bbox=DEs.bboxes(DE_id,:);
    patchSize=bbox(3)-bbox(1)+1;
    d=round((patchSize(1))/2);
    x(1)=round((bbox(3)+bbox(1))/2);
    x(2)=round((bbox(4)+bbox(2))/2);
    
    if (~isValidMap(x(1),x(2)) || x(1)-d<1 || x(1)+d>W-1|| x(2)-d<1 || x(2)+d>H-1 )
        continue;
    end
    isValid=[isValid DE_id];
    X0=squeeze(X(x(1),x(2),:));
    DEs.bbox_3d(DE_id,:,:)=getpatch3d(P,d,X0);    
end

    DEs.bbox_3d=DEs.bbox_3d(isValid,:,:);
    DEs.hog_bboxes=DEs.hog_bboxes(isValid,:);
    DEs.bboxes=DEs.bboxes(isValid,:);
    DEs.scale_ids=DEs.scale_ids(isValid);
    DEs.ws=DEs.ws(isValid,:);