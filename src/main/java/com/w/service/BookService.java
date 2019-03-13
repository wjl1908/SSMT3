package com.w.service;

import com.github.pagehelper.PageInfo;
import com.w.utils.JsonUtil;
import com.w.vo.Book;

public interface BookService {

    //查询所有图书
    JsonUtil<PageInfo<Book>> findAllBook(Integer pageNumber,Integer pageSize );

    //根据图书id 查询图书
    JsonUtil<Book> findBookById(Integer id);

    //增加图书
    JsonUtil addBook(Book book);

    //修改
    JsonUtil updateBook(Book book);

    //删除
    JsonUtil delBook(Integer id);

}
