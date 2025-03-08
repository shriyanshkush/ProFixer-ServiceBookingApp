// src/index.js
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const { joinChat, sendMessage } = require("./controllers/chatController");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*", // Allow all origins (adjust in production)
    },
});

io.on("connection", (socket) => {
    console.log("New user connected:", socket.id);

    // Join a chat room
    socket.on("joinChat", (chatId) => {
        joinChat(socket, chatId);
    });

    // Handle sending messages
    socket.on("sendMessage", (data) => {
        sendMessage(socket, data);
    });

    socket.on("disconnect", () => {
        console.log("User disconnected:", socket.id);
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
