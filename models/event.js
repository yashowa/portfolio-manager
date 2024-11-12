
module.exports = (sequelize,DataTypes)=>{

    const Event = sequelize.define('Event', {

        id_event: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
          media: {
            type: DataTypes.STRING,
            allowNull: false
        },
          place: {
            type: DataTypes.STRING,
            allowNull: false
        },
        organizer: {
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
        },
        date_start: {
        type: DataTypes.DATE,
        allowNull: false,
        },
        date_end: {
        type: DataTypes.DATE,
        allowNull: false,
        },
        fees: {
        type: DataTypes.INTEGER,
        allowNull: false,
        },
        contact: {
        type: DataTypes.STRING,
        allowNull: false,
        },
        author: {
        type: DataTypes.INTEGER,
        allowNull: false,
        }
    },
    { 
        tableName:'event',
        timestamps: false,
        underscored:true
    })

    Event.associate = (models)=>{
        Event.hasMany(models.EventLang ,{foreignKey:'id_lang'})
    }
    return Event
}