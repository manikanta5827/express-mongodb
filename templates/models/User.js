import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
  userName: { type: String, required: true, unique: true },
  email: { type: String, required: true, unique: true },
}, {
  timestamps: true,
});

const User = mongoose.model('User', userSchema,"User");
export default User;
