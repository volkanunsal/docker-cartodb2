'use strict';

var http      = require('http'),
    https     = require('https'),
    connect   = require('connect'),
    basicAuth = require('basic-auth'),
    httpProxy = require('http-proxy')
;

/**
 * Proxy class
 * @param  {String} target  Destination url
 * @param  {[type]} headers Header, example for SSL { host: 'www.mydomain.ru'}
 * @param  {[type]} auth    Auth object {user: 'username', pass: 'password'}
 * @return {Void}
 */
function Proxy(target, port, headers, auth) {
    var self = this,
        proxy
    ;

    self.app  = connect();
    this.port = port;

    // Create a HTTP Proxy server with a HTTPS target
    proxy = httpProxy.createProxyServer({
        target: target,
        agent: https.globalAgent,
        headers: headers
    });

    /// Auth middleware
    self.app.use(function(req, res, next) {
        var user = basicAuth(req);

        if (user && user.name === auth.user && user.pass === auth.pass) {
            next();
        } else {
            res.statusCode = 401;
            next('Auth required!');
        }
    });

    /// Proxing
    self.app.use(function(req, res) {
        proxy.web(req, res);
    });
}

Proxy.prototype.run = function(cb) {
    var self = this,
        adress = 'http://127.0.0.1:' + self.port
    ;

    http.createServer(self.app).listen(self.port, function() {
        if (typeof cb === 'function') {
            cb(adress);
        }
    });
};

exports = module.exports = Proxy;
