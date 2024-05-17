package com.dineConnect.springboot.dineConnect.chat;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.*;

@Controller
@Log4j2
@SessionAttributes("name")
public class ChatController {

    // /chat링크로 이동했을 때
    // RequestParam은 url에서 값을 받아서 Controller에 전달 가능
    // Controller에서 jsp에 전달할 땐 Model 사용


    @GetMapping(value="chat-room")
       public String chatGET(ModelMap model){
        String username = (String) model.get("name");
        model.addAttribute("username", username);
        log.info("@ChatController, chat GET()");
        return "chatRoom";
       }

    @GetMapping(value="chat-room-manager")
    public String chatMGET(ModelMap model){
        String username = (String) model.get("name");
        model.addAttribute("username", username);
        log.info("@ChatController, chat MGET()");
        return "chatRoomManager";
    }


}
