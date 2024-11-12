const fs = require('fs');
const path = require('path');
const { Sequelize } = require('sequelize');
require('dotenv').config();
const sequelize = require('../core/connection');
 
const db = {};

// Parcours des fichiers dans le dossier "models"
fs.readdirSync(__dirname)
  .filter((file) => {
    return (
      file.indexOf('.') !== 0 && // Ignore les fichiers cachés
      file !== 'index.js' &&     // Ignore le fichier "index.js"
      file.slice(-3) === '.js'   // Prend seulement les fichiers JavaScript
    );
  })
  .forEach((file) => {
    const model = require(path.join(__dirname, file))(sequelize, Sequelize.DataTypes);
    db[model.name] = model;
  });

  console.log(db);
// Création des relations entre les modèles, si définies dans les modèles
Object.keys(db).forEach((modelName) => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

console.log("Associations pour Media:", db.Media.associations);
console.log("Associations pour MediaLang:", db.MediaLang.associations);
console.log("Associations pour Language:", db.Language.associations);

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;