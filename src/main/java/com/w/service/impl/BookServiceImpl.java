package com.w.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.w.dao.BookMapper;
import com.w.service.BookService;
import com.w.utils.JsonUtil;
import com.w.vo.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookMapper bookMapper;

    //查询所有图书
    /*
     * 如果当前存在事务，则加入该事务；如果当前没有事务，则创建一个新的事务。这是默认值。*/
    @Transactional(readOnly = true ,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil<PageInfo<Book>> findAllBook(Integer pageNumber, Integer pageSize) {
        PageHelper.startPage(pageNumber,pageSize,"id Desc");
        List<Book> booklist=bookMapper.findAllBook();
        PageInfo<Book> allbook=new PageInfo<>(booklist);
        JsonUtil util=new JsonUtil("ok",allbook,"0");
        return util;
    }

    //根据id查询图书
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil<Book> findBookById(Integer id) {
        Book book=bookMapper.findBookById(id);
        JsonUtil util=new JsonUtil("OK",book,"0");
        return util;
    }

    //添加图书
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil addBook(Book book) {
        JsonUtil jsonUtil=new JsonUtil();
        int cnt=bookMapper.addBook(book);
        if(cnt>0){
            jsonUtil.setErrorCode("0");
            jsonUtil.setMsg("OK");
        }else{
            jsonUtil.setMsg("ERROR");
            jsonUtil.setErrorCode("500");
        }
        return jsonUtil;
    }

    //修改图书
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil updateBook(Book book) {
        JsonUtil jsonUtil=new JsonUtil();
        int cnt=bookMapper.updateBook(book);
        if(cnt>0){
            jsonUtil.setErrorCode("0");
            jsonUtil.setMsg("OK");
        }else{
            jsonUtil.setMsg("ERROR");
            jsonUtil.setErrorCode("500");
        }
        return jsonUtil;
    }


    //删除图书
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil delBook(Integer id) {
        JsonUtil jsonUtil=new JsonUtil();
        int cnt=bookMapper.delBook(id);
        if(cnt>0){
            jsonUtil.setErrorCode("0");
            jsonUtil.setMsg("OK");
        }else{
            jsonUtil.setMsg("ERROR");
            jsonUtil.setErrorCode("500");
        }
        return jsonUtil;
    }




}
