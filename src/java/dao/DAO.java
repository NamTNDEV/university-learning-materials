package dao;

import java.util.ArrayList;

public interface DAO<T> {
    Integer create(T target) throws Exception;

    T get() throws Exception;

    ArrayList<T> getAll() throws Exception;

    Integer update(T target) throws Exception;

    Integer delete() throws Exception;
}
