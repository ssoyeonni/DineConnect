package com.dineConnect.springboot.dineConnect.chatServer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@SessionAttributes("name")
public class ChatController {

    @RequestMapping ("chat-room")
    public String chatMain(ModelMap model) {
        String username = (String) model.get("name");
        model.addAttribute("username", username);
        log.info("@ChatController, chat GET()");
        return "chatRoom";
    }

}
