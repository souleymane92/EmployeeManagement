#include "database.h"

DataBase::DataBase(QObject *parent) : QObject(parent)
{

}

DataBase::~DataBase()
{
    qDebug() << "I am deleted! ";
}

void DataBase::connectToDataBase()
{
    if(!QFile(DATABASE_PATH).exists()){
        this->restoreDataBase();
    } else {
        this->openDataBase();
    }
}

bool DataBase::restoreDataBase()
{
    if(this->openDataBase()){
        return (this->createTable()) ? true : false;
    } else {
        qDebug() << "Failed to restore the database";
        return false;
    }
    return false;
}

bool DataBase::openDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
   // db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName(DATABASE_PATH);
    if(db.open()){
        return true;
    } else {
        return false;
    }
}

void DataBase::closeDataBase()
{
    db.close();
}

bool DataBase::createTable()
{
    QSqlQuery query;
    if(!query.exec( "CREATE TABLE " TABLE " ("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                            TABLE_FNAME     " VARCHAR(255)    NOT NULL,"
                            TABLE_LNAME     " VARCHAR(255)    NOT NULL,"
                            TABLE_EMAIL     " VARCHAR(255)    NOT NULL"
                        " )"
                    )){
        qDebug() << "DataBase: error of create " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        qDebug() << "Table created";
        return true;
    }
    return false;
}

bool DataBase::inserIntoTable(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " TABLE " ( " TABLE_FNAME ", "
                                             TABLE_LNAME ", "
                                             TABLE_EMAIL" ) "
                  "VALUES (:firstName, :lastName, :emailAddress)");
    query.bindValue(":firstName",       data[0].toString());
    query.bindValue(":lastName",       data[1].toString());
    query.bindValue(":emailAddress",         data[2].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::inserIntoTable(const QString &firstName, const QString &lastName, const QString &emailAddress)
{
    QVariantList data;
    data.append(firstName);
    data.append(lastName);
    data.append(emailAddress);

    if(inserIntoTable(data))
        return true;
    else
        return false;
}

bool DataBase::updateRow(int id, const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("UPDATE " TABLE " SET "
                TABLE_FNAME " = :firstName, "
                TABLE_LNAME " = :lastName, "
                TABLE_EMAIL " = :emailAddress WHERE id=:id");
    query.bindValue(":id",             id);
    query.bindValue(":firstName",      data[0].toString());
    query.bindValue(":lastName",       data[1].toString());
    query.bindValue(":emailAddress",   data[2].toString());

    if(!query.exec()){
        qDebug() << "error update " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::updateRow(int id, const QString &firstName, const QString &lastName, const QString &emailAddress)
{
    QVariantList data;
    data.append(firstName);
    data.append(lastName);
    data.append(emailAddress);

    if(updateRow(id, data))
        return true;
    else
        return false;
}

bool DataBase::removeRecord(const int id)
{
    QSqlQuery query;

    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}
