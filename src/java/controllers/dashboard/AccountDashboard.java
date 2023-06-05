/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.dashboard;

import actions.Action;
import actions.dashboard.CreateNewAccount;
import actions.dashboard.EditAccount;
import actions.dashboard.ViewListAccount;

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
@WebServlet(name = "AccountDashboard", urlPatterns = {"/accounts"})
public class AccountDashboard extends HttpServlet {

    private final Map<String, Action> actionMap = new HashMap<>();

    @Override
    public void init() {
        actionMap.put("/accounts", new ViewListAccount());
        actionMap.put("/accounts/create", new CreateNewAccount());
        actionMap.put("/accounts/edit", new EditAccount());
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
