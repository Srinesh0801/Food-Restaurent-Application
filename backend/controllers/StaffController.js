const staffService = require('../service/StaffService');

const addStaff = async (req, res) => {
  try {
    const staff = await staffService.addStaff(req.body);
    res.status(201).json({ message: 'Staff added successfully', staff });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error adding staff', error: err.message });
  }
};


const getAllStaff = async (req, res) => {
  try {
    const staffList = await staffService.getAllStaff();
    res.status(200).json(staffList);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching staff list', error: err.message });
  }
};

const getStaffByName = async (req, res) => {
  try {
    const staff = await staffService.getStaffByName(req.params.name);
    if (!staff) {
      return res.status(404).json({ message: 'Staff not found' });
    }
    res.status(200).json(staff);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching staff', error: err.message });
  }
};

// Update staff by name
const updateStaffByName = async (req, res) => {
  try {
    const updatedStaff = await staffService.updateStaffByName(req.params.name, req.body);
    if (!updatedStaff) {
      return res.status(404).json({ message: 'Staff not found' });
    }
    res.status(200).json({ message: 'Staff updated', staff: updatedStaff });
  } catch (err) {
    res.status(500).json({ message: 'Error updating staff', error: err.message });
  }
};

// Delete staff by name
const deleteStaffByName = async (req, res) => {
  try {
    const deleted = await staffService.deleteStaffByName(req.params.name);
    if (!deleted) {
      return res.status(404).json({ message: 'Staff not found' });
    }
    res.status(200).json({ message: 'Staff deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Error deleting staff', error: err.message });
  }
}

module.exports = {
  addStaff,
  getAllStaff,
  getStaffByName,
  updateStaffByName,
  deleteStaffByName
}
