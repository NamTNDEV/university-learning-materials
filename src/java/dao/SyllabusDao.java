/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import config.AppConfig;
import entities.Assessment;
import entities.CourseLearningObjective;
import entities.Material;
import entities.Question;
import entities.SearchResult;
import entities.Session;
import entities.Syllabus;
import exceptions.AddNewSyllabusException;
import exceptions.AssessmentException;
import exceptions.CLOException;
import exceptions.QuestionExceptions;
import exceptions.SessionException;
import exceptions.SyllabusException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class SyllabusDao {

    public static void create(Syllabus syllabus, List<CourseLearningObjective> listCLO,
            List<Question> listQuestion, List<Session> listSession, List<Assessment> listAssessment, Material material)
            throws AddNewSyllabusException, SQLException, Exception {

        PreparedStatement ppstm = null;
        Connection con = null;
        try {
            con = DBUtils.makeConnection();
            con.setAutoCommit(false);

            if (listCLO.isEmpty()) {
                throw new CLOException("Atleast one CLO should be added");
            }
            if (listSession.isEmpty()) {
                throw new SessionException("Atleast one Session should be added");
            }
            if (listQuestion.isEmpty()) {
                throw new QuestionExceptions("Atleast one Question should be added");
            }
            if (listAssessment.isEmpty()) {
                throw new AssessmentException("Atleast one Assessment should be added");
            }

            // Insert syllabus
            String query = "INSERT INTO Syllabus "
                    + "(subjectID, credit, [description], tasks, scoringScale, [status], minScore, isApproved, createdAt, decisionNo, note, timeAllocation, tools, degreeLevelID) "
                    + "values(?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, ?, ?, ?, ?)";

            ppstm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ppstm.setString(1, syllabus.getSubjectID());
            ppstm.setInt(2, syllabus.getCredit());
            ppstm.setString(3, syllabus.getDescription());
            ppstm.setString(4, syllabus.getTasks());
            ppstm.setInt(5, syllabus.getScoringScale());
            ppstm.setBoolean(6, syllabus.isStatus());
            ppstm.setInt(7, syllabus.getMinScore());
            ppstm.setBoolean(8, syllabus.isIsApproved());
            ppstm.setString(9, syllabus.getDecisionNo());
            ppstm.setString(10, syllabus.getNote());
            ppstm.setString(11, syllabus.getTimeAllocation());
            ppstm.setString(12, syllabus.getTool());
            ppstm.setInt(13, syllabus.getDegreeLevelID());

            int affectedRows = ppstm.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating syllabus failed, no rows affected.");
            }

            // Get the id of the inserted syllabus
            ResultSet generatedKeys = ppstm.getGeneratedKeys();
            generatedKeys.next();
            int syllabusId = generatedKeys.getInt(1);

            // Insert clo and mapting to plo form syl
            for (CourseLearningObjective clo : listCLO) {
                int ploID = clo.getMapToPLO();
                int cloId = CLODao.create(syllabusId, clo, con);
                CLOToPLOFromSylDAO.create(syllabusId, cloId, ploID, con);
            }

            // Insert session and maping to question
            for (Session session : listSession) {
                int no = session.getIndexTable();
                int sessionID = SessionDao.create(syllabusId, session, con);
                for (Question question : listQuestion) {
                    if (no == question.getSessionIndexTable()) {
                        QuestionDAO.create(sessionID, question, con);
                    }
                }
            }

            for (Assessment assessment : listAssessment) {

                AssessmentDao.create(syllabusId, assessment, con);

            }

            if (material != null) {
                MaterialDao.create(syllabusId, material, con);
            }

            con.commit();
        } catch (Exception e) {
            con.rollback();
            throw e;
        } finally {
            if (ppstm != null || con != null) {
                ppstm.close();
                con.close();
            }
//            con.setAutoCommit(true);
        }

    }

    //lấy syllabus theo id(syllabus detail)
    public static Syllabus getSyllabusById(String id) throws Exception {
        Syllabus syllabus = null;
        try {
            String query = "select Syl.id, Syl.subjectID, S.name, S.semester, S.slug, Syl.credit, Syl.[description], Syl.[tasks], Syl.scoringScale, Syl.[status], Syl.minScore, Syl.createdAt, Syl.updatedAt, Syl.isApproved from Syllabus as Syl inner join Subject as S on Syl.subjectID = S.id where Syl.id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));//thiếu cột name trong tbl Syllabus
                syllabus.setCredit(rs.getInt("credit"));
                syllabus.setDescription(rs.getString("description"));
                syllabus.setTasks(rs.getString("tasks"));
                syllabus.setScoringScale(rs.getInt("scoringScale"));
                syllabus.setStatus(rs.getBoolean("status"));
                syllabus.setMinScore(rs.getInt("minScore"));
                syllabus.setCreatedAt(rs.getString("createdAt"));
                syllabus.setUpdatedAt(rs.getString("updatedAt"));
                syllabus.setIsApproved(rs.getBoolean("isApproved"));
                syllabus.setSubjectID(rs.getString("subjectID"));
            }

            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return syllabus;
    }

    //lấy list syllabus theo subject code(search by code)
    public static List<Syllabus> readSyllabusListByCode(String code) throws Exception {
        String query = "select * from Syllabus where subjectID like ?";
        List<Syllabus> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + code + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Syllabus syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));
                syllabus.setCredit(rs.getInt("credit"));
                syllabus.setDescription(rs.getString("description"));
                syllabus.setTasks(rs.getString("tasks"));
                syllabus.setScoringScale(rs.getInt("scoringScale"));
                syllabus.setStatus(rs.getBoolean("stastus"));
                syllabus.setMinScore(rs.getInt("minScore"));
                syllabus.setCreatedAt(rs.getString("createdAt"));
                syllabus.setUpdatedAt(rs.getString("updatedAt"));
                syllabus.setIsApproved(rs.getBoolean("isApproved"));
                syllabus.setSubjectID(rs.getString("subjectID"));
                list.add(syllabus);
            }
            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in read syllabus progress.");
        }
        return list;
    }

    //lấy list syllabus theo subject name(search by name)
    public static List<Syllabus> readSyllabusListByName(String name) throws Exception {
        String query = "select syl.id, syl.name, syl.credit, syl.description, syl.tasks, syl.scoringScale, syl.status, syl.minScore, syl.createdAt, syl.updatedAt, syl.isApproved, syl.subjectID from Syllabus syl join Subject sub on syl.subjectID = sub.id where sub.name like ?";
        List<Syllabus> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Syllabus syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));
                syllabus.setCredit(rs.getInt("credit"));
                syllabus.setDescription(rs.getString("description"));
                syllabus.setTasks(rs.getString("tasks"));
                syllabus.setScoringScale(rs.getInt("scoringScale"));
                syllabus.setStatus(rs.getBoolean("stastus"));
                syllabus.setMinScore(rs.getInt("minScore"));
                syllabus.setCreatedAt(rs.getString("createdAt"));
                syllabus.setUpdatedAt(rs.getString("updatedAt"));
                syllabus.setIsApproved(rs.getBoolean("isApproved"));
                syllabus.setSubjectID(rs.getString("subjectID"));
                list.add(syllabus);
            }
            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return list;
    }

    //lấy list syllabus đầy đủ
    public static ArrayList<Syllabus> readSyllabusFullList() throws Exception {
        String query = "select Syl.id, Syl.subjectID, S.name, S.semester, S.slug, Syl.credit, Syl.[description], Syl.[tasks], Syl.scoringScale, Syl.[status], Syl.minScore, Syl.createdAt, Syl.updatedAt, Syl.isApproved from Syllabus as Syl inner join Subject as S on Syl.subjectID = S.id";
        ArrayList<Syllabus> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Syllabus syllabus = new Syllabus();
                syllabus.setId(rs.getInt("id"));
                syllabus.setName(rs.getString("name"));//thiếu cột name trong tbl Syllabus
                syllabus.setCredit(rs.getInt("credit"));
                syllabus.setDescription(rs.getString("description"));
                syllabus.setTasks(rs.getString("tasks"));
                syllabus.setScoringScale(rs.getInt("scoringScale"));
                syllabus.setStatus(rs.getBoolean("status"));
                syllabus.setMinScore(rs.getInt("minScore"));
                syllabus.setCreatedAt(rs.getString("createdAt"));
                syllabus.setUpdatedAt(rs.getString("updatedAt"));
                syllabus.setIsApproved(rs.getBoolean("isApproved"));
                syllabus.setSubjectID(rs.getString("subjectID"));
                list.add(syllabus);
            }
            con.close();
        } catch (Exception e) {
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return list;
    }

    public static List<SearchResult> searchBySubId(String subjectID) throws Exception {
        System.out.println(subjectID);
        String query = "select * from Syllabus where subjectID like ?";
        List<SearchResult> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + subjectID + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                SearchResult searchResult = new SearchResult();
                searchResult.setId(rs.getInt("id"));
                System.out.println("id sy" + rs.getInt("id"));
                // name trong syllus de trong
                searchResult.setName(rs.getString("subjectID"));
                searchResult.setSlug(String.valueOf(rs.getInt("id")));
                searchResult.setRoot_slug(AppConfig.SYLLABUS_ROOT_SLUG);
                list.add(searchResult);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new SyllabusException("Something went wrong in get syllabus progress.");
        }
        return list;
    }
}
