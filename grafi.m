clear all;
close all;

format long

run("nastavitve.m")

ddata=1;

st_data_day=6*24;
st_data_hour=6;
num_day=eomday(leto,mesec);
num_data=num_day*st_data_day;



fid = fopen(ime_datoteke);

i=1;
cnt=1;
tline = fgets(fid);

temperatura=[{}];
vlaga=[{}];
dez=[{}];
sneg=[{}];


while ischar(tline) && (tline(1)!=',')
	countA=1;
	find1=strfind(tline,',');
	A=strsplit(tline,',');
	datum_tmp(cnt)=A(countA);
	dan_str=char(datum_tmp(cnt));

	if strcmp(obdobje,'mesec') || strcmp(obdobje,'teden') || (strcmp(obdobje,'dan') && strcmp(num2str(dan),dan_str(1:2)))

		datum(i)=datum_tmp(cnt);
		countA=countA+1;
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
			sneg(i)='NaN';
		else	
			sneg(i)=A(countA);
			countA=countA+1;
		end
		i=i+1;
	end 
	cnt=cnt+1;   
	tline = fgets(fid);
end
fclose(fid);

temperatura=str2num(char(temperatura));
vlaga=str2num(char(vlaga));
dez=str2num(char(dez));
sneg=str2num(char(sneg));


if strcmp(obdobje,'mesec') 

	datum=char(datum);
	datum=datenum(datum, 'dd.mm.yyyy HH:MM');
	datum1=cellstr(datestr(datum, 'dd'));
	datum1(1:st_data_day:end);
	datum=(datum-700000)*100;

	if(sum(strcmp("temperatura",izris)))
	
		figure
		plot(datum(1:ddata:end), temperatura(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Temperatura - ", char(mesci(mesec)),' ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Temperatura [°C]")
		grid on

	end


	if(sum(strcmp("vlaga",izris)))

		figure
		plot(datum(1:ddata:end), vlaga(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Relativna vlažnost - ", char(mesci(mesec)),' ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Relativna vlažnost [%]")
		grid on
	end

	if(sum(strcmp("dez",izris)))

		figure
		bar(datum(1:ddata:end), dez(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Padavine - ", char(mesci(mesec)),' ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Padavine [mm]")
		grid on
	end

	if(sum(strcmp("sneg",izris)))
		figure
		plot(datum(1:ddata:end), sneg(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Višina snežne odeje - ", char(mesci(mesec)),' ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Višina [mm]")
		grid on
	end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%PO TEDNIH%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(obdobje,'teden') 

	datum=char(datum);
	datum=datenum(datum, 'dd.mm.yyyy HH:MM');
	datum1=cellstr(datestr(datum, 'dd.mm.'));
	datum1(1:st_data_day:end);
	datum=(datum-700000)*1000;

	if(sum(strcmp("temperatura",izris)))
	
		figure
		plot(datum(1:ddata:end), temperatura(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Temperatura - Teden ", num2str(teden),' - ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Temperatura [°C]")
		grid on
	end

	if(sum(strcmp("vlaga",izris)))

		figure
		plot(datum(1:ddata:end), vlaga(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Relativna vlažnost - Teden ", num2str(teden),' - ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Relativna vlažnost [%]")
		grid on
	end

	if(sum(strcmp("dez",izris)))

		figure
		bar(datum(1:ddata:end), dez(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Padavine - Teden ", num2str(teden),' - ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Padavine [mm]")
		grid on
	end

	if(sum(strcmp("sneg",izris)))
		figure
		plot(datum(1:ddata:end), sneg(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_day:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_day:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Višina snežne odeje - Teden ", num2str(teden),' - ',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Višina [mm]")
		grid on
	end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%PO DNEVIH%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(obdobje,'dan') 

	datum=char(datum);
	datum=datenum(datum, 'dd.mm.yyyy HH:MM');
	datum1=cellstr(datestr(datum, 'HH:MM'));
	datum1(1:st_data_hour:end);
	datum=(datum-700000)*1000;

	if(sum(strcmp("temperatura",izris)))
	
		figure
		plot(datum(1:ddata:end), temperatura(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_hour:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_hour:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Temperatura - ", num2str(dan),'.',num2str(mesec),'.',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Temperatura [°C]")
		grid on
	end

	if(sum(strcmp("vlaga",izris)))

		figure
		plot(datum(1:ddata:end), vlaga(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_hour:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_hour:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Relativna vlažnost - ", num2str(dan),'.',num2str(mesec),'.',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Relativna vlažnost [%]")
		grid on
	end

	if(sum(strcmp("dez",izris)))

		figure
		bar(datum(1:ddata:end), dez(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_hour:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_hour:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Padavine - ", num2str(dan),'.',num2str(mesec),'.',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Padavine [mm]")
		grid on
	end

	if(sum(strcmp("sneg",izris)))
		figure
		plot(datum(1:ddata:end), sneg(1:ddata:end))
		ax=gca;
		xtick=datum(1:st_data_hour:end);
		set(gca, 'xtick', xtick);
		xlim([min(datum) max(datum)])

		xticklabel=char(datum1(1:st_data_hour:end));
		set(gca,'xticklabel',xticklabel);


		h = get(gca,'xlabel');
		xlabelstring = get(h,'string');
		xlabelposition = get(h,'position');


		## construct position of new xtick labels
		yposition = xlabelposition(2);
		yposition = repmat(yposition,length(xtick),1);

		set(gca,'xticklabel','');

		%set(gca,'xtick',[]);

		%set(gca, 'xtick', xtick);
		hnew = text(xtick, yposition, xticklabel);
		set(hnew,'horizontalalignment','right','rotation',90);

		title(cstrcat("Višina snežne odeje - ", num2str(dan),'.',num2str(mesec),'.',num2str(leto)))
		xlabel("Dan v mesecu")
		ylabel("Višina [mm]")
		grid on
	end
end
