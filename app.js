
const express =require ('express');
const app =express();
const path = require('path');
const session = require('express-session');
const bcrypt = require('bcrypt')
const db = require('./models')
const fileupload = require('./core/fileupload');
const puppeteer = require('puppeteer');
const { and, where } = require('sequelize');
const defaultLang = process.env.DEFAULT_LANG;
  

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
    res.redirect('/login')
    //res.status(401).send('Accès refusé, veuillez vous connecter');
  }
}

app.get('/',requireAuth, (req, res)=>{
    res.redirect('/dashboard')
})

app.get('/media/list', requireAuth, async (req, res)=>{



  try{ 
    const books = await db.Media.findAll({ include: [{ 
      model: db.MediaLang,
      include:[
      {
        model: db.Language,
        where: {code: defaultLang},
        required:true
      }],
      required:true   }],
    }); 


    const medias = books.map((book)=>{

      const bookJson = book.toJSON() 
      const mediaLang = book.MediaLangs && book.MediaLangs[0];
      
      return {
        ...bookJson,
        title: mediaLang.title,
      }
    })

    res.render('media-list',{medias})

  } catch (error) {
    console.error("Erreur lors de la récupération des medias :", error);
    res.status(500).send("Erreur lors de la récupération des medias");
  }
})

app.get('/media/:id', requireAuth, async (req, res)=>{
  try{
    const media = await db.Media.findOne({
      where : {id_media:req.params.id},
      include:[
        { model   : db.MediaLang,
          include : [
            {
              model : db.Language,
              where: {code: defaultLang},
              required:true
          }],
          required:true
        }]
      })

    if(!media){
      return res.status(404).render("media",{media:{}});
    }
    const mediaJson =media.toJSON()
    res.render('media',{
      media: mediaJson
    })

    console.log("media",media.toJSON())
    console.log('okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk')

  } catch (error) {
    console.error("Erreur lors de la récupération du media :", error);
    res.status(500).send("Erreur lors de la récupération du media");
  }
})


app.get('/event/list',requireAuth , async (req, res)=>{

  const defaultLang = process.env.DEFAULT_LANG;

  try{ 
    const listEvent = await db.Event.findAll({ include: [{ 
      model: db.EventLang,
      include:[
      {
        model: db.Language,
        where: {code: defaultLang},
        required:true
      }],
      required:true   }],
    }); 


    const events = listEvent.map((book)=>{

      const eventJson = book.toJSON() 
      const eventLang = book.EventLangs && book.EventLangs[0];
      
      return {
        ...eventJson,
        title: eventLang.title,
        category: eventLang.cat_event,
      }
    })

    res.render('event/event-list',{events})

  } catch (error) {
    console.error("Erreur lors de la récupération des medias :", error);
    res.status(500).send("Erreur lors de la récupération des medias");
  }
})



app.get('/event',requireAuth , (req, res)=>{
  res.send('event')
})
app.get('/dashboard', requireAuth,(req, res)=>{
  res.render('dashboard')
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

app.post('/login', async (req, res)=>{
  console.log(req.body,'body')
  const {email, password} = req.body
  console.log(email, password)
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
  res.render('login')
}

})

app.listen(3000,()=> {
    console.log('serveur demarré')
})