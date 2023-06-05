/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * @author quocb
 */
public class AppConfig {

    //    AUTHENTICATION
    public final static String AUTH_USER = "USER";
    public final static String AUTH_FORCE_UPDATE_PASSWORD = "FORCE_UPDATE_PASSWORD";
    public final static String AUTH_PERMITTED_PATHS = "PERMITTED_PATHS";
    public final static ArrayList<String> EXCLUDE_ROUTES = new ArrayList(Arrays.asList("/login", "/register", "/Test", "/logout"));

    //    REQUISITE
    public final static String REQUISITE_ITEM = "REQUISITE";

    //    SYLLABUS
    public final static String SYLLABUS_ITEM = "SYLLABUS";
    public final static String SYLLABUS_ROOT_SLUG = "syllabus";

    //    CURRICULUMNS
    public final static String CURRICULUM_ITEM = "CURRICULUMN";
    public final static String CURRICULUM_ROOT_SLUG = "curriculums";

    //    PO
    public final static String PO_ITEM = "PO";
    public final static String PO_LIST = "PO_LIST";

    //    PLO
    public final static String PLO_ITEM = "PLO";
    public final static String PLO_LIST = "PLO_LIST";

    //    CLO
    public final static String CLO_ITEM = "CLO";
    public final static String CLO_LIST = "CLO_LIST";

    //    MATERIALS
    public final static String MATERIALS_ITEM = "MATERIALS";
    public final static String MATERIALS_LIST = "MATERIALS_LIST";

    //    SESSION
    public final static String SESSION_ITEM = "SESSION";
    public final static String SESSION_LIST = "SESSION_LIST";

    //    SUBJECT
    public final static String SUBJECT_ITEM = "SUBJECT";
    public final static String SUBJECT_LIST = "SUBJECT_LIST";
    public final static String SUBJECT_OLD_LIST = "SUBJECT_OLD_LIST";

    //    EXPLORE
    public final static String EXPLORE_LIST = "EXPLORE_LIST";

    //    Dashboard
    public final static String DASHBOARD_CURRICULUM_LIST = "lsCurriculums";
    public final static String DASHBOARD_CURRICULUM_TARGET = "curriculum";
    public final static String DASHBOARD_SYLLABUS_TARGET = "syllabus";
    public final static String DASHBOARD_SYLLABUS_LIST = "lsSyllabus";
    public final static String DASHBOARD_SUBJECT_LIST = "lsSubjects";
    public final static String DASHBOARD_SUBJECT = "subject";
    public final static String DASHBOARD_ACCOUNT_LIST = "dashboard.lsAccounts";
    public final static String DASHBOARD_ACCOUNT = "dashboard.account";

    public final static String DASHBOARD_ROLE_LIST = "dashboard.lsRole";
    public final static String DASHBOARD_EDUCATION_LEVEL_LIST = "dashboard.educationLevel";


    //    ERRORS
    public final static String ERROR_MESSAGE = "ERROR_MESSAGE";

    //    PATHS
    public final static String NOT_FOUND_PAGE = "/pages/not-found.jsp";
}
