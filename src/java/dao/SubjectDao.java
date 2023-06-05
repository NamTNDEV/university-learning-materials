/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Subject;
import exceptions.SubjectException;
import utils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author giahu
 */
public class SubjectDao {

    public static Integer create(Subject subject) throws Exception {
        String query = "insert into Subject (id, name, createdAt, semester, slug, viName) values ( ?, ?, SYSDATETIME(), ?, ?, ? )";
        Connection cn = null;
        cn = DBUtils.makeConnection();
        if (cn == null) {
            throw new SubjectException("Cannot connect to Database now");
        }
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setString(1, subject.getId());
        ppstm.setString(2, subject.getName());
        ppstm.setInt(3, subject.getSemester());
        ppstm.setString(4, subject.getSlug());
        ppstm.setNString(5, subject.getViName());
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to add new Subject. Try again.");
        }

        return rows;
    }

    public static ArrayList<Subject> getAll() {
        ArrayList<Subject> result = new ArrayList<>();
        String query = "select * from Subject ORDER BY CONVERT(DATE, createdAt) desc, CONVERT(DATE, updatedAt) desc";
        try (Connection cn = DBUtils.makeConnection()) {
            Statement stm = cn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            while (rs.next()) {
                Subject subject = getSubject(rs);
                result.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        return result;
    }

    //lấy subject theo id (subject detail)
    public static Subject getOneByID(String id) throws Exception {
        String query = "select * from Subject where id = ?";
        Subject subject = null;
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                subject = getSubject(rs);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SubjectException("Something went wrong in get subject progress.");
        }
        return subject;
    }


    public static List<Subject> getListByCurriculumID(String curId) throws Exception {
        String query = "select distinct [id], [name], [createdAt], [updatedAt], [semester], [slug], [viName], [active] from Subject" +
                " join Curr_to_Subject on id = subjectID where curriculumID = ?" +
                " ORDER BY CONVERT(DATE, createdAt) desc, CONVERT(DATE, updatedAt) desc";
        List<Subject> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, curId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject subject = getSubject(rs);
                list.add(subject);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SubjectException("Something went wrong in read subject progress.");
        }
        return list;
    }

    private static Subject getSubject(ResultSet rs) throws SQLException {
        Subject subject = new Subject();
        subject.setId(rs.getString("id"));
        subject.setName(rs.getString("name"));
        subject.setViName(rs.getNString("viName"));
        subject.setCreatedAt(rs.getDate("createdAt"));
        subject.setUpdatedAt(rs.getDate("updatedAt"));
        subject.setSemester(rs.getInt("semester"));
        subject.setSlug(rs.getString("slug"));
        subject.setActive(rs.getBoolean("active"));
        return subject;
    }

    //lấy list môn theo curriculumId và khối ngành? và cả plo?
    //cần junction table giữa Subject và PLO
//    public static List<Subject> readSubjectList(String curId, String KCId) throws Exception {
//        String query = "select * from subject join ... on id = sub_id where cur_id = ? and knowlegdeCategoryID = ?";//cái nay chưa có trong db nên để tạm
//        List<Subject> list = new ArrayList<>();
//        try {
//            Connection con = DBUtils.makeConnection();
//            PreparedStatement pre = con.prepareStatement(query);
//            pre.setString(1, curId);
//            pre.setString(2, KCId);
//            ResultSet rs = pre.executeQuery();
//            while (rs.next()) {
//                Subject subject = getSubject(rs);
//                list.add(subject);
//            }
//            con.close();
//        } catch (Exception e) {
//            throw new SubjectException("Something went wrong in read subject progress.");
//        }
//
//        return list;
//    }

    public static Integer update(Subject subject) throws Exception {
        String query = "update Subject set name = ?, viName = ?, updatedAt = GETDATE(), semester = ?, slug = ?, active = ? where id = ?";
        Connection cn = null;
        cn = DBUtils.makeConnection();
        if (cn == null) throw new SubjectException("Cannot connect to Database now");
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setString(1, subject.getName());
        ppstm.setNString(2, subject.getViName());
        ppstm.setInt(3, subject.getSemester());
        ppstm.setString(4, subject.getSlug());
        ppstm.setBoolean(5, subject.getActive());
        ppstm.setString(6, subject.getId());
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to add new Subject. Try again.");
        }

        return rows;
    }

    public static Integer updateStatus(String subjectId, Boolean isActive) throws Exception {
        String query = "update Subject set active = ?, updatedAt = GETDATE() where id = ?";
        Connection cn = null;
        cn = DBUtils.makeConnection();
        if (cn == null) throw new SubjectException("Cannot connect to Database now");
        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setBoolean(1, isActive);
        ppstm.setString(2, subjectId);
        Integer rows = ppstm.executeUpdate();

        if (rows == 0) {
            throw new SubjectException("Failed to update Subject status. Try again.");
        }

        return rows;
    }

    public static void linkWithCurriculum(Connection con, int curId, String subjId) throws Exception {
        String query = "insert Curr_to_Subject values(?,?)";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setInt(1, curId);
        pre.setString(2, subjId);

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Link curriculum to Subject failed, no rows affected.");
        }
    }

    //Add new subject to db
    public static Integer add(Connection con, Subject subject) throws Exception {
        Integer id = -1;
        String query = "insert Subject values(?,?,GETDATE(),?,?,?,?)";
        PreparedStatement pre = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        pre.setString(1, subject.getId());
        pre.setString(2, subject.getName());
        pre.setString(3, null);
        pre.setInt(4, subject.getSemester());
        pre.setString(5, subject.getSlug());
        pre.setNString(6, subject.getViName());

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Add Subject failed, no rows affected.");
        }
        ResultSet generatedId = pre.getGeneratedKeys();
        if (generatedId.next()) {
            id = generatedId.getInt(1);
        } else {
            throw new SQLException("Inserting Subject failed, no ID obtained.");
        }
        return id;
    }

    //Update existing subject in db
    public static void update(Connection con, Subject subject) throws Exception {
        String query = "update Subject set name = ?, updatedAt = cast(GETDATE() as date), semester = ?, slug = ?, viName = ? where id = ?";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, subject.getName());
        pre.setInt(2, subject.getSemester());
        pre.setString(3, subject.getSlug());
        pre.setNString(4, subject.getViName());
        pre.setString(5, subject.getId());

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Update Subject failed, no rows affected.");
        }
    }

    //Delete subject
    public static void delete(Connection con, Subject subject) throws Exception {
        String query = "delete from Subject where id = ?";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, subject.getId());

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Delete Subject failed, no rows affected.");
        }
    }

    //Delete existing link in db
    public static void deleteLink(Connection con, Subject subject) throws Exception {
        String query = "delete from Curr_to_Subject where subjectId = ?";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, subject.getId());

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Delete Subject link failed, no rows affected.");
        }
    }

    public static Boolean isExist(String id) throws Exception {
        Boolean isExist = false;
        String query = "select * from Subject where id = ?";

        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                isExist = true;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

        return isExist;
    }
}