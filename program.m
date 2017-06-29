clear all;
close all;
format long

run('nastavitve.m')

if strcmp(obdobje,'mesec') || strcmp(obdobje,'teden') || strcmp(obdobje,'dan')
	run('grafi.m')
elseif strcmp(obdobje,'klimogram')
	run('klimogram.m')
end