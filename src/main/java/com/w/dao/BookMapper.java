package com.w.dao;

import com.w.vo.Book;

import java.util.List;

public interface BookMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Book record);

    int insertSelective(Book record);

    Book selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);

    //增加
    int addBook(Book book);

    //删除
    int delBook(Integer id);

    //修改
    int updateBook(Book book);

    //根据id查询book
    Book findBookById(Integer id);

    //查询所有图书
    List<Book> findAllBook();



}