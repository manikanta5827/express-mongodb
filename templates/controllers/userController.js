import User from '../models/User.js';

// Get all Users
const Users = async (req, res) => {
  const result = await User.find({}, { _id: 0 });
  res.send(result);
};
export { Users };
