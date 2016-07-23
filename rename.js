const glob = require('glob');
const fs = require('fs');
const moment = require('moment');

const directory = process.argv[2];

glob(`${directory}/**/*.@(jpeg|jpg|JPG)`, (err, files) => {
  if (err) { throw err; }
  files.forEach((filename) => {
    fs.stat(filename, (err, stats) => {
      const newName = moment(stats.birthtime).format('YYYY-MM-DDTHHmmss');
      const ext = filename.split('.').pop();
      let path = filename.split('/');
      path.pop();

      const newPath = `${path.join('/')}/${newName}.${ext}`.replace(/\:/g, '-');
      fs.rename(filename, newPath, (err) => {
        if (err) { throw err; }
        console.log('File renamed.');
      });
    });
  });
});
