:- use_module(weka_wrapper).
:- use_module(library(clpfd)).

%works
csv_to_arff(Inputfile, Table_Name, Attributes) :- 
	csv_read_file(Inputfile, Rows, []),
	csv_rows_to_lists(Rows, [_|UsefulRows]),
	table_to_weka_file(Table_Name, Attributes, UsefulRows, output).

%works
csv_to_association_rules(Inputfile, Table_Name, Attributes, Parameters) :-
	csv_read_file(Inputfile, Rows, []),
	csv_rows_to_lists(Rows, [_|UsefulRows]),
	weka_association_rules_parametrized(Table_Name, Attributes, UsefulRows, Rules, Parameters).


%works
csv_rows_to_lists(Rows, Lists):-
  maplist(row_to_list, Rows, Lists).

%works
%StackOverFlow https://stackoverflow.com/questions/23183662/prolog-parsing-a-csv-file
row_to_list(Row, List):-
  Row =.. [row|List].


%%%%%%%%%% PREPROCESSING WRAPPER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


csv_process_substring(Input, Column, From, To, Output) :-
	atomic_list_concat(['java -jar /home/thebrocc/Desktop/CSVPreprocessor.jar', Input, 'substring', Column, From, To, Output], ' ' , Command),
	shell(Command).

csv_process_bucketing(Input, Column, Buckets, Output) :-
	atomic_list_concat(['java -jar /home/thebrocc/Desktop/CSVPreprocessor.jar', Input, 'bucketing', Column, Buckets, Output], ' ' , Command),
	shell(Command).

csv_process_construct(Input, Column1, Column2, Operator, Name, Output) :-
	atomic_list_concat(['java -jar /home/thebrocc/Desktop/CSVPreprocessor.jar', Input, 'construct', Column1, Column2, Operator, Name, Output], ' ' , Command),
	shell(Command).

%%%%%%%%%%% TEST RUN %%%%%%%%%%%%5

run_preprocessing_test :-
	csv_process_substring('/home/thebrocc/Desktop/test3', 0, 0, 10, '/home/thebrocc/Desktop/test3CONSOLED2'),
	csv_process_bucketing('/home/thebrocc/Desktop/test3CONSOLED2', 1, 10, '/home/thebrocc/Desktop/test3CONSOLED3').



%%%%%%%%%%%%%% RUN EXPERIMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% PREPROCESS GENERATOR %%%%%%%% 

run_preprocess_generator(Buckets) :-
	csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Generator/k1.csv', 0, 0, 15, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1first.csv'),
	csv_process_construct('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1first.csv', 2, 3, 'sub', 'spreizung', '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1second.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1second.csv', 1, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1third.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1third.csv', 2, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1fourth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1fourth.csv', 3, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1fifth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1fifth.csv', 4, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1sixth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1sixth.csv', 5, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k1preprocessed.csv'),

	csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Generator/k2.csv', 0, 0, 15, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2first.csv'),
	csv_process_construct('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2first.csv', 2, 3, 'sub', 'spreizung', '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2second.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2second.csv', 1, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2third.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2third.csv', 2, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2fourth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2fourth.csv', 3, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2fifth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2fifth.csv', 4, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2sixth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2sixth.csv', 5, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Generator/k2preprocessed.csv').

%%%% PREPROCESS HEATING %%%%%

run_preprocess_heating(Buckets) :-
	csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Heating/hk1.csv', 0, 0, 15, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1first.csv'),
	csv_process_construct('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1first.csv', 2, 3, 'sub', 'spreizung', '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1second.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1second.csv', 1, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1third.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1third.csv', 2, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1fourth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1fourth.csv', 3, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1fifth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1fifth.csv', 4, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1preprocessed.csv'),

	csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Heating/hk2.csv', 0, 0, 15, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2first.csv'),
	csv_process_construct('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2first.csv', 2, 3, 'sub', 'spreizung', '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2second.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2second.csv', 1, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2third.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2third.csv', 2, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2fourth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2fourth.csv', 3, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2fifth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2fifth.csv', 4, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk2preprocessed.csv'),

	csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Heating/hk3.csv', 0, 0, 15, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3first.csv'),
	csv_process_construct('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3first.csv', 2, 3, 'sub', 'spreizung', '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3second.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3second.csv', 1, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3third.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3third.csv', 2, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3fourth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3fourth.csv', 3, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3fifth.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3fifth.csv', 4, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk3preprocessed.csv').


%%%%%% PREPROCESS HOTWATER %%%%%%%

run_preprocess_hotwater(Buckets) :-
		csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Hotwater/ww1.csv', 0, 0, 15, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww1first.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww1first.csv', 1, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww1second.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww1second.csv', 2, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww1third.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww1third.csv', 3, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww1preprocessed.csv'),

		csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Hotwater/ww2.csv', 0, 0, 15, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww2first.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww2first.csv', 1, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww2second.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww2second.csv', 2, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww2third.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww2third.csv', 3, Buckets, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Hotwater/ww2preprocessed.csv').


run_preprocessing_all(Buckets) :-
	run_preprocess_generator(Buckets),
	run_preprocess_heating(Buckets),
	run_preprocess_hotwater(Buckets).



run_experiment_1(TableName, Bucketsize, Parameters) :-
	atomic_list_concat(['/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_', Bucketsize, 'Buckets/Heating/hk1preprocessed.csv'], '' , Path),
	csv_to_association_rules(Path, TableName, [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung] , Parameters).

run_experiment_1 :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_2Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05').

run_experiment_2 :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_5Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05').

run_experiment_3 :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_8Buckets/Heating/hk1preprocessed.csv', 'hk1',[zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05').

run_experiment_4 :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_10Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05').
	

run_experiment_time_hk1(Index) :-
	csv_process_substring('/home/thebrocc/Desktop/Heizungsdaten/Heating/hk1.csv', 0, 0, Index, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timefirst.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timefirst.csv', 1, 5, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timesecond.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timesecond.csv', 2, 5, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timethird.csv'),
	csv_process_bucketing('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timethird.csv', 3, 5, '/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timepreprocessed.csv'),
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed/Heating/hk1timepreprocessed.csv', 'hk1time', [zeitpunkt, aussentemp, vorlauf, ruecklauf], '-N 4000 -C 0.01 -I -M 0.01').
	
	
	
	
	
run_experiment_TConfidence :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_5Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05 -T 0').
	
run_experiment_TLift :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_5Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05 -T 1').
	
run_experiment_TLeverage :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_5Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05 -T 2').
	
run_experiment_TConviction :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_5Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05 -T 3').	
	
run_experiment_TSignificance :-
	csv_to_association_rules('/home/thebrocc/Desktop/Heizungsdaten/Preprocessed_20k_5Buckets/Heating/hk1preprocessed.csv', 'hk1', [zeitpunkt, aussentemp, vorlauf, ruecklauf, spreizung], '-N 4000 -C 0.01 -I -M 0.05 -S').		
	


