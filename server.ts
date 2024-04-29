import express from 'express';
import { createServer } from 'http';
import { Server, Socket } from 'socket.io';
import {submitScore} from "./scoreService";

const app = express();
const httpServer = createServer(app);
//const io = new Server(httpServer);

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Hello World!');
});

const io = new Server(httpServer, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"],
        allowedHeaders: ["my-custom-header"],
        credentials: true
    }
});


io.on('connection', (socket: Socket) => {
    console.log('A user connected with socket ID:', socket.id);

    socket.on('disconnect', () => {
        console.log('User disconnected:', socket.id);
    });

    socket.on('submit_score', async (data: { userId: string; points: number; puzzleSize: number }) => {
        try {
            // Assuming you have a function submitScore defined elsewhere that handles DB logic
            const { userId, points, puzzleSize } = data;
            const score = await submitScore({ userId, points, puzzleSize });
            io.emit('update_leaderboard', score); // Broadcasting to all clients
        } catch (error) {
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
