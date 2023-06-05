/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.DAO;
import dao.RoleDao;
import dao.UserDao;
import entities.Role;
import entities.User;
import utils.RequestUtils;

import javax.security.auth.login.AccountException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * @author quocb
 */
public class CreateNewAccount implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("create:view form");
        try {
            DAO roleDao = new RoleDao();
            ArrayList<Role> lsRole = roleDao.getAll();
            ArrayList<String> lsEducationLevel = new ArrayList<>(Arrays.asList("FU"));
            request.setAttribute(AppConfig.DASHBOARD_ROLE_LIST, lsRole);
            request.setAttribute(AppConfig.DASHBOARD_EDUCATION_LEVEL_LIST, lsEducationLevel);
            request.getRequestDispatcher("/pages/dashboard/formAccount.jsp").forward(request, response);
        } catch (Exception e) {
            RequestUtils.notFound(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String roleID = request.getParameter("roleID");
            String educationLevel = request.getParameter("educationLevel");
            //Check Subject exist
            Boolean isExist = UserDao.isExit(username);
            if (isExist) {
                throw new AccountException("Username is exist. Try another.");
            }

            User user = new User(username, username, password, fullName, email, educationLevel, roleID);

            System.out.println("create:new account");
            Integer rows = UserDao.create(user);
            if (rows == null || rows != 1) {
                throw new AccountException("Failed to create new account. Try again");
            }
            response.sendRedirect(request.getContextPath() + "/dashboard/accounts");
        } catch (AccountException accEx) {
            accEx.printStackTrace();
            request.setAttribute(AppConfig.ERROR_MESSAGE, accEx.getMessage());
            request.getRequestDispatcher("/pages/dashboard/formAccount.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
            request.getRequestDispatcher("/pages/dashboard/formAccount.jsp").forward(request, response);
        }
    }
}
