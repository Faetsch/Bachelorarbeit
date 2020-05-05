import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;

public class Main
{

    public static void main(String... args) throws IOException
    {

        //substring column from to
        //bucketing column buckets
        //newcolumn column1 column2 name operator

        

        String path = args[0];
        String column1;
        String column2;
        String from;
        String to;
        String buckets;
        String name;
        String operator;
        String operation = args[1];
        String output;
        Preprocessor p = new Preprocessor();


        switch (operation)
        {
            case "substring":
                column1 = args[2];
                from = args[3];
                to = args[4];
                output = args[5];

                p.readCSV(path);
                p.processSubstringTable(Integer.parseInt(column1), Integer.parseInt(from), Integer.parseInt(to));
                p.writeCSV(output);
                break;

            case "bucketing":
                column1 = args[2];
                buckets = args[3];
                output = args[4];
                p.readCSV(path);
                p.processIntervalTable(Integer.parseInt(column1), Integer.parseInt(buckets));
                p.writeCSV(output);
                break;

            case "construct":
                column1 = args[2];
                column2 = args[3];
                operator = args[4];
                name = args[5];
                output = args[6];

                p.readCSV(path);
                int operatorInt = 0;
                switch (operator)
                {
                    case "add":
                        operatorInt = Preprocessor.SUM;
                        break;
                    case "sub":
                        operatorInt = Preprocessor.DIFFERENCE;
                        break;
                    case "mul":
                        operatorInt = Preprocessor.PRODUCT;
                        break;
                    case "div":
                        operatorInt = Preprocessor.DIVISION;
                        break;
                }

                p.constructNewColumn(name, Integer.parseInt(column1), Integer.parseInt(column2), operatorInt);
                p.writeCSV(output);

        }








//        Preprocessor p = new Preprocessor("zeitpunkt", "aussentemp", "vorlauf", "rücklauf");
//        p.readCSV("C:\\Users\\Fätsch\\IdeaProjects\\CSVPreprocessor\\src\\test\\resources\\test3");
//
//        p.constructNewColumn("Temperaturspreizung", 2, 3, Preprocessor.DIFFERENCE);
//
//        p.processSubstringTable(0, 0, 13);
//        p.processIntervalTable(1, 10);
//        p.processIntervalTable(2, 10);
//        p.processIntervalTable(3, 10);
//
//        p.writeCSV("C:\\Users\\Fätsch\\IdeaProjects\\CSVPreprocessor\\src\\test\\resources\\test3Difference");
    }
}
