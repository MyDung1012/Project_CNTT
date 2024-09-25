package com.javaguides.Project;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

    @GetMapping("/Welcome")
    public String welcome(){
        return "Welcome to";
    }
}
