/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.curriculumns;

import actions.Action;
import config.AppConfig;
import dao.CurriculumDao;
import dao.PLODao;
import dao.PODao;
import dao.SubjectDao;
import entities.Curriculum;
import entities.ProgramLearningObjective;
import entities.ProgramObjective;
import entities.Subject;
import exceptions.NotFoundException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author quocb
 */
public class GetCurriculumnByID implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            try {
                String curId = request.getPathInfo();
                curId = curId.replace("/", "");

                Curriculum cur = CurriculumDao.getCurriculumById(curId);

                if (cur == null) {
                    throw new NotFoundException("Curriculum is not found!");
                }

                List<ProgramObjective> poList = PODao.readPOList(curId);
                List<ProgramLearningObjective> ploList = PLODao.readPLOList(curId);
                System.out.println("PLO " + ploList);
                List<Subject> subjectList = SubjectDao.getListByCurriculumID(curId);

                request.setAttribute(AppConfig.PO_LIST, poList);
                request.setAttribute(AppConfig.PLO_LIST, ploList);
                request.setAttribute(AppConfig.SUBJECT_LIST, subjectList);
                request.setAttribute(AppConfig.CURRICULUM_ITEM, cur);
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher("/pages/not-found.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("/pages/curriculums/detail.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}