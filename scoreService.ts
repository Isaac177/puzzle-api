import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

interface ScoreSubmission {
    userId: string;
    points: number;
    puzzleSize: number;
}

export async function submitScore({ userId, points, puzzleSize }: ScoreSubmission) {
    const score = await prisma.score.create({
        data: {
            userId,
            points,
            puzzleSize,
        }
    });
    return score;
}
