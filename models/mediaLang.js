module.exports = (sequelize,DataTypes) => {

  const MediaLang = sequelize.define('MediaLang', {
      id_media_lang: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      title: {
        type: DataTypes.STRING,
        allowNull: false
      },
      description: {
        type: DataTypes.STRING,
        allowNull: false
      },
      id_media: {
          type: DataTypes.INTEGER,
      },
      id_lang: {
          type: DataTypes.INTEGER,
      },
      cat_media: {
          type: DataTypes.INTEGER,
      }
  },
  {
    tableName: 'media_lang', // Spécifiez le nom de la table dans la base de données
    timestamps: false, // Si vous n'avez pas de colonnes createdAt ou updatedAt
    underscored:true
  })

  MediaLang.associate = (models)=>{
    
    MediaLang.belongsTo(models.Media ,{foreignKey:'id_media'});
    MediaLang.belongsTo(models.Language ,{foreignKey:'id_lang'})


  }

  return MediaLang

}