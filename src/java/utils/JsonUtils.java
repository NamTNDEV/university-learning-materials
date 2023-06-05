/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.stream.Collectors;

/**
 * @author quocb
 */
public class JsonUtils {

    public static JSONObject getRequestJson(HttpServletRequest request) throws IOException {
        request.setCharacterEncoding("UTF-8");
        String jsonString = request.getReader().lines().collect(Collectors.joining());
        JSONObject json = new JSONObject(jsonString);
        return json;
    }

    public static JSONObject generateErrorJson(String message) {
        JSONObject resultJson = new JSONObject();
        resultJson.put("message", message);

        return resultJson;
    }
}
