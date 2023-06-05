/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.dashboard;

import actions.Action;
import actions.curriculumns.GetCurriculumnByID;
import actions.dashboard.AddNewCurriculum;
import actions.dashboard.EditCurriculum;
import actions.dashboard.GetDataFromExFile;
import actions.dashboard.GetItemsInCurriculum;
import actions.dashboard.ViewListCurriculum;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author quocb
 */
//@WebServlet(name = "CurriculumDashboard", urlPatterns = {"/dashboard/curriculums"})
public class CurriculumDashboard extends HttpServlet {

    private final Map<String, Action> actionMap = new HashMap<>();

    @Override
    public void init() {
        actionMap.put("/curriculums", new ViewListCurriculum());
        actionMap.put("/curriculums/", new ViewListCurriculum());
        actionMap.put("/curriculums/add", new AddNewCurriculum());
        actionMap.put("/curriculums/add/", new AddNewCurriculum());
        actionMap.put("/curriculums/get-excel-datas", new GetDataFromExFile());
        actionMap.put("/curriculums/get-excel-datas/", new GetDataFromExFile());
        actionMap.put("/curriculums/edit", new EditCurriculum());
        actionMap.put("/curriculums/edit/", new EditCurriculum());
        actionMap.put("/curriculums/get-items", new GetItemsInCurriculum());
        actionMap.put("/curriculums/get-items/", new GetItemsInCurriculum());
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
