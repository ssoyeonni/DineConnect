package com.dineConnect.springboot.dineConnect.chatServer.handler;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashMap;

@Component
public class SocketHandler extends TextWebSocketHandler {

    HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); // 웹소켓 세션을 답아둘 맵

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 웹소켓이 연결되면 동작하는 메소드
        super.afterConnectionEstablished(session);
        sessionMap.put(session.getId(), session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 웹소켓이 연결이 종료되면 동작하는 메소드
        sessionMap.remove(session.getId());
        super.afterConnectionClosed(session, status);
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        // 메시지 발송하면 동작
        String msg = message.getPayload();
        for (String key : sessionMap.keySet()) {
            WebSocketSession wss = sessionMap.get(key);
            try {
                wss.sendMessage(new TextMessage(msg));
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
