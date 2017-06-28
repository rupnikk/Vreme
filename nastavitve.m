
mesci=[{"Januar"; "Februar"; "Marec"; "April"; "Maj";...
 "Junij"; "Julij"; "Avgust"; "September"; "Oktober"; "November";"December"}];

dan=24;
mesec=6;
leto=2017;

teden=weeknum(datenum(leto,mesec,dan));

obdobje='teden';
izris=[{"temperatura", "sneg","dez"}];

mapa='test';

if strcmp(obdobje,'mesec') 
	ime_datoteke=strcat(char(mapa),'/test_',char(mesci(mesec)),'.csv');
elseif strcmp(obdobje,'teden') || strcmp(obdobje,'dan')
	ime_datoteke=strcat(char(mapa),'/test_',num2str(teden),'.csv');
end