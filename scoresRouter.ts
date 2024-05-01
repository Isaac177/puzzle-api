import express from 'express';
import {getAllScores} from "./scoreService";


const router = express.Router();


router.get('/scores', getAllScores);

export default router;
