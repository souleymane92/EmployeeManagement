#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QHashIterator>
#include <database.h>

class ListModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    /* We list all the roles that will be used in the ListView.
     * As you can see, they have to be in the memory above the parameter Qt::UserRole.
     * Due to the fact that the information below this address is not for customizations
     * */
    enum Roles {
        IdRole = Qt::UserRole + 1,      // id
        FirstNameRole,                  // Firt name
        LastNameRole,                   // Last name
        EmailAddressRole                // Email Address
    };

    explicit ListModel(QObject *parent = 0);
    ~ListModel();

    // Override the method that will return the data
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE int getId(int row) const;
    Q_INVOKABLE bool remove(int row);
    Q_INVOKABLE bool add(const QVariantMap &employee);
    Q_INVOKABLE bool set(int row, const QVariantMap &employee);


protected:
    /* hashed table of roles for speakers.
     * The method used in the wilds of the base class QAbstractItemModel,
     * from which inherits the class QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;
    DataBase *m_database;

signals:

public slots:
    void updateModel();

};

#endif // LISTMODEL_H
