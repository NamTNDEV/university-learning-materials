/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Session;
import exceptions.SessionException;
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
public class SessionDao {

    //lấy list session theo syllabusID
    public static List<Session> readSessionListBySylId(String sylId) throws Exception {
        String query = "select * from Session where syllabusID = ?";
        List<Session> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, sylId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Session session = new Session();
                session.setId(rs.getInt("id"));
                session.setTopic(rs.getString("topic"));
                session.setLearningType(rs.getString("learningType"));
                session.setLO_ID(rs.getString("LO_ID"));
                session.setMaterials(rs.getString("materials"));
                session.setStudentTasks(rs.getString("studentTasks"));
                session.setSyllabusID(rs.getInt("syllabusID"));
                list.add(session);
            }
            con.close();
        } catch (Exception e) {
            throw new SessionException("Something went wrong in get session progress.");
        }
        return list;
    }

//    
//          ,[topic]
//      ,[learningType]
//      ,[LO_ID]
//      ,[materials]
//      ,[studentTasks]
//      ,[syllabusID]
//      ,[status]
//      ,[itu]
    public static int create(int sylId, Session session, Connection con) throws Exception {
        String query = "insert into Session ([topic]\n"
                + "      ,[learningType]\n"
                + "      ,[LO_ID]\n"
                + "      ,[materials]\n"
                + "      ,[studentTasks]\n"
                + "      ,[syllabusID]\n"
                + "      ,[status]\n"
                + "      ,[itu]) values(?,?,?,?,?,?,?,?)";
        PreparedStatement stm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        stm.setString(1, session.getTopic());
        stm.setString(2, session.getLearningType());
        stm.setString(3, session.getLO_ID());
        stm.setString(4, session.getMaterials());
        stm.setString(5, session.getStudentTasks());
        stm.setInt(6, sylId);
        stm.setBoolean(7, session.isActive());
        stm.setString(8, session.getItu());

        int affectedRows = stm.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Faild to create session");
        }

        ResultSet rs = stm.getGeneratedKeys();
        if (rs.next()) {
            int sessionID = rs.getInt(1);
            return sessionID;
        } else {
            throw new SQLException("Creating Session failed, no ID obtained.");
        }
    }
}