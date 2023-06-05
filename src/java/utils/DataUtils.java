/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 * @author quocb
 */
public class DataUtils {
    public static Boolean getBoolean(Integer value) {
        return value == 1;
    }

    public static Boolean getBoolean(String value) {
        return value != null && value.equals("on");
    }

    public static Integer getInteger(Boolean value) {
        return value ? 1 : 0;
    }
}
