package com.dineConnect.springboot.dineConnect.chatServer.controller;

import com.dineConnect.springboot.dineConnect.chatServer.Room;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import lombok.extern.log4j.Log4j2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Log4j2
@Controller
@SessionAttributes("name")
public class ChatController {

    List<Room> roomList = new ArrayList<Room>();
    static int roomNumber = 0;

    @RequestMapping ("chat")
    public String chatMain(ModelMap model) {
        String username = (String) model.get("name");
        model.addAttribute("username", username);
        log.info("@ChatController, chat GET()");
        return "chat";
    }

    /**
     * 방 페이지
     * @return
     */
    @RequestMapping("chat-room")
    public String room(ModelMap model) {
        String username = (String) model.get("name");
        model.addAttribute("username", username);
        return "chatRoom";
    }

    /**
     * 방 생성하기
     * @param params
     * @return
     */
    @RequestMapping("createRoom")
    public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> params){
        String roomName = (String) params.get("roomName");
        if(roomName != null && !roomName.trim().equals("")) {
            Room room = new Room();
            room.setRoomNumber(++roomNumber);
            room.setRoomName(roomName);
            roomList.add(room);
        }
        return roomList;
    }

    /**
     * 방 정보가져오기
     * @param params
     * @return
     */
    @RequestMapping("getRoom")
    public @ResponseBody List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
        return roomList;
    }

    /**
     * 채팅방
     * @return
     */
    @RequestMapping("moveChating")
    public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
        ModelAndView mv = new ModelAndView();
        int roomNumber = Integer.parseInt((String) params.get("roomNumber"));

        List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
        if(new_list != null && new_list.size() > 0) {
            mv.addObject("roomName", params.get("roomName"));
            mv.addObject("roomNumber", params.get("roomNumber"));

            String username = (String) params.get("username");
            mv.addObject("username", username);

            mv.setViewName("chat");
        }else {
            mv.setViewName("chatRoom");
        }
        return mv;
    }

}
