import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.TextField;
import javafx.stage.FileChooser;

import java.io.File;
import java.io.IOException;

public class ConstructController
{

    @FXML
    TextField txtConstructColumn1;
    @FXML TextField txtConstructColumn2;
    @FXML TextField txtConstructNewColumn;
    @FXML
    Button btnConstructSave;
    @FXML
    ChoiceBox choiceConstructOp;

    @FXML
    public void initialize()
    {

    }

    @FXML
    public void fireBtnConstructSave(ActionEvent e)
    {
        if(Controller.getPreprocessor().getHeader().isEmpty()|| txtConstructColumn1.getText().trim().equals("") || txtConstructColumn2.getText().trim().equals("")) {
            System.out.println(Controller.getPreprocessor().getHeader().size());
            return;
        }

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Save preprocessed file");
        File file = fileChooser.showSaveDialog(null);
        if (file != null) {
            try
            {
                System.out.println(file.getAbsolutePath());
                int columnIndex1 = 0;
                int columnIndex2 = 0;
                String newColumnName = txtConstructNewColumn.getText();
                int operator = choiceConstructOp.getSelectionModel().getSelectedIndex();
                try
                {
                    columnIndex1 = Integer.parseInt(txtConstructColumn1.getText());
                    columnIndex2 = Integer.parseInt(txtConstructColumn2.getText());
                }
                catch(NumberFormatException e2)
                {
                    return;
                }

                for(int i = 0; i < Controller.getPreprocessor().getHeader().size(); i++)
                {
                    if(Controller.getPreprocessor().getHeader().get(i).equals(txtConstructColumn1));
                    {
                        columnIndex1 = i;
                    }
                    if(i == Controller.getPreprocessor().getHeader().size() && columnIndex1 != i)
                    {
                        return;
                    }
                }
                for(int i = 0; i < Controller.getPreprocessor().getHeader().size(); i++)
                {
                    if(Controller.getPreprocessor().getHeader().get(i).equals(txtConstructColumn2))
                    {
                        columnIndex2 = i;
                    }
                    if(i == Controller.getPreprocessor().getHeader().size() && columnIndex2 != i)
                    {
                        return;
                    }
                }
                System.out.println("und hier");
                Controller.getPreprocessor().constructNewColumn(newColumnName, columnIndex1, columnIndex2, operator);
                System.out.println(file.getAbsolutePath());
                Controller.getPreprocessor().writeCSV(file.getAbsolutePath());
            }
            catch (IOException ex)
            {
                System.out.println(ex.getMessage());
            }
        }
    }
}
