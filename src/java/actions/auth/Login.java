/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions.auth;

import actions.Action;
import config.AppConfig;
import dao.PermissionDao;
import dao.UserDao;
import entities.User;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * @author Admin
 */
public class Login implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            request.getRequestDispatcher("/pages/login_step_1.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            JSONObject json = JsonUtils.getRequestJson(request);
            String username = json.getString("studentID");
            Integer step = json.getInt("step");
            User user = UserDao.getUserById(username);
            JSONObject jsonResponse = new JSONObject();
            if (user != null) {
                switch (step) {
                    case 1: {
                        if (user.getPassword() == null) {
                            request.getSession().setAttribute(AppConfig.AUTH_USER, user);
                            request.getSession().setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, true);
                            jsonResponse.put("redirectUrl", request.getContextPath() + "/");
                        } else {
                            jsonResponse.put("step", 2);
                        }
                        ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, jsonResponse);

                        break;
                    }
                    case 2: {
                        String password = json.getString("password");
                        if (password != null && password.equals(user.getPassword())) {
                            ArrayList<String> permittedPaths = PermissionDao.getByRoleId(user.getRoleID());
                            request.getSession().setAttribute(AppConfig.AUTH_PERMITTED_PATHS, permittedPaths);
                            request.getSession().setAttribute(AppConfig.AUTH_USER, user);
                            if (user.getRoleID().equals("ADM")) {
                                jsonResponse.put("redirectUrl", request.getContextPath() + "/dashboard");
                            } else {
                                jsonResponse.put("redirectUrl", request.getContextPath() + "/");
                                System.out.println(request.getContextPath());
                            }
                            ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, jsonResponse);
                        } else {
                            jsonResponse.put("message", "Invalid ID or password");
                            ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, jsonResponse);
                        }
                        break;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error");
            e.printStackTrace();
        }
    }
}
