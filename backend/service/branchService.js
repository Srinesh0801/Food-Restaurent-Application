const Branch = require('../models/Branch');

const createBranch = async (data) => {
  const branch = new Branch(data);
  return await branch.save();
};

const getAllBranches = async () => {
  return await Branch.find();
};

const getBranchById = async (id) => {
  return await Branch.findById(id);
};

const getBranchByName = async (name) => {
  return await Branch.findOne({ BranchName: name });
};

const updateBranch = async (id, data) => {
  return await Branch.findByIdAndUpdate(id, data, { new: true });
};

const deleteBranch = async (id) => {
  return await Branch.findByIdAndDelete(id);
};

module.exports = {
  createBranch,
  getAllBranches,
  getBranchById,
  getBranchByName,
  updateBranch,
  deleteBranch
};
