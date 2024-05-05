const fs = require('fs');
const path = require('path');
const sqlite3 = require('sqlite3').verbose();

// Function to read files from a directory
function readFilesFromDir(dir) {
    return new Promise((resolve, reject) => {
        fs.readdir(dir, (err, files) => {
            if (err) {
                reject(err);
            } else {
                resolve(files);
            }
        });
    });
}

// Function to extract itemID and type from file name
function extractInfoFromFileName(fileName) {
    const parts = fileName.split('-'); // Assuming the file name format is "itemID-type.png"
    const itemID = parts[0];
    const type = parts[1].split('.')[0]; // Remove the file extension
    return { itemID, type };
}

// Function to insert data into SQLite database
function insertIntoDatabase(db, itemID, type, imagePath) {
    db.run(`INSERT INTO items (itemID, type, imagesrc) VALUES (?, ?, ?)`, [itemID, type, imagePath], (err) => {
        if (err) {
            console.error('Error inserting into database:', err);
        } else {
            console.log(`Inserted item with itemID ${itemID}, imagepath ${imagePath} and type ${type} into the database.`);
        }
    });
}

// Main function to read files, extract info, and insert into database
async function processFilesAndInsertIntoDB(dirPath) {
    const db = new sqlite3.Database('items.db'); // Connect to the SQLite database

    try {
        const files = await readFilesFromDir(dirPath);
        files.forEach(fileName => {
            const { itemID, type } = extractInfoFromFileName(fileName);
            const imagePath = path.join(dirPath, fileName);
            insertIntoDatabase(db, itemID, type, imagePath);
        });
    } catch (error) {
        console.error('Error processing files:', error);
    } finally {
        db.close(); // Close the database connection
    }
}

// Usage: Specify the directory path here
const directoryPath = 'images/'; // Update this with your directory path
processFilesAndInsertIntoDB(directoryPath);
