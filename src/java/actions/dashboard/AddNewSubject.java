/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.SubjectDao;
import entities.Subject;
import exceptions.SubjectException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author quocb
 */
public class AddNewSubject implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/dashboard/addSubject.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String code = request.getParameter("subject.code");
                String slug = request.getParameter("subject.slug");
                String name = request.getParameter("subject.name");
                String viName = request.getParameter("subject.viName");
                String semester = request.getParameter("subject.semester");
                //Check Subject exist
                Boolean isExist = SubjectDao.isExist(code);

                if (isExist) {
                    throw new SubjectException("Subject code is exist. Try another.");
                }
                Subject subject = new Subject();
                subject.setId(code);
                subject.setSlug(slug);
                subject.setName(name);
                subject.setViName(viName);
                subject.setSemester(Integer.valueOf(semester));

                System.out.println("create:new subject");
                Integer rows = SubjectDao.create(subject);
                if (rows == null || rows != 1) {
                    throw new SubjectException("Failed to add new Subject. Try again");
                }
                response.sendRedirect(request.getContextPath() + "/dashboard/subjects");
            } catch (SubjectException subEx) {
                subEx.printStackTrace();
                request.setAttribute(AppConfig.ERROR_MESSAGE, subEx.getMessage());
                request.getRequestDispatcher("/pages/dashboard/addSubject.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                request.getRequestDispatcher("/pages/dashboard/addSubject.jsp").forward(request, response);
            }
        }
    }
}