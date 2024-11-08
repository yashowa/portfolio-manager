module.exports = (sequelize,DataTypes)=>{
const User= sequelize.define('User',{

    id_user: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      firstname: {
        type: DataTypes.STRING,
        allowNull: false
      },
      lastname: {
        type: DataTypes.STRING,
        allowNull: false
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
      }
    ,
  },{

    tableName: 'user', // Spécifiez le nom de la table dans la base de données
    timestamps: false // Si vous n'avez pas de colonnes createdAt ou updatedAt
}
  )

    return User
}