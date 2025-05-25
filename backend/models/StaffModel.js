const { v4: uuidv4 } = require('uuid');
const mongoose = require('mongoose');

const staffSchema = new mongoose.Schema({
  name: { type: String, required: true },
  role: {
    type: String,
    required: true,
    enum: ['Chef', 'Waiter', 'Manager', 'Cleaner', 'Cashier', 'Receptionist', 'CEO', 'Other']
  },
  email: { type: String, required: true, unique: true },
  phone: { type: String, required: true },
  gender: { type: String, required: true },
  dob: { type: String, required: true },

  branch: { type: String, required: true },
  shift: { type: String, required: true },
  experience: { type: String, required: true },
  dateOfJoining: { type: String, required: true },
  address: { type: String, required: true },

  // Optional fields
  bloodGroup: { type: String },
  emergencyContact: { type: String },

  // Auto-generate if not provided
  staffId: {
    type: String,
    unique: true,
    default: () => uuidv4()
  },

  createdAt: { type: String, default: () => new Date().toISOString() }
});

module.exports = mongoose.model('Staff', staffSchema);