/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import exceptions.PreRequisiteException;
import exceptions.SyllabusException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class PreRequisiteDao {

    public static List getPreRequisiteListBySubjectId(String subjectId) throws Exception {
        List<String> list = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT Subject.name as subName FROM [PreRequisite] JOIN [Subject] ON Subject.id = PreRequisite.subjectID WHERE requisiteSubjectId = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, subjectId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String s = rs.getString("subName");
                list.add(s);
            }

            con.close();
        } catch (Exception e) {
            throw new PreRequisiteException("Something went wrong in get syllabus progress.");
        }
        return list;
    }
}
