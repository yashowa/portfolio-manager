
module.exports = (sequelize,DataTypes)=>{

    const Language = sequelize.define('Language', {

        id_lang: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
          code: {
            type: DataTypes.STRING,
            allowNull: false
        },
          alias: {
            type: DataTypes.STRING,
            allowNull: false
        }
    },
    { 
        tableName:'language',
        timestamps: false
    })

    Language.associate = (models)=>{

        Language.hasMany(models.MediaLang ,{foreignKey:'id_lang'})
    }
    return Language
}