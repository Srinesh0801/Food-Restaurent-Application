const express = require('express');
const router = express.Router();





const authController = require('../controllers/authController');
const staffController = require('../controllers/StaffController');


router.post('/register', authController.register);
router.post('/login', authController.login);

//staff entry
router.post('/add-staff', staffController.addStaff);
router.get('/all-staff', staffController.getAllStaff);

// For get, update, delete by **name**, use ':name' param and proper leading slash
router.get('/staff/:name', staffController.getStaffByName);

// Include ':name' param in update and delete routes as well
router.put('/update-staff/:name', staffController.updateStaffByName);
router.delete('/delete-staff/:name', staffController.deleteStaffByName);




module.exports = router;