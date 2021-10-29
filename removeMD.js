const fs = require('fs');
// Gets the current directory
var getDirName = require('path').dirname;


// Takes the path as an argument
let path = process.argv?.[2];

// Calculates the filename
let fileName = path.substr(path.lastIndexOf('/') + 1);

const outPath = `tmp/without-md/${fileName}`;

// If options contains an output path
if (process.argv.length >= 4)
    outPath = process.argv?.[3]

try {
    // Load the notebook
    let notebook = fs.readFileSync(path);
    let json = JSON.parse(notebook);

    let newCells = []

    // Iterate through all the cells and only add the code cells
    for (let i in json.cells) {
        let cell = json.cells[i];
        // console.log(cell)
        if (cell.cell_type == "code")
            newCells.push(cell);
    }


    // Replace all from the notebook cells with only code ones
    json.cells = newCells;

    let out = JSON.stringify(json);

    // Write to the output path
    writeFile(`${outPath}`, out, () => { })

    console.log(`Markdown removed successfully.`);
    console.log(`"${outPath}" created successfully`);

} catch (err) {
    console.log(err.message)
}


function writeFile(path, contents, cb) {
    // Create directory and write the file
    fs.mkdir(getDirName(path), { recursive: true }, function (err) {
        if (err) {
            console.log(err.message);
            return
        }

        fs.writeFile(path, contents, cb);
    });
}