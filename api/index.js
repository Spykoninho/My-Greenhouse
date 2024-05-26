const express = require('express')
const router = require('./src/routes/users')

const path = require('path')
const routesPath = path.join(__dirname, './src/routes')
const cors = require('cors')
const morgan = require('morgan')
const bodyParser = require('body-parser')
const app = express()
const fs = require('fs')

const port = 3001
app.use(morgan('dev'))
app.use(cors())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.raw())
app.use(router)

fs.readdirSync(routesPath).forEach(file => {
    if(file.endsWith('.js')){
        let route = require(path.join(routesPath, file));
        app.use(route)
    }
})

app.listen(port, ()=>{
    console.log(`API Started on port : ${port}`)
})

router.get('/', (req, res)=>{
    res.status(200).json({message:'Hello World !'})
})