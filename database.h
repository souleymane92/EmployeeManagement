#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_PATH         "C:/sqlite/mydatabases/EmployeeApp.db"
#define TABLE                 "Employees"
#define TABLE_FNAME           "firstName"
#define TABLE_LNAME           "lastName"
#define TABLE_EMAIL           "emailAddress"


class DataBase : public QObject
{
    Q_OBJECT
public:
    explicit DataBase(QObject *parent = 0);
    ~DataBase();
    void connectToDataBase();

private:
    QSqlDatabase    db;

private:
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();

public slots:
    bool inserIntoTable(const QVariantList &data);      // Adding entries to the table
    bool inserIntoTable(const QString &firstName, const QString &lastName, const QString &emailAddress);
    bool updateRow(int id, const QVariantList &data);      // Updating entries to the table
    bool updateRow(int id, const QString &firstName, const QString &lastName, const QString &emailAddress);
    bool removeRecord(const int id); // Removing records from the table on its id
};

#endif // DATABASE_H
