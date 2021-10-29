const fs = require('fs');
// Gets the current directory
var getDirName = require('path').dirname;


// Takes the path as an argument
let path = process.argv?.[2];

const outPath = `tmp/without-md/${path}`;

// If contains an output path
if (process.argv.length >= 4)
    outPath = process.argv?.[3]

try {

    let script = fs.readFileSync(path);
    let json = JSON.parse(script);

    let newCells = []

    for (let i in json.cells) {
        let cell = json.cells[i];
        // console.log(cell)
        if (cell.cell_type != "markdown")
            newCells.push(cell);
    }


    // Replace all cells with only code ones
    json.cells = newCells;

    let out = JSON.stringify(json);


    writeFile(`${outPath}`, out, () => { })

    console.log(`Markdown removed successfully.`);
    console.log(`"${outPath}" created successfully`);

} catch (err) {
    console.log(err.message)
}


function writeFile(path, contents, cb) {
    fs.mkdir(getDirName(path), { recursive: true }, function (err) {
        if (err) {
            console.log(err.message);
            return
        }

        fs.writeFile(path, contents, cb);
    });
}