package dao;

import entities.Role;
import exceptions.RoleException;
import utils.DBUtils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class RoleDao implements DAO<Role> {
    @Override
    public Integer create(Role target) {
        return null;
    }

    @Override
    public Role get() {
        return null;
    }

    @Override
    public ArrayList<Role> getAll() throws Exception {
        String query = "select * from [Role]";
        ArrayList<Role> lsRole = null;
        Connection cn = DBUtils.makeConnection();
        if (cn == null) throw new RoleException("Cannot make connection to Database.");
        lsRole = new ArrayList<>();
        Statement stm = cn.createStatement();
        ResultSet rs = stm.executeQuery(query);

        while (rs.next()) {
            Role role = getRoleFromResultSet(rs);
            lsRole.add(role);
        }
        return lsRole;
    }

    @Override
    public Integer update(Role target) {
        return null;
    }

    @Override
    public Integer delete() {
        return null;
    }


    private Role getRoleFromResultSet(ResultSet rs) throws SQLException {
        String id = rs.getString("id");
        String name = rs.getString("roleName");
        return new Role(id, name);
    }
}
