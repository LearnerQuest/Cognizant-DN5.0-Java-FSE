package com.library.service;

import com.library.repository.BookRepository;

public class ConstructorBookService {

    private final BookRepository bookRepository;

    public ConstructorBookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void execute() {
        System.out.println("Constructor injection executed");
        bookRepository.showRepositoryMessage();
    }
}