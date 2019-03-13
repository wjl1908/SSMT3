package com.w.vo;

public class Book {
    private Integer id;

    private String bookname;

    private String author;

    private Double price;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname == null ? null : bookname.trim();
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }


    public Book(String bookname, String author, Double price) {
        this.bookname = bookname;
        this.author = author;
        this.price = price;
    }

    public Book() {
    }

    public Book(Integer id, String bookname, String author, Double price) {
        this.id = id;
        this.bookname = bookname;
        this.author = author;
        this.price = price;
    }
}