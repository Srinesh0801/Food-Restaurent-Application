const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  username: {
    type: String,
    required: [true, 'Please enter username'],
    unique: true,
    trim: true
  },
  password: {
    type: String,
    required: [true, 'Please enter password']
  }
});


module.exports = mongoose.model('UserRegister1', UserSchema);
