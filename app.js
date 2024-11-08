

const express =require ('express');
const app =express();
const path = require('path');
const session = require('express-session');
const bcrypt = require('bcrypt')
const db = require('./models')
const fileupload = require('./core/fileupload');
const puppeteer = require('puppeteer');
require('dotenv').config();



db.sequelize.sync()
  .then(() => {
    console.log("Base de données synchronisée !");
  })
  .catch((error) => {
    console.error("Erreur de synchronisation :", error);
  });

app.set("views", "./views");
app.set("view engine","ejs");
app.use(express.static(path.join(__dirname,'assets')));

// Middleware pour analyser les données des formulaires
app.use(express.urlencoded({ extended: true }));

// Configurer les sessions
app.use(session({
    secret: process.env.SECRET_KEY,
    resave: false,
    saveUninitialized: true
}));



function requireAuth(req, res, next) {
  if (req.session.user) {
    next(); // Utilisateur authentifié, passe à la route suivante
  } else {
    res.status(401).send('Accès refusé, veuillez vous connecter');
  }
}

app.get('/',requireAuth, (req, res)=>{
    res.redirect('dashboard')
})
app.get('/book',requireAuth, (req, res)=>{
    res.send('book')
})
app.get('/event',requireAuth , (req, res)=>{
    res.send('event')
})
app.get('/dashboard', requireAuth,(req, res)=>{
  res.send('dashboard')
})

app.get('/notification', (req, res)=>{
  res.send('notification')
})

app.get('/logout',(req, res)=>{
  req.session.destroy();
  res.redirect('login');
})


app.get('/fileupload', (req, res)=>{
  console.log(fileupload)
  res.json(fileupload)
})

app.get('/login',(req, res)=>{
    res.render('login')
})

app.post('/login',async (req, res)=>{
  console.log(req.body,'body')
  const {email,password} = req.body
  console.log(email,password)
  try {
    // Récupérer tous les utilisateurs
    const user = await db.User.findOne({ where: { email,passwd:password } })

if(user){
    req.session.user=user; 
    res.redirect('dashboard')
  }else{
    res.redirect('login')
  }

} catch (error) {
  console.error("Erreur lors de la récupération des utilisateurs :", error);
}
    res.render('login')
})

app.listen(3000,()=> {
    console.log('serveur demarré')
})