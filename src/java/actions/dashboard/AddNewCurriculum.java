/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package actions.dashboard;

import actions.Action;
import config.AppConfig;
import dao.CurriculumDao;
import dao.SubjectDao;
import entities.Curriculum;
import entities.Objective;
import entities.ProgramLearningObjective;
import entities.ProgramObjective;
import entities.Subject;
import exceptions.CurriculumException;
import exceptions.PLOException;
import exceptions.POException;
import exceptions.SubjectException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
//import org.apache.poi.ss.usermodel.*;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

/**
 *
 * @author quocb
 */
public class AddNewCurriculum implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                List<Subject> subjList = SubjectDao.getAll();
                request.setAttribute(AppConfig.SUBJECT_LIST, subjList);
            } catch (Exception e) {
                request.setAttribute(AppConfig.ERROR_MESSAGE, e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher(AppConfig.NOT_FOUND_PAGE).forward(request, response);
                return;
            }
            request.getRequestDispatcher("/pages/dashboard/addCurriculum.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            try {
                request.setCharacterEncoding("UTF-8");
                JSONObject json = JsonUtils.getRequestJson(request);

                String curCode = json.getString("code");
                String curName = json.getString("name");
                String curDescription = json.getString("description");
                String curDecisionNo = json.getString("decisionNo");
                String curViName = json.getString("viName");
                JSONArray poArray = json.getJSONArray("poList");
                JSONArray ploArray = json.getJSONArray("ploList");
                JSONArray subjArray = json.getJSONArray("subList");

                //check curCode exist
                if (CurriculumDao.isExist(curCode)) {
                    throw new CurriculumException("Curriculum Code already exist");
                }
                Curriculum cur = new Curriculum();
                cur.setCode(curCode);
                cur.setName(curName);
                cur.setDescription(curDescription);
                cur.setDecisionNo(curDecisionNo);
                cur.setViName(curViName);
                //convert jsonArray to list
                List<ProgramObjective> poList = jsonArrayToList(poArray, ProgramObjective.class);
                List<ProgramLearningObjective> ploList = jsonArrayToList(ploArray, ProgramLearningObjective.class);
                List<Subject> subjList = jsonArrayToList(subjArray, Subject.class);
                //tạo liên kết với po, plo...
                //thêm vào db
                CurriculumDao.add(cur, poList, ploList, subjList);
//                }
            } catch (CurriculumException | POException | PLOException | SubjectException ex) {
                ex.printStackTrace();
                JSONObject json = new JSONObject();
                json.put("message", ex.getMessage());
                ResponseUtils.sendJson(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, json);
            } catch (Exception e) {
                e.printStackTrace();
                JSONObject json = new JSONObject();
                json.put("message", e.getMessage());
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, json);
            }
        }
    }

//    public <T> List<T> jsonArrayToList(String id, JSONArray jsonArray) throws Exception {
//        List<T> list = new ArrayList<T>();
//        if (jsonArray != null) {
//            if (id.equals("subject")) {
//                for (int i = 0; i < jsonArray.length(); i++) {
//                    JSONObject json = jsonArray.getJSONObject(i);
//                    Subject obj = new Subject();
//                    obj.setId(json.getString("id"));
//                    list.add((T) obj);
//                }
//                return list;
//            }
//
//            for (int i = 0; i < jsonArray.length(); i++) {
//                JSONObject json = jsonArray.getJSONObject(i);
//                String name = json.getString("name");
//                String description = json.getString("description");
//                if (id.equals("po")) {
//                    ProgramObjective obj = new ProgramObjective();
//                    obj.setName(name);
//                    obj.setDescription(description);
//                    list.add((T) obj);
//                } else if (id.equals("plo")) {
//                    ProgramLearningObjective obj = new ProgramLearningObjective();
//                    obj.setMapToPO(json.getString("mapToPO"));
//                    obj.setName(name);
//                    obj.setDescription(description);
//                    list.add((T) obj);
//                }
//            }
//        }
//        return list;
//    }
    public <T> List<T> jsonArrayToList(JSONArray jsonArray, Class<T> clazz) throws InstantiationException, IllegalAccessException {
        List<T> list = new ArrayList<T>();
        if (jsonArray != null) {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                T obj = clazz.newInstance();
                if (obj instanceof Subject) {
                    ((Subject) obj).setId(json.getString("id"));
                } else if (obj instanceof ProgramObjective) {
                    ((ProgramObjective) obj).setName(json.getString("name"));
                    ((ProgramObjective) obj).setDescription(json.getString("description"));
                } else if (obj instanceof ProgramLearningObjective) {
                    ((ProgramLearningObjective) obj).setMapToPO(json.getString("mapToPO"));
                    ((ProgramLearningObjective) obj).setName(json.getString("name"));
                    ((ProgramLearningObjective) obj).setDescription(json.getString("description"));
                }
                list.add(obj);
            }
        }
        return list;
    }
}
