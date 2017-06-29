run('nastavitve_program.m')

mesci=[{"Januar"; "Februar"; "Marec"; "April"; "Maj";...
 "Junij"; "Julij"; "Avgust"; "September"; "Oktober"; "November";"December"}];

teden=weeknum(datenum(leto,mesec,dan));
mapa=strcat('/home/urban/Documents/Projekti/Vreme/',num2str(leto),'/Podatki');

if strcmp(obdobje,'mesec') 
	ime_datoteke=strcat(char(mapa),'/',char(mesci(mesec)),'.csv');
elseif strcmp(obdobje,'teden') || strcmp(obdobje,'dan')
	ime_datoteke=strcat(char(mapa),'/',num2str(teden),'.csv');
end