const bcrypt = require('bcrypt');
const User = require('../models/AdminLoginModel');

async function register(username, password) {
  const existingUser = await User.findOne({ username });
  if (existingUser) {
    throw new Error('Username already taken');
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const user = new User({
    username,
    password: hashedPassword,
  });

try {
  await user.save();
  console.log('User saved:', user);
} catch (saveErr) {
  console.error('Error saving user:', saveErr);
  throw saveErr;
}

}


async function login(username, password) {
  // Find user by username
  const user = await User.findOne({ username });
  if (!user) {
    throw new Error('User not found');
  }

  // Compare password with hashed password
  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) {
    throw new Error('Invalid password');
  }

  // Return user info (excluding password)
  return {
    id: user._id,
    username: user.username,
  };
}
module.exports = { register , login};
