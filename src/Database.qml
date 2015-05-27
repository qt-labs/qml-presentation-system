import QtQuick 2.0
import QtQuick.LocalStorage 2.0

// http://qt-project.org/doc/qt-5/qtquick-localstorage-qmlmodule.html
// http://developer.nokia.com/community/wiki/How-to_create_a_persistent_settings_database_in_Qt_Quick_%28QML%29

Item {

    property var db

    Component.onCompleted: {
        initialize();
    }

    function getDatabase() {
         return LocalStorage.openDatabaseSync("SDUPresentation", "1.0", "StorageDatabase", 100000);
    }

    function initialize() {
        db = LocalStorage.openDatabaseSync("QtPresentation", "1.0", "presentationdb", 100000,db);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
          });
    }

    // The function returns “OK” if it was successful, or “Error” if it wasn't
    function setSetting(setting, value) {
       var res = "";
       db.transaction(function(tx) {
            var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
                  if (rs.rowsAffected > 0) {
                    res = "OK";
                  } else {
                    res = "Error";
                  }
            }
      );
      return res;
    }

    // The function returns “Unknown” if the setting was not found in the database
    function getSetting(setting) {
       var res="";
       db.transaction(function(tx) {
         var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
         if (rs.rows.length > 0) {
              res = rs.rows.item(0).value;
         } else {
             res = "NULL";
         }
      })
      return res
    }
}



