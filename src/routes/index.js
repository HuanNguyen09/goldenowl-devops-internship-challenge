const { Router } = require('express')

const router = Router()

router.get('/', (req, res) => {
    const responseJson = {
        message: 'Welcome warriors to Golden Owl!!',
    }
    const clientIP =req.headers('x-forwarded-for');
    const elbIP = req.socket.remoteAddress;
    const containerIP = req.socket.localAddress;
    res.json({
        responseJson,
        clientIP: clientIP,
        elbIP: elbIP,
        containerIP: containerIP,
    });
})

module.exports = router
