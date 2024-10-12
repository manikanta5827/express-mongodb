import express from 'express';
import { Users } from '../controllers/userController.js';

const router = express.Router();

router.get('/', Users);

export default router;
