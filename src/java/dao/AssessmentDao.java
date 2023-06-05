/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Assessment;
import exceptions.AssessmentException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class AssessmentDao {

    //lấy list assessment theo syllabusID
    public static List<Assessment> readAssessmentListBySylId(String curId) throws Exception {
        String query = "select * from Assessment where syllabusID = ?";
        List<Assessment> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Assessment assessment = new Assessment();
                assessment.setId(rs.getInt("id"));
                assessment.setCategory(rs.getString("name"));
                assessment.setType(rs.getString("type"));
                assessment.setPart(rs.getInt("part"));
                assessment.setWeight(rs.getDouble("weight"));
                assessment.setCompletionCriteria(rs.getString("completionCriteria"));
                assessment.setDuration(rs.getString("duration"));
                assessment.setMapToCLO(rs.getString("CLO"));
                assessment.setQuestionType(rs.getString("questionType"));
                assessment.setNumberOfQuestion(rs.getString("numbeOfQuestion"));
                assessment.setKnowledgeScope(rs.getString("knowledgeScope"));
                assessment.setGradingGuide(rs.getString("gradingGuide"));
                assessment.setNote(rs.getString("note"));
                assessment.setSyllabusID(rs.getInt("syllabusID"));
                list.add(assessment);
            }
            con.close();
        } catch (Exception e) {
            throw new AssessmentException("Something went wrong in get assessment progress.");
        }
        return list;
    }

    public static void create(int sylID, Assessment assess, Connection con) throws Exception {
        String query = "insert into Assessment([name]\n"
                + "      ,[type]\n"
                + "      ,[part]\n"
                + "      ,[weight]\n"
                + "      ,[completionCriteria]\n"
                + "      ,[duration]\n"
                + "      ,[CLO]\n"
                + "      ,[questionType]\n"
                + "      ,[numberOfQuestion]\n"
                + "      ,[knowledgeScope]\n"
                + "      ,[gradingGuide]\n"
                + "      ,[note]\n"
                + "      ,[syllabusID]\n"
                + "      ,[status]) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setString(1, assess.getCategory());
        stm.setString(2, assess.getType());
        stm.setInt(3, assess.getPart());
        stm.setDouble(4, assess.getWeight());
        stm.setString(5, assess.getCompletionCriteria());
        stm.setString(6, assess.getDuration());
        stm.setString(7, assess.getMapToCLO());
        stm.setString(8, assess.getQuestionType());
        stm.setString(9, assess.getNumberOfQuestion());
        stm.setString(10, assess.getKnowledgeScope());
        stm.setString(11, assess.getGradingGuide());
        stm.setString(12, assess.getNote());
        stm.setInt(13, sylID);
        stm.setBoolean(14, assess.isActive());
        int affectedRows = stm.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Faild to create assessment");
        }
    }
}