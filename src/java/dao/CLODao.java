/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.CourseLearningObjective;
import exceptions.CLOException;
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
public class CLODao {

    //lấy list clo theo syllabusID
    public static List<CourseLearningObjective> readCourseLearningObjectiveListBySylId(String curId) throws Exception {
        String query = "select * from Course_Learning_Objective where syllabusID = ?";
        List<CourseLearningObjective> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                CourseLearningObjective clo = new CourseLearningObjective();
                clo.setId(rs.getInt("id"));
                clo.setName(rs.getString("name"));
                clo.setDescription(rs.getString("description"));
                clo.setSyllabusID(rs.getInt("syllabusID"));
                clo.setCreatedAt(rs.getString("createdAt"));
                clo.setUpdatedAt(rs.getString("updatedAt"));
                list.add(clo);
            }
            con.close();
        } catch (Exception e) {
            throw new CLOException("Something went wrong in get clo progress.");
        }
        return list;
    }

//    SELECT TOP (1000) [id]
//      ,[name]
//      ,[description]
//      ,[syllabusID]
//      ,[createdAt]
//      ,[updatedAt]
//  FROM [dbo].[Course_Learning_Objective]
    public static int create(int sylID, CourseLearningObjective clo, Connection con) throws Exception {
        String query = "INSERT INTO Course_Learning_Objective (name, description, syllabusID, createdAt) VALUES (?, ?, ?, GETDATE())";
        PreparedStatement stm = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        stm.setString(1, clo.getName());
        stm.setString(2, clo.getDescription());
        stm.setInt(3, sylID);
        int affectedRows = stm.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Faild to create CLO");
        }
        ResultSet rs = stm.getGeneratedKeys();
        if (rs.next()) {
            int cloId = rs.getInt(1);
            return cloId;
        }
        else{
            throw new SQLException("Creating CLO failed, no ID obtained.");
        }
    }
}