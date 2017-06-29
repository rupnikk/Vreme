clear all;
close all;

format long

run("nastavitve.m")


xos=[{"J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"}];


for idx=1:12

	ime_datoteke=strcat(char(mapa),'/',char(mesci(idx)),'.csv');

	fid = fopen(ime_datoteke);

	i=1;
	cnt=1;
	tline = fgets(fid);

	temperatura=[{}];
	vlaga=[{}];
	dez=[{}];
	dez_vsota=[{}];
	sneg=[{}];

	while ischar(tline) && (tline(1)!=',')
		countA=1;
		find1=strfind(tline,',');
		A=strsplit(tline,',');
		if find1(1)==1
			datum_tmp(cnt)='NaN';
		else
			datum_tmp(cnt)=A(countA);
			countA=countA+1;
		end
		
		dan_str=char(datum_tmp(cnt));

			datum(i)=datum_tmp(cnt);
			if (find1(2)-find1(1))==1
				temperatura(i)='NaN';
			else
				temperatura(i)=A(countA);
				countA=countA+1;
			end

			if (find1(3)-find1(2))==1
				vlaga(i)='NaN';
			else	
				vlaga(i)=A(countA);
				countA=countA+1;
			end

			if (find1(4)-find1(3))==1
				dez(i)='NaN';
			else	
				dez(i)=A(countA);
				countA=countA+1;
			end

			if (find1(5)-find1(4))==1
				dez_vsota(i)='NaN';
			else	
				dez_vsota(i)=A(countA);
				countA=countA+1;
			end

			if (length(tline)-2==find1(5))
				sneg(i)='NaN';
			else	
				sneg(i)=A(countA);
				countA=countA+1;
			end


			i=i+1; 
		cnt=cnt+1;
		tline = fgets(fid);
	end
	fclose(fid);

	temperatura=str2num(char(temperatura));
	vlaga=str2num(char(vlaga));
	dez=str2num(char(dez));
	sneg=str2num(char(sneg));
	dez_vsota=str2num(char(dez_vsota));

	temperatura(isnan(temperatura))=[];
	if length(temperatura)==0
		temperatura_kl(idx)=0;
	else
		temperatura_kl(idx)=sum(temperatura)/length(temperatura);
	end

	vlaga(isnan(vlaga))=[];
	if length(vlaga)==0
		vlaga_kl(idx)=0;
	else
		vlaga_kl(idx)=sum(vlaga)/length(vlaga);
	end

	dez(isnan(dez))=[];
	if length(dez)==0
		dez_kl(idx)=0;
	else
		dez_kl(idx)=sum(dez);
	end

	sneg(isnan(sneg))=[];
	if length(sneg)==0
		sneg_kl(idx)=0;
	else
		sneg_kl(idx)=max(sneg);
	end
end

dez_kl(isnan(dez_kl))=[];
if length(dez_kl)==0
	sum_dez=0;
else
	sum_dez=sum(dez_kl);
end

figure

bar(dez_kl,'b')
ax2=gca;

set(ax2,'YAxisLocation', 'Right');
set(gca,'xticklabel','');
set(gca, 'xtick', []);
xlim([0.5 length(xos)+0.5])


ylabel("Padavine [mm]");
text(6.5,300,cstrcat(num2str(sum_dez)," mm"),'Color','blue','Fontsize',14,'HorizontalAlignment','center')


hold on
axes


plot(temperatura_kl,'r')
hold on;
ax=gca;
set (ax, "color", "none") 
xtick=1:length(xos);
set(gca, 'xtick', xtick);
xlim([0.5 length(xos)+0.5])

xticklabel=char(xos);
set(gca,'xticklabel',xticklabel);
h = get(gca,'xlabel');
xlabelstring = get(h,'string');
xlabelposition = get(h,'position');


## construct position of new xtick labels
yposition = xlabelposition(2);
yposition = repmat(yposition,length(xtick),1);

set(gca,'xticklabel','');

hnew = text(xtick, yposition, xticklabel);
set(hnew,'horizontalalignment','right','rotation',0);
title(cstrcat("Zadlog - ", num2str(leto)))
ylabel("Temperatura [°C]")

grid on

