import express from 'express';
import dotenv from 'dotenv';
import userRoutes from './routes/userRoutes.js';
import { errorHandler } from './utils/errorHandler.js';
import connectDB from './config/db.js';
import morgan from 'morgan';
import cors from 'cors';
import compression from 'compression';

dotenv.config();
connectDB();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(compression());

// Routes
app.use('/user', userRoutes);

// Error handling middleware
app.use(errorHandler);
app.use(morgan('dev'));
app.get('/', (req, res) => {
  res.send('Hello, World!');
});
const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
