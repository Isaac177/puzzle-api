import {PrismaClient} from '@prisma/client';
import {Response, Request} from "express";

const prisma = new PrismaClient();


interface ScoreSubmission {
    userId: string;
    points: number;
    puzzleSize: number;
    numberOfMovesMade: number;
}

export async function submitScore({userId, points, puzzleSize, numberOfMovesMade}: ScoreSubmission) {
    const user = await prisma.user.findUnique({
        where: {id: userId},
    });

    if (!user) {
        await prisma.user.create({
            data: {id: userId, socketId: userId}
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

export const getAllScores = async (req: Request, res: Response) => {
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
    } catch (error) {
        console.error('Error fetching scores:', error);
        res.status(500).json({error: 'Failed to fetch scores'});
    }
}
