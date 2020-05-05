

/******************************************************************/
/***                                                            ***/
/***           Data Mining: Weka Wrapper                        ***/
/***                                                            ***/
/******************************************************************/


:- module( weka_wrapper, [
      weka_association_rules/2,
      weka_association_rules/4,
      weka_association_rules_transform/2,
      table_to_weka_file/4,
	  weka_association_rules_parametrized/3,
	  weka_association_rules_parametrized/5 ] ).


/*** interface ****************************************************/

/* weka_association_rules_parametrized(Table_Name, Rules, Parameters) <-
      */

weka_association_rules_parametrized(Table_Name, Rules, Parameters) :-
   data_mining_table_2(Table_Name, Attributes, Rows),
   weka_association_rules(Table_Name, Attributes, Rows, Rules_2, Parameters),
   weka_association_rules_transform(Rules_2, Rules),
   dwrite(xml, Rules).

weka_association_rules_parametrized(Table_Name, Attributes, Rows, Rules, Parameters) :-
   table_rows_prune_for_weka(Rows, Rows_2),
   dislog_variable_get(output_path, 'weka_input.arff', File_In),
   table_to_weka_file(Table_Name, Attributes, Rows_2, File_In),
   dislog_variable_get(output_path, 'weka_output', File_Out),
   weka_associations_file(File_In, File_Out, Parameters),
   weka_file_to_rules(File_Out, Rules),
   !.



/* weka_association_rules(Table_Name, Rules) <-
      */

weka_association_rules(Table_Name, Rules) :-
   data_mining_table_2(Table_Name, Attributes, Rows),
   weka_association_rules(Table_Name, Attributes, Rows, Rules_2),
   weka_association_rules_transform(Rules_2, Rules),
   dwrite(xml, Rules).

weka_association_rules(Table_Name, Attributes, Rows, Rules) :-
   table_rows_prune_for_weka(Rows, Rows_2),
   dislog_variable_get(output_path, 'weka_input.arff', File_In),
   table_to_weka_file(Table_Name, Attributes, Rows_2, File_In),
   dislog_variable_get(output_path, 'weka_output', File_Out),
   weka_associations_file(File_In, File_Out),
   weka_file_to_rules(File_Out, Rules),
   !.


/* weka_association_rules_transform(Rules_1, Rules_2) <-
      */

weka_association_rules_transform(Rules_1, Rules_2) :-
   fn_item_parse(Rules_1, rules:[]:Rs_1),
   maplist( weka_association_rule_transform,
      Rs_1, Rs_2),
   Rules_2 = rules:Rs_2,
   !.

weka_association_rule_transform(Rule_1, Rule_2) :-
   fn_item_parse(Rule_1, rule:[]:[Number|Es]),
   fn_item_parse(Number, number:[]:[N]),
   Rule_2 = rule:[number:N]:Es.


/*** implementation ***********************************************/

/* weka_associations_file_parametrized(File_In, File_Out, Parameters) <-
      */

weka_associations_file(File_In, File_Out, Parameters) :-
	concat([ 'cp ', File_In,
      ' /home/thebrocc/Weka/data/weka_input.arff' ],
      Cp_Command_1),
   writeln(user, Cp_Command_1),
   us(Cp_Command_1),
   concat([ 'cd /home/thebrocc/Weka; ',
      'java -cp ./weka-3_6_0.jar weka.associations.Apriori -t data/weka_input.arff ', Parameters, ' > data/weka_output' ],
      Command),
   writeln(user, Command),
   us(Command),
   concat([ 'cp',
      ' /home/thebrocc/Weka/data/weka_output ',
      File_Out ], Cp_Command_2),
   writeln(user, Cp_Command_2),
   us(Cp_Command_2).





/* weka_associations_file(File_In, File_Out) <-
      */

weka_associations_file(File_In, File_Out) :-
	concat([ 'cp ', File_In,
      ' /home/thebrocc/Weka/data/weka_input.arff' ],
      Cp_Command_1),
   writeln(user, Cp_Command_1),
   us(Cp_Command_1),
   concat([ 'cd /home/thebrocc/Weka; ',
      'java -cp ./weka-3_6_0.jar weka.associations.Apriori -t ',
      'data/weka_input.arff -N 4000 -C 0.1 > data/weka_output' ],
      Command),
   writeln(user, Command),
   us(Command),
   concat([ 'cp',
      ' /home/thebrocc/Weka/data/weka_output ',
      File_Out ], Cp_Command_2),
   writeln(user, Cp_Command_2),
   us(Cp_Command_2).

/* table_to_weka_file(Table_Name, Attributes, Rows, File) <-
      */

table_to_weka_file(Table_Name, Attributes, Rows, File) :-
   writeln(File),
   findall( A-Vs,
      ( nth(N, Attributes, A),
        setof( V,
           Row^( member(Row, Rows),
             nth(N, Row, V) ),
           Vs ) ),
      Pairs ),
   writeln(Pairs),
   predicate_to_file( File,
      ( write('@relation '),
        writeq(Table_Name),
        writeln('.symbolic'), nl,
        ( foreach(A-Vs, Pairs) do
             write('@attribute '),
             writeq(A), write(' {'),
             writeq_list_with_comma(Vs),
             writeln('}') ),
        nl,
        writeln('@data'),
        ( foreach(Row, Rows) do
             writeq_list_with_comma(Row), nl ) ) ),
		writeln('hallo').


table_rows_prune_for_weka(Rows_1, Rows_2) :-
   maplist( table_row_prune_for_weka,
      Rows_1, Rows_2 ).

table_row_prune_for_weka(Row_1, Row_2) :-
   foreach(V1, Row_1), foreach(V2, Row_2) do
      name_exchange_sublist([
         [">= ", "greater_equal_"], 
         ["< ", "smaller_"],
         [" ", "_"] ], V1, V2).


/******************************************************************/


