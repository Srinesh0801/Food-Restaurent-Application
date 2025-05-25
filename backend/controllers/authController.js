const authService = require('../service/authService');

async function register(req, res) {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username and password are required' });
  }

  try {
    const result = await authService.register(username, password);
    return res.status(201).json(result);
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
}

async function login(req, res) {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username and password are required' });
  }

  try {
    const user = await authService.login(username, password);
    return res.status(200).json({ message: 'Login successful', user });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
}

module.exports = { register,login };
