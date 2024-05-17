package com.dineConnect.springboot.dineConnect.chat;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
public class ChatRoomList {
    private String roomId;
    private Set<WebSocketSession> sessions = new HashSet<>();

    public ChatRoomList(String roomId) {
        this.roomId = roomId;
    }

    public void handleMessage(WebSocketSession session, TextMessage message) throws Exception {
        for (WebSocketSession sess : sessions) {
            sess.sendMessage(message);
        }
    }

    public void addSession(WebSocketSession session) {
        sessions.add(session);
    }

    public void removeSession(WebSocketSession session) {
        sessions.remove(session);
    }
}
