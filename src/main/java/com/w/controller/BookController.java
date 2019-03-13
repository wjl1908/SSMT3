package com.w.controller;

import com.github.pagehelper.PageInfo;
import com.w.service.BookService;
import com.w.utils.JsonUtil;
import com.w.vo.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("book")
public class BookController {

    @Autowired
    private BookService bookService;


    //查询图书
    @RequestMapping("/find")
    public @ResponseBody JsonUtil<PageInfo<Book>> getAllBook(Integer pageNumber, Integer pageSize ){
        System.out.println("111");
        return  bookService.findAllBook(pageNumber,pageSize);
    }

    //根据id 查询图书
    @RequestMapping("/findBookById")
    public @ResponseBody JsonUtil<Book> findBookById(Integer id){

        return bookService.findBookById(id);
    }


    //增加图书
    @RequestMapping("/addBook")
    public @ResponseBody JsonUtil  addBlog(Book book){

        return  bookService.addBook(book);
    }

    //修改
    @RequestMapping("/updateBook")
    public @ResponseBody JsonUtil updateBook(Book book){
        return bookService.updateBook(book);
    }

    //删除图书
    @RequestMapping("/delBook")
    public @ResponseBody JsonUtil delBook(Integer id){
        return  bookService.delBook(id);
    }

}
