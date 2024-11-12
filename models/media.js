module.exports = (sequelize,DataTypes)=>{
    const Media= sequelize.define('Media',{
    
          id_media: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
          },
          type: {
            type: DataTypes.STRING,
            allowNull: false
          },
          url: {
            type: DataTypes.STRING,
            allowNull: false
          },
          is_active: {
            type: DataTypes.BOOLEAN,
            allowNull: false,
          }
        ,
      },
      {

    
        tableName: 'media', // Spécifiez le nom de la table dans la base de données
        timestamps: false, // Si vous n'avez pas de colonnes createdAt ou updatedAt
        underscored:true
    });

    Media.associate = (models)=>{

        Media.hasMany(models.MediaLang ,{foreignKey:'id_media'})
    }
     return Media
    }