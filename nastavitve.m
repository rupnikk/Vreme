
mesci=[{"Januar"; "Februar"; "Marec"; "April"; "Maj";...
 "Junij"; "Julij"; "Avgust"; "September"; "Oktober"; "November";"December"}];

dan=29;
mesec=6;
leto=2017;

teden=weeknum(datenum(leto,mesec,dan));

obdobje='dan';
izris=[{"temperatura", "sneg","dez","vlaga","dez_vsota"}];

mapa='2017/Podatki';

if strcmp(obdobje,'mesec') 
	ime_datoteke=strcat(char(mapa),'/',char(mesci(mesec)),'.csv');
elseif strcmp(obdobje,'teden') || strcmp(obdobje,'dan')
	ime_datoteke=strcat(char(mapa),'/',num2str(teden),'.csv');
end