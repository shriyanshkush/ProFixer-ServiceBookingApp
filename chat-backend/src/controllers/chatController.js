const db = require("../config/firebaseConfig");

const joinChat = (socket, chatId) => {
    socket.join(chatId);
    console.log(`User joined chat room: ${chatId}`);
};

const sendMessage = async (socket, data) => {
    const { chatId, senderId, messageText } = data;
    const message = {
        sender_id: senderId,
        message_text: messageText,
        timestamp: new Date(),
    };

    try {
        // Save message to Firestore
        await db.collection("chats").doc(chatId).collection("messages").add(message);
        // Emit message to everyone in the chat room
        socket.to(chatId).emit("receiveMessage", message);
    } catch (error) {
        console.error("Error sending message:", error);
    }
};

module.exports = { joinChat, sendMessage };
