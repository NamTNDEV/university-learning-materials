/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package actions;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author quocb
 */
public interface Action {

    void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException;
}
