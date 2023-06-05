/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entities.Question;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author duyba
 */
public class QuestionDAO {

    public static void create(int sessionID, Question question, Connection con) throws Exception {
        String query = "insert into Questions([name]\n"
                + "      ,[details]\n"
                + "      ,[sessionID]\n"
                + "      ,[status]) values(?,?,?,?)";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setString(1, question.getName());
        stm.setString(2, question.getDetails());
        stm.setInt(3, sessionID);
        stm.setBoolean(4, question.isActive());
        int affectedRows = stm.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Faild to create question");
        }
    }
}