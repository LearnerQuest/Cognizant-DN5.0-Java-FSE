package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void manageBook() {
        System.out.println("BookService bean obtained from IoC container");
        bookRepository.findBook();
    }
}