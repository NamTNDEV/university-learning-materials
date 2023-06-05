package actions.common;

import actions.Action;
import dao.CurriculumDao;
import dao.SyllabusDao;
import entities.SearchResult;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.ResponseUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author quocb
 */
public class Search implements Action {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONObject json = new JSONObject();
        Integer status = HttpServletResponse.SC_OK;
        try (PrintWriter out = response.getWriter()) {
            try {
                String query = request.getParameter("q");
                String category = request.getParameter("c");
                System.out.println("cate " + category);
                List<SearchResult> results = new ArrayList<>();
                switch (category) {
                    case "curriculum": {
                        results = CurriculumDao.searchByCode(query);
                        break;
                    }
                    case "syllabus": {
                        System.out.println("syllabus");
                        results = SyllabusDao.searchBySubId(query);
                        break;
                    }
                }

                JSONArray jsonArray = new JSONArray(results);
                json.put("data", jsonArray);
            } catch (Exception e) {
                e.printStackTrace();
                json.put("message", "Not found");
                status = HttpServletResponse.SC_BAD_REQUEST;
            }
            ResponseUtils.sendJson(response, status, json);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
