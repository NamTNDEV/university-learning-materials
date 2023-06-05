/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import dao.PLODao;
import dao.PODao;
import dao.SubjectDao;
import entities.ProgramLearningObjective;
import entities.ProgramObjective;
import entities.Subject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.util.LocaleID;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.ResponseUtils;

/**
 *
 * @author Admin
 */
public class GetItemsInCurriculum implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            JSONObject resJson = new JSONObject();
            try {
                String curId = request.getParameter("curId");
                ArrayList<ProgramObjective> poList = (ArrayList<ProgramObjective>) PODao.readPOList(curId);
                ArrayList<ProgramLearningObjective> ploList = (ArrayList<ProgramLearningObjective>) PLODao.readPLOList(curId);
                List<Subject> subList = SubjectDao.getListByCurriculumID(curId);
              
                JSONArray listPoJson = new JSONArray(poList);
                JSONArray listPloJson = new JSONArray(ploList);
                JSONArray listSubJson = new JSONArray(subList);
                
                resJson.put("poList", listPoJson);
                resJson.put("ploList", listPloJson);
                resJson.put("subList", listSubJson);

                ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, resJson);
            } catch (Exception e) {
                e.printStackTrace();
                resJson.put("message", "Cannot get subject list.");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            }
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
