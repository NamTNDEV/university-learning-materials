/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import config.AppConfig;
import entities.*;
import exceptions.CurriculumException;
import utils.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author giahu
 */
public class CurriculumDao {

    //lấy curriculum theo id(curriculum detail)
    public static Curriculum getCurriculumById(String id) throws Exception {
        Curriculum curriculum = null;

        try {
            String query = "select * from Curriculum where id = ?";
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                curriculum.setActive(rs.getBoolean("active"));
            }

            con.close();
        } catch (SQLException se) {
            return null;
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return curriculum;
    }

    //lấy list curriculum theo code(search by code)
    public static List<Curriculum> readCurriculumListByCode(String code) throws Exception {
        String query = "select * from Curriculum where code like ?";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + code + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                curriculum.setActive(rs.getBoolean("active"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in read curriculum progress.");
        }
        return list;
    }

    //Get list curriculum by name(search by name)
    public static List<Curriculum> readCurriculumListByName(String name) throws Exception {
        String query = "select * from Curriculum where name like ?";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                curriculum.setActive(rs.getBoolean("active"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return list;
    }

    //Get full list curriculum
    public static List<Curriculum> readCurriculumFullList() throws Exception {
        String query = "select * from Curriculum where active = 1";
        List<Curriculum> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Curriculum curriculum = new Curriculum();
                curriculum.setId(rs.getInt("id"));
                curriculum.setCode(rs.getString("code"));
                curriculum.setName(rs.getString("name"));
                curriculum.setDescription(rs.getString("description"));
                curriculum.setDecisionNo(rs.getString("decisionNo"));
                curriculum.setViName(rs.getString("viName"));
                curriculum.setCreatedAt(rs.getString("createdAt"));
                curriculum.setUpdatedAt(rs.getString("updatedAt"));
                curriculum.setActive(rs.getBoolean("active"));
                list.add(curriculum);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return list;
    }

    public static List<SearchResult> searchByName(String name) throws Exception {
        String query = "select * from Curriculum where name like ?";
        List<SearchResult> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                SearchResult searchResult = new SearchResult();
                searchResult.setId(rs.getInt("id"));
                searchResult.setName(rs.getString("name"));
                searchResult.setSlug(String.valueOf(rs.getInt("id")));
                searchResult.setRoot_slug(AppConfig.CURRICULUM_ROOT_SLUG);
                list.add(searchResult);
            }
            con.close();
        } catch (Exception e) {
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return list;
    }

    public static List<SearchResult> searchByCode(String code) throws Exception {
        String query = "select * from Curriculum where code like ?";
        List<SearchResult> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, "%" + code + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                SearchResult searchResult = new SearchResult();
                searchResult.setId(rs.getInt("id"));
                searchResult.setName(rs.getString("code"));
                searchResult.setSlug(String.valueOf(rs.getInt("id")));
                searchResult.setRoot_slug(AppConfig.CURRICULUM_ROOT_SLUG);
                list.add(searchResult);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new CurriculumException("Something went wrong in get curriculum progress.");
        }
        return list;
    }

    //Add new curriculum(+po,plo) to db
    public static void add(Curriculum curriculum, List<ProgramObjective> poList, List<ProgramLearningObjective> ploList, List<Subject> subjectList) throws Exception {
        Connection con = null;
        Integer curId = null;
        Integer poId = null;
        Integer ploId = null;
        try {
            con = DBUtils.makeConnection();
            con.setAutoCommit(false);

            if (poList.isEmpty()) {
                throw new IllegalArgumentException("PO List is empty.");
            }
            if (ploList.isEmpty()) {
                throw new IllegalArgumentException("PLO List is empty.");
            }

            curId = add(con, curriculum);

            poList.sort(Comparator.comparing(po -> po.getName()));
            ploList.sort(Comparator.comparing(plo -> plo.getName()));

            for (ProgramObjective po : poList) {
                poId = PODao.add(con, po);
                po.setId(poId);
                PODao.link(con, curId, poId);
            }
            for (ProgramLearningObjective plo : ploList) {
                ploId = PLODao.add(con, plo);
                PLODao.link(con, curId, ploId);
                for (ProgramObjective po : poList) {
                    if (plo.getMapToPO().equals(po.getName())) {
                        PLODao.linkToPO(con, po.getId(), ploId);
                    }
                }
            }
            for (Subject subj : subjectList) {
                SubjectDao.linkWithCurriculum(con, curId, subj.getId());
            }

            con.commit();
        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    //Add new curriculum to db
    public static Integer add(Connection con, Curriculum curriculum) throws Exception {
        Integer id = -1;
        String query = "insert Curriculum values(?,?,?,?,?,cast(GETDATE() as date),?,?)";
        PreparedStatement pre = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        pre.setString(1, curriculum.getCode());
        pre.setNString(2, curriculum.getViName());
        pre.setString(3, curriculum.getName());
        pre.setString(4, curriculum.getDescription());
        pre.setNString(5, curriculum.getDecisionNo());
        pre.setString(6, null);
        pre.setBoolean(7, true);

        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Add curriculum failed, no rows affected.");
        }
        ResultSet generatedCurId = pre.getGeneratedKeys();
        if (generatedCurId.next()) {
            id = generatedCurId.getInt(1);
        } else {
            throw new SQLException("Inserting curriculum failed, no ID obtained.");
        }
        return id;
    }

    //Update curriculum(+po,plo) to db
    public static void update(Curriculum curriculum, List<ProgramObjective> poList, List<ProgramObjective> poListNew,
            List<ProgramLearningObjective> ploList, List<ProgramLearningObjective> ploListNew,
            List<Subject> subjList, List<Subject> subjListNew) throws Exception {
        Connection con = null;
        Integer curId = curriculum.getId();
        Integer poId = null;
        Integer ploId = null;

        List<ProgramObjective> poToInsert = poListNew.stream()
                .filter(po -> (Integer) po.getId() == 0).collect(Collectors.toList());
        List<ProgramObjective> poToUpdate = poListNew.stream()
                .filter(po -> (Integer) po.getId() != 0).collect(Collectors.toList());
        List<ProgramObjective> poToDelete = poList.stream()
                .filter(po -> poListNew.stream().noneMatch(poNew -> po.getId() == poNew.getId())).collect(Collectors.toList());

        List<ProgramLearningObjective> ploToInsert = ploListNew.stream()
                .filter(plo -> (Integer) plo.getId() == 0).collect(Collectors.toList());
        List<ProgramLearningObjective> ploToUpdate = ploListNew.stream()
                .filter(plo -> (Integer) plo.getId() != 0).collect(Collectors.toList());
        List<ProgramLearningObjective> ploToDelete = ploList.stream()
                .filter(plo -> ploListNew.stream().noneMatch(ploNew -> plo.getId() == ploNew.getId())).collect(Collectors.toList());

        List<Subject> subjToInsert = subjListNew.stream()
                .filter(subjNew -> subjList.stream().noneMatch(subj -> subjNew.getId() == subj.getId())).collect(Collectors.toList());
        List<Subject> subjToDelete = subjList.stream()
                .filter(subj -> subjListNew.stream().noneMatch(subjNew -> subj.getId() == subjNew.getId())).collect(Collectors.toList());
        
        try {
            con = DBUtils.makeConnection();
            con.setAutoCommit(false);

            if (poList.isEmpty()) {
                throw new IllegalArgumentException("Atleast one PO must be add.");
            }
            if (ploList.isEmpty()) {
                throw new IllegalArgumentException("Atleast one PLO must be add.");
            }

            update(con, curriculum);

            for (ProgramLearningObjective plo : ploToInsert) {
                ploId = PLODao.add(con, plo);
                PLODao.link(con, curId, ploId);
            }
            for (ProgramLearningObjective plo : ploToDelete) {
                PLODao.deleteLinkToPO(con, plo);
                PLODao.deleteLink(con, plo);
                PLODao.delete(con, plo);
            }
            for (ProgramLearningObjective plo : ploToUpdate) {
                PLODao.update(con, plo);
            }

            for (ProgramObjective po : poToInsert) {
                poId = PODao.add(con, po);
                PODao.link(con, curId, poId);
            }
            for (ProgramObjective po : poToDelete) {
                PODao.deleteLink(con, po);
                PODao.delete(con, po);
            }
            for (ProgramObjective po : poToUpdate) {
                PODao.update(con, po);
            }

            for (Subject subj : subjToInsert) {
                SubjectDao.linkWithCurriculum(con, curId, subj.getId());
            }
            for (Subject subj : subjToDelete) {
                SubjectDao.deleteLink(con, subj);
            }

            con.commit();
        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    //Update existing curiculum in db
    public static void update(Connection con, Curriculum curriculum) throws Exception {
        String query = "update Curriculum set code = ?, viName = ?, name = ?, description = ?, decisionNo = ?, active = ?, updatedAt = cast(GETDATE() as date) where id = ?";
        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, curriculum.getCode());
        pre.setNString(2, curriculum.getViName());
        pre.setString(3, curriculum.getName());
        pre.setNString(4, curriculum.getDescription());
        pre.setNString(5, curriculum.getDecisionNo());
        pre.setBoolean(6, curriculum.getActive());
        pre.setInt(7, curriculum.getId());
        int affectedRows = pre.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Update curriculum failed, no rows affected.");
        }
    }

    //check exist code
    public static boolean isExist(String curCode) throws Exception {
        String query = "select * from Curriculum where upper(code) = upper(?)";
        Connection con = DBUtils.makeConnection();
        PreparedStatement pre = con.prepareStatement(query);
        pre.setString(1, curCode);
        ResultSet rs = pre.executeQuery();
        boolean isExist = rs.next();

        con.close();
        return isExist;
    }
}
