import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Controller
{

    @FXML TextField txtLoad;
    @FXML Button btnLoad;
    @FXML Button btnBinning;
    @FXML Button btnSubstringing;
    @FXML TableView tableCSVContent;





    public static Preprocessor preprocessor = new Preprocessor();

    public Controller()
    {
    }

    public void initialize()
    {
    }

    public static Preprocessor getPreprocessor()
    {
        return preprocessor;
    }

    @FXML
    public void fireOpenFileChooser(ActionEvent event)
    {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Open File");
        File f = fileChooser.showOpenDialog(null);
        String path = f.getAbsolutePath();
        fireLoadCSVFile(path);
        txtLoad.setText(path);
    }

    @FXML
    public void fireBtnBinning(ActionEvent e)
    {
        if(preprocessor.getHeader().size()==0)
        {
            return;
        }
        Stage binStage = new Stage();
        Parent root = null;
        try {
            root = FXMLLoader.load(getClass().getResource("binning.fxml"));
        } catch (IOException ioException) {
            ioException.printStackTrace();
        }
        binStage.setTitle("Binning Stage");
        binStage.setScene(new Scene(root, 300, 300));
        binStage.show();
    }

    @FXML
    public void fireBtnConstructing(ActionEvent e)
    {
        if(preprocessor.getHeader().isEmpty())
        {
            return;
        }
        Stage binStage = new Stage();

        Parent root = null;
        try {
            root = FXMLLoader.load(getClass().getResource("constructing.fxml"));
        } catch (IOException ioException) {
            ioException.printStackTrace();
        }
        binStage.setTitle("Constructing new Column Stage");
        binStage.setScene(new Scene(root, 300, 300));
        binStage.show();
    }

    @FXML
    public void fireBtnSubstringing(ActionEvent e)
    {
        if(preprocessor.getHeader().isEmpty())
        {
            return;
        }

        Stage binStage = new Stage();
        Parent root = null;
        try {
            root = FXMLLoader.load(getClass().getResource("substringing.fxml"));
        } catch (IOException ioException) {
            ioException.printStackTrace();
        }
        binStage.setTitle("Substringing Stage");
        binStage.setScene(new Scene(root, 300, 300));
        binStage.show();
    }




    public void fireLoadCSVFile(String path)
    {
        tableCSVContent.getColumns().clear();
        tableCSVContent.getItems().clear();
        try
        {
//            preprocessor.readCSV("/home/thebrocc/Desktop/Heizungsdaten/Generator/k1.csv");
            preprocessor.readCSV(path);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        List<String> headerStrings = preprocessor.getHeader();
        for(int i = 0; i < headerStrings.size(); i++)
        {
            TableColumn currentColumn = new TableColumn(headerStrings.get(i));

            int finalI = i;
            currentColumn.setCellValueFactory((Callback<TableColumn.CellDataFeatures<ArrayList<String>, String>, ObservableValue<String>>) p -> {
                ArrayList<String> x = p.getValue();
                if (x != null && x.size()>0) {
                    return new SimpleStringProperty(x.get(finalI));
                } else {
                    return new SimpleStringProperty("<no value>");
                }
            });

            tableCSVContent.getColumns().add(currentColumn);
        }
        ArrayList<ArrayList<String>> table = preprocessor.getTable();
        for(ArrayList<String> row : table)
        {
            tableCSVContent.getItems().add(row);
        }
    }

}
