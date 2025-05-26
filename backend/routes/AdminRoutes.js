const express = require('express');
const router = express.Router();





const authController = require('../controllers/authController');
const staffController = require('../controllers/StaffController');
const branchController = require('../controllers/branchController');



router.post('/register', authController.register);
router.post('/login', authController.login);

router.post('/add-staff', staffController.addStaff);
router.get('/all-staff', staffController.getAllStaff);
router.get('/staff/:name', staffController.getStaffByName);
router.put('/update-staff/:name', staffController.updateStaffByName);
router.delete('/delete-staff/:name', staffController.deleteStaffByName);




// CRUD routes
router.post('/add-branch', branchController.createBranch);
router.get('/get-branch', branchController.getAllBranches);
router.get('/get/:id', branchController.getBranchById);
router.get('/by-name/:name', branchController.getBranchByName);
router.put('/edit-branch/:id', branchController.updateBranch);
router.delete('/delete-branch/:id', branchController.deleteBranch);

module.exports = router;


module.exports = router;