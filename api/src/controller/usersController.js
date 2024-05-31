const UsersService = require('../service/usersServices');

class UsersController{
    service;
    constructor(){
        this.service = new UsersService()
    }
    test = async (req, res) => {
        res.status(200).json({message: req.params.ok})
    }
}

module.exports = UsersController