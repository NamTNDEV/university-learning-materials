/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.SyllabusDao;
import entities.Syllabus;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class ViewListSyllabus implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            try {
                ArrayList<Syllabus> lsSyllabus = SyllabusDao.readSyllabusFullList();
                request.setAttribute(AppConfig.DASHBOARD_SYLLABUS_LIST, lsSyllabus);
                request.getRequestDispatcher("/pages/dashboard/viewSyllabus.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.getRequestDispatcher("/pages/not-found.jsp").forward(request, response);
            }
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
