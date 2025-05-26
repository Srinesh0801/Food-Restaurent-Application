const branchService = require('../services/branchService');

// Create a new branch
const createBranch = async (req, res) => {
  try {
    const branch = await branchService.createBranch(req.body);
    res.status(201).json(branch);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Get all branches
const getAllBranches = async (req, res) => {
  try {
    const branches = await branchService.getAllBranches();
    res.status(200).json(branches);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Get a branch by ID
const getBranchById = async (req, res) => {
  try {
    const branch = await branchService.getBranchById(req.params.id);
    if (!branch) return res.status(404).json({ error: 'Branch not found' });
    res.status(200).json(branch);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Get a branch by name
const getBranchByName = async (req, res) => {
  try {
    const branch = await branchService.getBranchByName(req.params.name);
    if (!branch) return res.status(404).json({ error: 'Branch not found' });
    res.status(200).json(branch);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Update a branch by ID
const updateBranch = async (req, res) => {
  try {
    const branch = await branchService.updateBranch(req.params.id, req.body);
    if (!branch) return res.status(404).json({ error: 'Branch not found' });
    res.status(200).json(branch);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Delete a branch by ID
const deleteBranch = async (req, res) => {
  try {
    const branch = await branchService.deleteBranch(req.params.id);
    if (!branch) return res.status(404).json({ error: 'Branch not found' });
    res.status(200).json({ message: 'Branch deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = {
  createBranch,
  getAllBranches,
  getBranchById,
  getBranchByName,
  updateBranch,
  deleteBranch
};
