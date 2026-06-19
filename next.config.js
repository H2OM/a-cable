const path = require('path');

module.exports = {
    allowedDevOrigins: ['diplom','a-cable'],
    images: {
        qualities: [75, 100],
    },
    sassOptions: {
        includePaths: [path.join(__dirname, 'app')],
    },
};