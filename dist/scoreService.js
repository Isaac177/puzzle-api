"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getAllScores = exports.submitScore = void 0;
const client_1 = require("@prisma/client");
const prisma = new client_1.PrismaClient();
async function submitScore({ userId, points, puzzleSize, numberOfMovesMade }) {
    const user = await prisma.user.findUnique({
        where: { id: userId },
    });
    if (!user) {
        await prisma.user.create({
            data: { id: userId, socketId: userId }
        });
    }
    const score = await prisma.score.create({
        data: {
            userId,
            points,
            puzzleSize,
            numberOfMovesMade
        }
    });
    return score;
}
exports.submitScore = submitScore;
const getAllScores = async (req, res) => {
    try {
        const scores = await prisma.score.findMany({
            orderBy: {
                points: 'desc',
            },
            include: {
                user: true
            }
        });
        res.status(200).json(scores);
    }
    catch (error) {
        console.error('Error fetching scores:', error);
        res.status(500).json({ error: 'Failed to fetch scores' });
    }
};
exports.getAllScores = getAllScores;
