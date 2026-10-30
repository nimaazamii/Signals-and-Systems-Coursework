close all;
clc;clear;
A=imread('PCB.jpg');
B=imread('IC.png');
ICrecognition(A,B);
function ICrecognition(A,B)
    pcb=rgb2gray(A);
    ic=rgb2gray(B);
    [rowpcb,colpcb]=size(pcb);
    [rowic,colic]=size(ic);
    figure
    imshow(pcb)
    hold on
    for i=1:(rowpcb-rowic)
        for j=1:(colpcb-colic)
            a=double(ic);
            b=double(pcb(i:(i+rowic-1),j:(j+colic-1)));
            makhraj=sqrt(sum(sum(a.*a))*sum(sum(b.*b)));
            soorat=sum(sum(a.*b));
            coff=soorat/makhraj;
            if coff>=0.9
                rectangle('position',[j,i,colic,rowic],'Edgecolor','r','Linewidth',3);
            end
        end
    end
    ic=imrotate(ic,180);
    for i=1:(rowpcb-rowic)
        for j=1:(colpcb-colic)
            a=double(ic);
            b=double(pcb(i:(i+rowic-1),j:(j+colic-1)));
            makhraj=sqrt(sum(sum(a.*a))*sum(sum(b.*b)));
            soorat=sum(sum(a.*b));
            coff=soorat/makhraj;
            if coff>=0.9
                rectangle('position',[j,i,colic,rowic],'Edgecolor','r','Linewidth',3);
            end
        end
    end
end