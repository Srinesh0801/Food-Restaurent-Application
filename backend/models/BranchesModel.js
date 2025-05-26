const mongoose = require('mongoose');

const BranchSchema = new mongoose.Schema({
  BranchName: {
    type: String,
    required: true
  },
  Location: {
    type: String,
    required: true
  },
  OpeningHours: {
    type: String
  },
  GSTRegistration: {
    type: String
  },
  EnvironmentalClearance: {
    type: String
  }
});

module.exports = mongoose.model('Branch', BranchSchema);
