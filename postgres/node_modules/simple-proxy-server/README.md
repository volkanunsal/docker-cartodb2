simple-proxy-server
===================

Simple HTTP to HTTPs proxy server

Installation
===================

```bash
npm install simple-proxy-server --save
```

Basic Usage
===================

```javascript
var Proxy = require('simple-proxy-server'),
    p = new Proxy(
        'https://www.domain.ru',     // target destination
        8080,                        // port to listen on
        {host: 'www.domain.ru'},     // host for SSL
        {user: 'user', pass: 'pass'} // Basic Auth credentials for your proxy
    )
;

p.run(function(adress) {
    console.log('http proxy server %s', adress);
});
```