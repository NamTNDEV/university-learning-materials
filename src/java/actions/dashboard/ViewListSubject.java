/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.SubjectDao;
import entities.Subject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * @author admin
 */
public class ViewListSubject implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                ArrayList<Subject> lsSubject = SubjectDao.getAll();
                request.setAttribute(AppConfig.DASHBOARD_SUBJECT_LIST, lsSubject);
                request.getRequestDispatcher("/pages/dashboard/viewListSubject.jsp").forward(request, response);
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
