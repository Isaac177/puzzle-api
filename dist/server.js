"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const http_1 = require("http");
const socket_io_1 = require("socket.io");
const scoreService_1 = require("./scoreService");
const scoresRouter_1 = __importDefault(require("./scoresRouter"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const app = (0, express_1.default)();
const httpServer = (0, http_1.createServer)(app);
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: true }));
const PORT = process.env.PORT || 3000;
app.get('/', (req, res) => {
    res.send('Hello World!');
});
app.use('/', scoresRouter_1.default);
const io = new socket_io_1.Server(httpServer, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"],
        allowedHeaders: ["my-custom-header"],
        credentials: true
    }
});
io.on('connection', (socket) => {
    console.log('A user connected with socket ID:', socket.id);
    socket.on('disconnect', () => {
        console.log('User disconnected:', socket.id);
    });
    socket.on('submit_score', async (data) => {
        try {
            const { userId, points, puzzleSize, numberOfMovesMade } = data;
            const score = await (0, scoreService_1.submitScore)({ userId, points, puzzleSize, numberOfMovesMade });
            io.emit('update_leaderboard', score);
            console.log('Score submitted:', score);
        }
        catch (error) {
            console.error('Error submitting score:', error);
            socket.emit('error', 'Failed to submit score');
        }
    });
});
io.on('connection_error', (error) => {
    console.log('Connection error:', error);
});
app.get('/test', (req, res) => {
    res.send('Server is working!');
});
httpServer.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
