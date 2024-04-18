const { Router } = require('express');

const router = Router();

router.get('/', (req, res) => {
    const responseJson = {
        message: 'Welcome warriors to Golden Owl!!',
    };
    const clientIP = req.headers['x-forwarded-for'];
    const elbIP = req.headers['x-forwarded-host'];
    const containerIP = req.hostname; // Assuming this represents the container IP
    res.json({
        responseJson,
        clientIP: clientIP,
        elbIP: elbIP,
        containerIP: containerIP,
    });
});

module.exports = router;
