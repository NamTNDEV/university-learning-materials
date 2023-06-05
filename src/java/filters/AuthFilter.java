/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filters;

import config.AppConfig;
import entities.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

/**
 * @author quocb
 */
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String requestPath = req.getServletPath();
        HttpSession session = req.getSession();
        Boolean isLoggedIn = session != null && session.getAttribute(AppConfig.AUTH_USER) != null;

        if (!isLoggedIn && AppConfig.EXCLUDE_ROUTES.indexOf(requestPath) == -1) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (isLoggedIn && AppConfig.EXCLUDE_ROUTES.indexOf(requestPath) != -1 && !requestPath.equals("/logout")) {
            res.sendRedirect(req.getContextPath() + "/");
            return;
        }

        User user = (User) req.getSession().getAttribute(AppConfig.AUTH_USER);
        ArrayList<String> permittedPaths = (ArrayList<String>) req.getSession().getAttribute(AppConfig.AUTH_PERMITTED_PATHS);
        Boolean forceUserUpdatePassword = (Boolean) req.getSession().getAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD);
        String pathInfo = req.getRequestURI().replace(req.getContextPath(), "").trim();
        String formatedPathInfo = (pathInfo.endsWith("/") && pathInfo.length() > 1) ? pathInfo.substring(0, pathInfo.length() - 1) : pathInfo;
        if (user != null && user.getPassword() == null && (forceUserUpdatePassword)) {
            req.getSession().setAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD, true);
        }

        if (permittedPaths != null) {
            Boolean inRangePermitted = false;
            for (String path : permittedPaths) {
                String subString = path.length() > 1 && pathInfo.length() > path.length() ? pathInfo.substring(0, path.length()) : pathInfo;
                if (path.equals(subString)) {
                    inRangePermitted = true;
                }
            }

            if (AppConfig.EXCLUDE_ROUTES.indexOf(pathInfo) != -1) {
                inRangePermitted = true;
            }

            if (!formatedPathInfo.equals("/404") && !inRangePermitted) {
                System.out.println("not permit");
                res.sendRedirect(req.getContextPath() + "/404");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }

}
