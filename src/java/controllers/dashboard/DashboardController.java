/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.dashboard;

import actions.Action;
import actions.dashboard.ViewDashboard;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.annotation.MultipartConfig;

/**
 * @author quocb
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 100, maxRequestSize = 1024 * 1024 * 200)
@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard/*"})
public class DashboardController extends HttpServlet {

    private final Map<String, HttpServlet> controllerMap = new HashMap<>();
    private final Action viewRootDashboardAction = new ViewDashboard();

    @Override
    public void init() {
        controllerMap.put("curriculums", new CurriculumDashboard());
        controllerMap.put("syllabus", new SyllabusDashboard());
        controllerMap.put("subjects", new SubjectDashboard());
        controllerMap.put("accounts", new AccountDashboard());
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("paths " + request.getPathInfo());
        String pathInfo = request.getPathInfo();
        String path = pathInfo != null ? pathInfo.split("/")[1] : "";
        HttpServlet servlet = controllerMap.get(path);

        if (servlet != null) {
            servlet.init();
            servlet.service(request, response);
        } else {
            viewRootDashboardAction.doGet(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo().split("/")[1];
        HttpServlet servlet = controllerMap.get(path);

        if (servlet != null) {
            servlet.init();
            servlet.service(request, response);
        } else {
            viewRootDashboardAction.doPost(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
