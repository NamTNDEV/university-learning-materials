/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.common;

import actions.Action;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.json.JSONObject;
import utils.ResponseUtils;

/**
 *
 * @author quocb
 */
public class UploadMaterial implements Action {

    public static String materialName = "";
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try ( PrintWriter out = response.getWriter()) {
                            JSONObject resJson = new JSONObject();
            try {
                String materialName = "";
                System.out.println("upload checked");
                Part filePart = request.getPart("material");
                System.out.println("Day la" + filePart);
                System.out.println("upload checked2");
                InputStream fileContent = filePart.getInputStream();

                System.out.println("upload checked3");
                Path fileName = Paths.get(filePart.getSubmittedFileName());
                String uploadPath = request.getServletContext().getRealPath("/db").replace("\\build\\web", "") + File.separator;
                File uploadDir = new File(uploadPath);
                System.out.println("is ext" + uploadDir.exists());
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                try ( OutputStream outputStream = new FileOutputStream(new File(uploadPath + File.separator + fileName))) {
                    while ((bytesRead = fileContent.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                }
//                filePart.write(uploadPath + File.separator + fileName);
                System.out.println("Name " + filePart.getName());
                System.out.println("Submited Name " + filePart.getSubmittedFileName());
                System.out.println("Size " + filePart.getSize());
                File tempFile = new File(filePart.getSubmittedFileName());
                if (tempFile.exists()) {
                    tempFile.delete();
                }
                System.out.println(filePart.getSubmittedFileName());
                materialName(filePart.getSubmittedFileName());
                resJson.put("message", "Save material successfully.");
                resJson.put("redirectUrl", request.getContextPath() + "/dashboard/syllabus");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, resJson);
            } catch (Exception e) {
                resJson.put("message", e.getMessage());
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
                e.printStackTrace();
            }
        }
    }
    

    public static void materialName(String name) {
        if (!name.isEmpty()) {
            materialName = name;
        }
        else{
            materialName = null;
        }
    }

}