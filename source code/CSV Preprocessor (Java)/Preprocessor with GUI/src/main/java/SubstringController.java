import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.stage.FileChooser;

import java.io.File;
import java.io.IOException;

public class SubstringController
{

    @FXML
    TextField txtSubColumnName;
    @FXML TextField txtSubFrom;
    @FXML TextField txtSubTo;
    @FXML
    Button btnSubSave;

    @FXML
    public void initialize()
    {

    }
    @FXML
    public void fireBtnSubSave(ActionEvent e)
    {
        if(Controller.getPreprocessor().getHeader().size()==0 || txtSubColumnName.getText().trim().equals("") || txtSubFrom.getText().trim().equals("") || txtSubTo.getText().trim().equals("")) {
            return;
        }

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Save preprocessed file");
        File file = fileChooser.showSaveDialog(null);
        if (file != null) {
            try
            {
                int columnIndex = 0;
                int subFrom = 0;
                int subTo = 0;
                try
                {
                    subFrom = Integer.parseInt(txtSubFrom.getText().trim());
                    subTo = Integer.parseInt(txtSubTo.getText().trim());
                }
                catch(NumberFormatException e2)
                {
                    System.out.println("number exception");
                    return;
                }

                for(int i = 0; i < Controller.getPreprocessor().getHeader().size(); i++)
                {
                    if(Controller.getPreprocessor().getHeader().get(i).equals(txtSubColumnName))
                    {
                        columnIndex = i;
                    }
                    if(i == Controller.getPreprocessor().getHeader().size() && columnIndex != i)
                    {
                        return;
                    }
                }
                System.out.println(columnIndex);
                Controller.getPreprocessor().processSubstringTable(columnIndex, subFrom, subTo);
                Controller.getPreprocessor().writeCSV(file.getAbsolutePath());
            }
            catch (IOException ex)
            {
                System.out.println(ex.getMessage());
            }
        }
    }

}
