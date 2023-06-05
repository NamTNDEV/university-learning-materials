/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author duyba
 */
public class CLOToPLOFromSylDAO {
       public static void create(int sylID, int cloID, int ploID, Connection con) throws Exception {
        String query = "insert into CLO_to_PLO_from_Syl values(?,?,?)";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setInt(1, ploID);
        stm.setInt(2, cloID);
        stm.setInt(3, sylID);
        int affectedRows = stm.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Faild to maping clo to plo from syllabus");
        }
    }
}