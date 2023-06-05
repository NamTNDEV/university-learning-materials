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
public class EditAccount implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            User user = UserDao.getUserById(id);
            if (user == null) throw new AccountException("Account is not found.");
            request.setAttribute(AppConfig.DASHBOARD_ACCOUNT, user);
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
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String roleID = request.getParameter("roleID");
            String educationLevel = request.getParameter("educationLevel");
            User user = new User(username, fullName, email, educationLevel, roleID);
            System.out.println("update:exist account");
            Integer rows = UserDao.update(user);
            System.out.println(rows);
            if (rows == null || rows == -1 || rows == 0) {
                throw new Exception("Failed to update account. Try again");
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
