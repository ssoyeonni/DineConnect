package com.dineConnect.springboot.dineConnect.chat;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.json.JSONObject;

@Log4j2
@Component
public class ChatHandler extends TextWebSocketHandler {

    @Autowired
    private ChatRoomManager chatRoomManager;

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        log.info("payload : " + payload);

        JSONObject jsonObject = new JSONObject(payload);
        String roomId = jsonObject.getString("roomId");
        String content = jsonObject.getString("content");

        ChatRoomList room = chatRoomManager.getRoom(roomId);
        room.handleMessage(session, new TextMessage(content));
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info(session + " 클라이언트 접속");
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.info(session + " 클라이언트 접속 해제");

        // 모든 채팅방에서 해당 세션 제거
        chatRoomManager.getChatRooms().forEach((id, room) -> room.removeSession(session));
    }
}
