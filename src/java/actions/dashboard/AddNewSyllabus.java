/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package actions.dashboard;

import actions.Action;
import actions.common.UploadMaterial;
import config.AppConfig;
import dao.CurriculumDao;
import dao.SubjectDao;
import dao.SyllabusDao;
import entities.Assessment;
import entities.CourseLearningObjective;
import entities.Curriculum;
import entities.Material;
import entities.Question;
import entities.Session;
import entities.Subject;
import entities.Syllabus;
import exceptions.AddNewSyllabusException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

/**
 *
 * @author admin
 */
public class AddNewSyllabus implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            try {
                ArrayList<Curriculum> lsCur = (ArrayList<Curriculum>) CurriculumDao.readCurriculumFullList();
                request.setAttribute(AppConfig.DASHBOARD_CURRICULUM_LIST, lsCur);
                request.getRequestDispatcher("/pages/dashboard/addSyllabus.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.getRequestDispatcher("/pages/not-found.jsp").forward(request, response);
            }
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            JSONObject resJson = new JSONObject();
            try {
                JSONObject json = JsonUtils.getRequestJson(request);
                JSONArray sessionArray = json.getJSONArray("sessions");
                JSONArray questionArray = json.getJSONArray("questions");
                JSONArray assessmentsArray = json.getJSONArray("assessments");
                JSONArray cloArray = json.getJSONArray("list_clo");

                String subjectID = json.getString("subject");
                Integer credit = Integer.valueOf(json.getString("credit"));
                String description = json.getString("description");
                String tasks = json.getString("tasks");
                Integer scoringScale = Integer.valueOf(json.getString("maxScore"));
                Integer minScore = Integer.valueOf(json.getString("minScore"));
                boolean status = false;
                boolean active = false;
                boolean isAproved = false;
                String decisionNo = json.getString("decisionNo");
                String timeAllocation = json.getString("timeAllocation");
                String note = json.getString("note");
                String tool = json.getString("tools");
                Integer degree = Integer.valueOf(json.getString("degreeLevel"));

                String material = UploadMaterial.materialName;
                System.out.println(material);
                Material materialOj = null;
                if (material != null && !material.isEmpty()) {
                    materialOj = new Material();
                    materialOj.setName(material);
                    materialOj.setMaterialUri("db\\" + material);
                }

                List<CourseLearningObjective> listCLO = jsonArrayToCLOList(cloArray);
                List<Session> listSession = jsonArrayToSessionList(sessionArray, tasks);
                List<Question> listQuestion = jsonArrayToQuestionList(questionArray);
                List<Assessment> listAssessment = jsonArrayToAssessmentList(assessmentsArray);

                Syllabus syllabus = new Syllabus(credit, description, tasks, scoringScale, status, minScore, isAproved, subjectID,
                        decisionNo, note, timeAllocation, tool, degree, active);

                SyllabusDao.create(syllabus, listCLO, listQuestion, listSession, listAssessment, materialOj);
                resJson.put("message", "Create syllabus successfully.");
                resJson.put("redirectUrl", request.getContextPath() + "/dashboard/syllabus");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_OK, resJson);
            } catch (NumberFormatException numberError) {
                numberError.printStackTrace();
                resJson.put("message", "Invalid format.");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            } catch (AddNewSyllabusException | SQLException addErr) {
                String errorMessage = addErr.getMessage();
                System.out.println(errorMessage);
                if (errorMessage.contains("UNIQUE KEY")) {
                    errorMessage = "Syllabus is exist.";
                }
                addErr.printStackTrace();
                resJson.put("message", errorMessage);
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            } catch (IOException | JSONException e) {
                e.printStackTrace();
                resJson.put("message", "Cannot create new syllabus.");
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            } catch (Exception ex) {
                String errorMessage = ex.getMessage();
                if (errorMessage.contains("UNIQUE KEY")) {
                    errorMessage = "Syllabus are exist.";
                }
                ex.printStackTrace();
                resJson.put("message", errorMessage);
                ResponseUtils.sendJson(response, HttpServletResponse.SC_BAD_REQUEST, resJson);
            }
        }
    }

    public List<CourseLearningObjective> jsonArrayToCLOList(JSONArray jsonArray) throws Exception {
        List<CourseLearningObjective> list = new ArrayList<CourseLearningObjective>();
          if (jsonArray == null) {
            System.out.println("check null");
        }
        if (jsonArray != null) {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                CourseLearningObjective clo = new CourseLearningObjective();
                clo.setName(json.optString("name"));
                System.out.println(clo.getName());
                clo.setDescription(json.optString("description"));
                clo.setMapToPLO(Integer.parseInt(json.optString("plo")));
                list.add(clo);
            }
        }
        return list;
    }

    public List<Session> jsonArrayToSessionList(JSONArray jsonArray, String task) throws Exception {

        List<Session> list = new ArrayList<Session>();
        if (jsonArray == null) {
            System.out.println("check null");
        }
        if (jsonArray != null) {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                String topic = json.optString("topic");
                String learning_type = json.optString("learning_type");
                String lo = json.optString("lo");
                String itu = json.optString("itu");
                String material = json.optString("material");
                Integer no = Integer.parseInt(json.optString("no"));
                boolean active = Boolean.parseBoolean(json.optString("active"));
                Session session = new Session(topic, learning_type, lo, material, task, active, itu);
                session.setIndexTable(no);
                System.out.println("check active session" + active);
                list.add(session);
            }
        }
        return list;
    }

    public List<Question> jsonArrayToQuestionList(JSONArray jsonArray) throws Exception {

        List<Question> list = new ArrayList<Question>();
          if (jsonArray == null) {
            System.out.println("check null");
        }
        if (jsonArray != null) {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                String name = json.optString("name");
                String details = json.optString("details");
                boolean active = Boolean.parseBoolean(json.optString("active"));
                Integer no = Integer.parseInt(json.optString("session_no"));
                Question question = new Question();
                question.setActive(active);
                question.setDetails(details);
                question.setName(name);
                question.setSessionIndexTable(no);
                System.out.println("check active question" + active);

                list.add(question);
            }
        }
        return list;
    }

    public List<Assessment> jsonArrayToAssessmentList(JSONArray jsonArray) throws Exception {

        List<Assessment> list = new ArrayList<Assessment>();
         if (jsonArray == null) {
            System.out.println("check null");
        }
        if (jsonArray != null) {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                String category = json.optString("category");
                String type = json.optString("type");
                Integer part = Integer.parseInt(json.optString("part"));
                String weightString = json.optString("weight");
                double weight;
                weightString = weightString.replace(",", ".");
                if (weightString.endsWith("%")) {
                    weight = Double.parseDouble(weightString.substring(0, weightString.length() - 1)) / 100;
                } else {
                    weight = Double.parseDouble(weightString);
                }

                String complement_citerial = json.getString("complement_citerial");
                String duration = json.optString("duration");
                String question_type = json.optString("question_type");
                String total_question = json.optString("total_question");
                String clo = json.optString("clo", "");
                String kns = json.optString("kns");
                String grading_guide = json.optString("grading_guide");
                boolean active = Boolean.parseBoolean(json.optString("active"));
                Assessment assessment = new Assessment();
                assessment.setCategory(category);
                assessment.setType(type);
                assessment.setPart(part);
                assessment.setWeight(weight);
                assessment.setCompletionCriteria(complement_citerial);
                assessment.setDuration(duration);
                System.out.println("check clo " + clo);
                if (!clo.isEmpty() && clo != null && !clo.equals("undefined")) {
                    assessment.setMapToCLO(clo);
                }
                assessment.setQuestionType(question_type);
                assessment.setNumberOfQuestion(total_question);
                assessment.setKnowledgeScope(kns);
                assessment.setGradingGuide(grading_guide);
                assessment.setActive(active);
                System.out.println("check active assessment" + active);
                list.add(assessment);
            }
        }
        return list;
    }
}
