

const fs = require('fs');
const path = require('path');

module.exports = (sequelize,DataTypes)=>{


    const fileupload = fs.readdirSync('./assets/upload')
    .filter((file) => {

      return (
        file.indexOf('.') !== 0 && // Ignore les fichiers cachés
        file !== 'index.js' &&     // Ignore le fichier "index.js"
        file.slice(-3) in [ 'jpg','png','svg']   // Prend seulement les fichiers JavaScript
      );
    })
    .forEach((file) => {
      console.log(file)

    });
   //reset

        return fileupload
    }