/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.syllabus;

import actions.Action;
import config.AppConfig;
import dao.CLODao;
import dao.MaterialDao;
import dao.PreRequisiteDao;
import dao.SessionDao;
import dao.SyllabusDao;
import entities.CourseLearningObjective;
import entities.Material;
import entities.Session;
import entities.Syllabus;
import exceptions.NotFoundException;
import exceptions.SyllabusException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class GetSyllabusByID implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            try {
                String sylId = request.getPathInfo();
                sylId = sylId.replace("/", "");

                Syllabus syl = SyllabusDao.getSyllabusById(sylId);
                
                if (syl == null) throw new SyllabusException("Syllabus is not found.");
                
                List<String> preRequisiteSubNameList = PreRequisiteDao.getPreRequisiteListBySubjectId(syl.getSubjectID());
                List<CourseLearningObjective> cloList = CLODao.readCourseLearningObjectiveListBySylId(sylId);
                List<Material> mtList = MaterialDao.readMaterialListBySylId(sylId);
                List<Session> ssList = SessionDao.readSessionListBySylId(sylId);
                
                //Xu li PreRequisite
                String preRequisiteNotifi = "Recommended to have knowledge of";
                int count = 0;
                for(String preRequisiteSubName : preRequisiteSubNameList){
                    if(count == 0){
                        preRequisiteNotifi += " " + preRequisiteSubName;
                        count++;
                    } else {
                        preRequisiteNotifi += ", " + preRequisiteSubName;
                    }
                }
                
                if (syl == null) {
                    throw new NotFoundException("Syllabus is not found!");
                }
                
                request.setAttribute(AppConfig.MATERIALS_LIST, mtList);
                request.setAttribute(AppConfig.SESSION_LIST, ssList);
                request.setAttribute(AppConfig.CLO_LIST, cloList);
                request.setAttribute(AppConfig.REQUISITE_ITEM, preRequisiteNotifi);
                request.setAttribute(AppConfig.SYLLABUS_ITEM, syl);
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher("/pages/not-found.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("/pages/syllabus/detail.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}