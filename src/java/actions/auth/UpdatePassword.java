/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.auth;

import config.AppConfig;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import actions.Action;
import entities.User;
import utils.ResponseUtils;

/**
 *
 * @author quocb
 */
public class UpdatePassword implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            request.getRequestDispatcher("/settings/update-password.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String username = request.getParameter("userId");
        String currentPassword = request.getParameter("current-password");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        try {
            if (password.equals(confirmPassword)) {
                UserDao.updatePassword(password, username, currentPassword);
                response.setStatus(HttpServletResponse.SC_OK);
                JSONObject successJson = new JSONObject();
                User user = (User) request.getSession().getAttribute(AppConfig.AUTH_USER);
                user.setPassword(password);
                request.getSession().setAttribute(AppConfig.AUTH_USER, user);
                request.getSession().setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, false);
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject errorObject = new JSONObject();
                errorObject.put("error", "Passwords do not match.");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, errorObject);
            }
        } catch (Exception e) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("message", e.getMessage());
            ResponseUtils.sendJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, jsonResponse);
            e.printStackTrace();
        }
    }

}
