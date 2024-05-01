"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const scoreService_1 = require("./scoreService");
const router = express_1.default.Router();
router.get('/scores', scoreService_1.getAllScores);
exports.default = router;
