module.exports = (sequelize,DataTypes) => {

    const EventLang = sequelize.define('EventLang', {
        id_event_lang: {
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
        id_event: {
            type: DataTypes.INTEGER,
        },
        id_lang: {
            type: DataTypes.INTEGER,
        },
        cat_event: {
            type: DataTypes.INTEGER,
        }
    },
    {
      tableName: 'event_lang', // Spécifiez le nom de la table dans la base de données
      timestamps: false, // Si vous n'avez pas de colonnes createdAt ou updatedAt
      underscored:true
    })
  
    EventLang.associate = (models)=>{
      
        EventLang.belongsTo(models.Event ,{foreignKey:'id_event'});
        EventLang.belongsTo(models.Language ,{foreignKey:'id_lang'})
  
    }
  
    return EventLang
  
  }