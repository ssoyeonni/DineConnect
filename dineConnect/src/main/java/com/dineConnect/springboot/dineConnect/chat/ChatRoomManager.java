package com.dineConnect.springboot.dineConnect.chat;

import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class ChatRoomManager {
    private final Map<String, ChatRoomList> chatRooms = new ConcurrentHashMap<>();

    public ChatRoomList getRoom(String roomId) {
        return chatRooms.computeIfAbsent(roomId, ChatRoomList::new);
    }
    public Map<String, ChatRoomList> getChatRooms() {
        return this.chatRooms;
    }
}
