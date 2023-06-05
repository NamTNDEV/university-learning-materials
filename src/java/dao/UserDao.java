/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.User;
import exceptions.RoleException;
import exceptions.WrongPasswordException;
import utils.DBUtils;

import javax.security.auth.login.AccountException;
import java.sql.*;
import java.util.ArrayList;

/**
 * @author Admin
 */
public class UserDao {
    public static Integer create(User user) throws Exception {
        String query = "insert into [User] (id, username, [password], fullName, email, roleID, educationLevel)" +
                " values (?, ?, ?, ?, ?, ?, ?)";
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                PreparedStatement ppstm = cn.prepareStatement(query);
                ppstm.setString(1, user.getId());
                ppstm.setString(2, user.getUsername());
                ppstm.setString(3, user.getPassword());
                ppstm.setNString(4, user.getFullName());
                ppstm.setString(5, user.getEmail());
                ppstm.setString(6, user.getRoleID());
                ppstm.setString(7, user.getEducationLevel());
                Integer rows = ppstm.executeUpdate();
                return rows;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Something went wrong when create new account");
        }

        return -1;
    }

    public static User getUserById(String id) throws Exception {
        String query = "select id, username, password, fullname, email, educationlevel, roleid from [User] where id = ?";
        User user = null;
        Connection con = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                PreparedStatement pre = con.prepareStatement(query);
                pre.setString(1, id);
                ResultSet rs = pre.executeQuery();
                while (rs.next()) {
                    user = new User();
                    getUser(rs, user);
                }
                con.close();
            }
        } catch (Exception e) {
            System.out.println("Cannot get User");
            e.printStackTrace();
        }

        return user;
    }

    public static ArrayList<User> getAll() {
        String query = "select id, username, password, fullName, email, educationLevel, roleID, createdAt, updatedAt from [User]" +
                " ORDER BY CONVERT(DATE, createdAt) desc, CONVERT(DATE, updatedAt) desc";
        ArrayList<User> lsUsers = null;
        Connection con = null;
        try {
            lsUsers = new ArrayList<>();
            con = DBUtils.makeConnection();
            if (con != null) {
                Statement pre = con.createStatement();
                ResultSet rs = pre.executeQuery(query);
                while (rs.next()) {
                    User user = new User();
                    getUser(rs, user);
                    System.out.println(user.getFullName());
                    lsUsers.add(user);
                }
                con.close();
            }
        } catch (Exception e) {
            System.out.println("Cannot get list user");
            e.printStackTrace();
        }

        return lsUsers;
    }

    private static void getUser(ResultSet rs, User user) throws SQLException {
        user.setId(rs.getString("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("fullName"));
        user.setEmail(rs.getString("email"));
        user.setEducationLevel(rs.getString("educationLevel"));
        user.setRoleID(rs.getString("roleID"));
        user.setCreatedAt(rs.getDate("createdAt"));
        user.setUpdatedAt(rs.getDate("updatedAt"));
    }

    public static Integer update(User user) throws AccountException {
        String query = "update [User] set fullName = ?, email = ?, educationLevel = ?, roleID = ?, updatedAt = GETDATE() where id = ?";
        Connection cn = null;
        Integer rows = -1;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                PreparedStatement ppstm = cn.prepareStatement(query);
                ppstm.setNString(1, user.getFullName());
                System.out.println(user.getFullName());
                System.out.println(user.getId());
                ppstm.setString(2, user.getEmail());
                ppstm.setString(3, user.getEducationLevel());
                ppstm.setString(4, user.getRoleID());
                ppstm.setString(5, user.getId());
                rows = ppstm.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("error when update");
            e.printStackTrace();
            throw new AccountException("Cannot update");
        }

        return rows;
    }

    public static void updatePassword(String password, String id, String currentPassword) throws SQLException, Exception {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnection();
            String query = "UPDATE [user] SET password = ? WHERE id = ? ";
            if (currentPassword != null && !currentPassword.isEmpty()) {
                query += "AND password = ?";
            }
            stm = con.prepareStatement(query);
            stm.setString(1, password);
            stm.setString(2, id);
            if (currentPassword != null && !currentPassword.isEmpty()) {
                stm.setString(3, currentPassword);
            }
            int count = stm.executeUpdate();
            if (count == 0) {
                throw new WrongPasswordException("Wrong password!!!");
            }
        } catch (WrongPasswordException e) {
            throw new SQLException("Wrong password!!!", e);
        } catch (SQLException e) {
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public static Boolean isExit(String id) throws Exception {
        String query = "select * from [User] where id = ?";
        Boolean isExit = false;
        Connection cn = DBUtils.makeConnection();
        if (cn == null) throw new RoleException("Cannot make connection to Database.");

        PreparedStatement ppstm = cn.prepareStatement(query);
        ppstm.setString(1, id);
        ResultSet rs = ppstm.executeQuery();
        if (rs.next()) isExit = true;

        return isExit;
    }

}
