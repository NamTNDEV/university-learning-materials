package actions.dashboard;

import actions.Action;
import dao.SubjectDao;
import exceptions.SubjectException;
import org.json.JSONObject;
import utils.JsonUtils;
import utils.ResponseUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class UpdateSubjectStatus implements Action {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            JSONObject responseJSON = new JSONObject();
            Integer status = null;

            try {
                JSONObject requestJSON = JsonUtils.getRequestJson(request);
                String subjectID = requestJSON.getString("subject_id");
                if (subjectID == null) {
                    throw new SubjectException("Cannot update status of subject. Subject ID is required.");
                }
                System.out.println("subjectid " + subjectID);
                Boolean active = requestJSON.getBoolean("active");
                SubjectDao.updateStatus(subjectID, active);
                responseJSON.put("message", "Update status of " + subjectID + " successfully.");
                status = HttpServletResponse.SC_OK;
            } catch (SubjectException subEx) {
                subEx.printStackTrace();
                responseJSON.put("message", subEx.getMessage());
                status = HttpServletResponse.SC_BAD_REQUEST;
            } catch (Exception e) {
                e.printStackTrace();
                responseJSON.put("message", "Failed to update status of subject. Try again.");
                status = HttpServletResponse.SC_BAD_REQUEST;
            }

            ResponseUtils.sendJson(response, status, responseJSON);
        }
    }
}
