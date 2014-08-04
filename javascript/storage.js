.import QtQuick.LocalStorage 2.0 as Sql

// Usage in QML-File
// ------------------
// import "javascript/storage.js" as Storage

// // Initialize the database
// Storage.initialize();

// // Sets a value in the database
// Storage.setSetting("mySetting","myValue");

// // Sets the textDisplay element's text to the value we just set
// console.log("The value of mySetting is:\n" + Storage.getSetting("mySetting_1"));


// First, let's create a short helper function to get the database connection
function getDatabase() {
    return Sql.LocalStorage.openDatabaseSync("Meth9", "1.0", "Settings", 100000);
}

// At the start of the application, we can initialize the tables we need if they haven't been created yet
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // Create the settings table if it doesn't already exist
                    // If the table exists, this is skipped
                    tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
                });
}

// This function is used to write a setting into the database
function setSetting(setting, value) {
    // setting: string representing the setting name (eg: “username”)
    // value: string representing the value of the setting (eg: “myUsername”)
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
        //console.log(rs.rowsAffected)
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}
// This function is used to retrieve a setting from the database
function getSetting(setting) {
    var db = getDatabase();
    var res="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        } else {
            res = "";
        }
    })
    // The function returns “Unknown” if the setting was not found in the database
    // For more advanced projects, this should probably be handled through error codes
    return res
}
