/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.dashboard;

import actions.Action;
import actions.dashboard.AddNewSubject;
import actions.dashboard.EditSubject;
import actions.dashboard.UpdateSubjectStatus;
import actions.dashboard.ViewListSubject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author admin
 */
@WebServlet(name = "SubjectDashboard", urlPatterns = {"/subjects"})
public class SubjectDashboard extends HttpServlet {

    private final Map<String, Action> actionMap = new HashMap<>();

    @Override
    public void init() {
        actionMap.put("/subjects", new ViewListSubject());
        actionMap.put("/subjects/", new ViewListSubject());
        actionMap.put("/subjects/add", new AddNewSubject());
        actionMap.put("/subjects/edit", new EditSubject());
        actionMap.put("/subjects/update-status", new UpdateSubjectStatus());

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

    // <editor-fold default-state="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

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
        Action action = actionMap.get(request.getPathInfo().trim());
        if (action != null) {
            action.doGet(request, response);
        } else {
            // Handle error if the path is not supported
            System.out.println("Not found action");
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
        Action action = actionMap.get(request.getPathInfo());
        if (action != null) {
            action.doPost(request, response);
        } else {
            // Handle error if the path is not supported
            System.out.println("Not found action");
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
