const path = require('path');

module.exports = {
    allowedDevOrigins: ['a-cable', 'a-cable-api'],
    images: {
        dangerouslyAllowLocalIP: true,
        remotePatterns: [new URL(`${process.env.NEXT_PUBLIC_IMAGES_URL}/**`)],
        qualities: [75, 100],
    },
    sassOptions: {
        includePaths: [path.join(__dirname, 'app')],
    },
};