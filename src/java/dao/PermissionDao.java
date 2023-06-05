/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utils.DBUtils;

/**
 *
 * @author quocb
 */
public class PermissionDao {
    public static ArrayList<String> getByRoleId(String roleID) {
        String query = "select Role.id, permissionName, resource_url from Role_Permission_Mapping RPM"
                + " INNER JOIN Role on RPM.roleID = Role.id"
                + " INNER join Permission P on RPM.permissionID = P.id  where Role.id = ?";
        Connection con = null;
        ArrayList<String> permittedPaths = null;
        try {
            permittedPaths = new ArrayList<>();
            con = DBUtils.makeConnection();
            if (con != null) {
                PreparedStatement pre = con.prepareStatement(query);
                pre.setString(1, roleID);
                ResultSet rs = pre.executeQuery();
                while (rs.next()) {
                    String resourceUrl = rs.getString("resource_url");
                    permittedPaths.add(resourceUrl);
                }
                con.close();
            }
        } catch (Exception e) {
            System.out.println("Cannot get User");
            e.printStackTrace();
        }
        
        return permittedPaths;
    }
}
