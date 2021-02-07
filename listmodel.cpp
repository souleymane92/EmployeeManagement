#include "listmodel.h"
#include "database.h"

ListModel::ListModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    m_database = new DataBase();
    m_database->connectToDataBase();
    this->updateModel();
}

ListModel::~ListModel()
{
    delete m_database;
}

// The method for obtaining an item data from the model
QVariant ListModel::data(const QModelIndex & index, int role) const
{
    // Define the column number, on the role of number
    int columnId = role - Qt::UserRole - 1;

    // Create the index using a column ID
    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

// The method sets and return roles name
QHash<int, QByteArray> ListModel::roleNames() const {

    QHash<int, QByteArray> roles;

    roles[IdRole] = "id";
    roles[FirstNameRole] = "rFirstName";
    roles[LastNameRole] = "rLastName";
    roles[EmailAddressRole] = "rEmail";

    return roles;
}

// The method updates the tables in the data model representation
void ListModel::updateModel()
{
    this->setQuery("SELECT id, " TABLE_FNAME ", " TABLE_LNAME ", " TABLE_EMAIL " FROM " TABLE);
}

// The method for Getting the id of the row in the data view model
int ListModel::getId(int row) const
{
    return this->data(this->index(row, 0), IdRole).toInt();
}

// The method for obtaining a row data from the model
Q_INVOKABLE QVariantMap ListModel::get(int row) const
{
    QVariantMap data;
    const QModelIndex idx = this->index(row,0);

    if( !idx.isValid() )
        return data;

    const QHash<int,QByteArray> rn = this->roleNames();

    QHashIterator<int, QByteArray> it(rn);

    while (it.hasNext()) {
        it.next();
        data[it.value()] = idx.data(it.key());
    }

    return data;
}

// The method for removing a row from the model
Q_INVOKABLE bool ListModel::remove(int row)
{
    if (m_database->removeRecord(this->getId(row))) {
        this->updateModel();
        return true;
    }
    return false;
}

// The method for adding a row in the model
Q_INVOKABLE bool ListModel::add(const QVariantMap &employee)
{
    if ( m_database->inserIntoTable(
             employee["firstName"].toString(),
             employee["lastName"].toString(),
             employee["emailAddress"].toString()
         ))
    {
        this->updateModel();
        return true;
    }
    return false;
}
// The method for updating a row in the model
Q_INVOKABLE bool ListModel::set(int row, const QVariantMap &employee)
{
    if (m_database->updateRow(this->getId(row),
                              employee["firstName"].toString(),
                              employee["lastName"].toString(),
                              employee["emailAddress"].toString()
          ))
      {
        this->updateModel();
        return true;
    }
    return false;
}



