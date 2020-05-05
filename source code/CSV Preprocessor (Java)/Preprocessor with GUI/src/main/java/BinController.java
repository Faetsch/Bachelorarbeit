import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.stage.FileChooser;

import java.io.File;
import java.io.IOException;

public class BinController
{

    @FXML
    Button btnBinSave;
    @FXML
    TextField txtColumnName;
    @FXML TextField txtBinAmount;



    @FXML
    public void initialize()
    {

    }
    @FXML
    public void fireBtnBinSave(ActionEvent event)
    {
        if(Controller.getPreprocessor().getHeader().isEmpty() && txtBinAmount.getText().trim().equals("") && txtColumnName.getText().trim().equals("")) {
            return;
        }

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Save preprocessed file");
        File file = fileChooser.showSaveDialog(null);
        if (file != null) {
            try
            {
                int columnIndex = 0;
                int binAmount = 0;
                try
                {
                    binAmount = Integer.parseInt(txtBinAmount.getText());
                }
                catch(NumberFormatException e)
                {
                    return;
                }

                for(int i = 0; i < Controller.getPreprocessor().getHeader().size(); i++)
                {
                    if(Controller.getPreprocessor().getHeader().get(i).equals(txtColumnName))
                    {
                        columnIndex = i;
                    }
                    if(i == Controller.getPreprocessor().getHeader().size() && columnIndex != i)
                    {
                        return;
                    }
                }
                Controller.getPreprocessor().processIntervalTable(columnIndex, binAmount);
                Controller.getPreprocessor().writeCSV(file.getAbsolutePath());
            }
            catch (IOException ex)
            {
                System.out.println(ex.getMessage());
            }
        }
    }
}
