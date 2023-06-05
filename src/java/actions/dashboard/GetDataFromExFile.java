/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import entities.Subject;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.poifs.filesystem.FileMagic;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.ResponseUtils;

public class GetDataFromExFile implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONObject jsono;
        try {
            FileItem fileItem = getFileItem(request);
            jsono = readExcelFile(fileItem);
            ResponseUtils.sendJson(response, HttpServletResponse.SC_CREATED, jsono);
        } catch (Exception ex) {
            Logger.getLogger(GetDataFromExFile.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public FileItem getFileItem(HttpServletRequest request) throws Exception {
        ServletFileUpload fileUpload = new ServletFileUpload(new DiskFileItemFactory());
        List<FileItem> fileItems = fileUpload.parseRequest(request);
        for (FileItem fileItem : fileItems) {
            if (!fileItem.isFormField() && "file".equals(fileItem.getFieldName())) {
                return fileItem;
            }
        }
        throw new ServletException("File item not found.");
    }

    public boolean isValidExcelFile(InputStream input) {
        try {
            FileMagic fm = FileMagic.valueOf(input);
            return fm == FileMagic.OLE2 || fm == FileMagic.OOXML;
        } catch (IOException e) {
            // Error reading the input stream, assume invalid file
            return false;
        }
    }

    public JSONObject readExcelFile(FileItem fileItem) throws Exception {
        InputStream inp = fileItem.getInputStream();
        boolean validExcelCheck = isValidExcelFile(inp);
        Workbook wb = WorkbookFactory.create(inp);
        Sheet SubSheet = wb.getSheetAt(wb.getSheetIndex("Subject"));
        JSONObject json = new JSONObject();
        List<Subject> subList = new ArrayList<>();
        List<String> temp = null;
        int count = 0;
        
        for (Row row : SubSheet) {
            temp = new ArrayList();
            for (Cell cell : row) {
                if (cell.getCellType() == CellType.NUMERIC) {
                    temp.add(Double.toString(cell.getNumericCellValue()));
                } else {
                    temp.add(cell.getStringCellValue());
                }
            }
            if (count > 0) {
                Subject sub = new Subject();
                sub.setId(temp.get(0));
                sub.setSlug(temp.get(1));
                sub.setName(temp.get(2));
                sub.setViName(temp.get(3));
                if (temp.get(4) != null && !temp.get(4).isEmpty()) {
                    sub.setSemester((int) Double.parseDouble(temp.get(4)));
                }
                if (temp.get(5) != null && !temp.get(5).isEmpty()) {
                    String s = temp.get(5);
                    if (s.equalsIgnoreCase("1.0")) {
                        sub.setActive(true);
                    } else if (s.equalsIgnoreCase("0.0")) {
                        sub.setActive(false);
                    }
                }
                subList.add(sub);
            }
            count++;
        }

        json.put("subList", subList);

        return json;
    }
}
