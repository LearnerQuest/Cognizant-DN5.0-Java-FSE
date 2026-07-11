package com.library.service;

import com.library.repository.BookRepository;

public class SetterBookService {

    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void execute() {
        System.out.println("Setter injection executed");
        bookRepository.showRepositoryMessage();
    }
}