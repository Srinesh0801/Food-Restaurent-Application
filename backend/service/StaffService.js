const Staff = require('../models/StaffModel');

const addStaff = async (data) => {
  const staff = new Staff(data);
  return await staff.save();
};

const getAllStaff = async () => {
  return await Staff.find();
};

// Find staff by name
const getStaffByName = async (name) => {
  return await Staff.findOne({ name });
};

// Update staff by name
const updateStaffByName = async (name, data) => {
  return await Staff.findOneAndUpdate({ name }, data, { new: true });
};

// Delete staff by name
const deleteStaffByName = async (name) => {
  return await Staff.findOneAndDelete({ name });
};

module.exports = {
  addStaff,
  getAllStaff,
  getStaffByName,
  updateStaffByName,
  deleteStaffByName
};