package com.library;

import com.library.service.ConstructorBookService;
import com.library.service.SetterBookService;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class LibraryManagementApplication {

    public static void main(String[] args) {

        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("applicationContext.xml");

        ConstructorBookService constructorService =
                context.getBean(
                        "constructorBookService",
                        ConstructorBookService.class
                );

        SetterBookService setterService =
                context.getBean(
                        "setterBookService",
                        SetterBookService.class
                );

        constructorService.execute();
        setterService.execute();

        context.close();
    }
}