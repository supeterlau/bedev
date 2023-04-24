// server.js

/*

https://blog.risingstack.com/your-first-node-js-http-server/
https://stackoverflow.com/questions/5998694/how-to-create-an-https-server-in-node-js

handle image/html/js/css/audio/video

*/

const http = require('http')
const port = process.env.PORT || 3030

const reqHandler = (req, res) => {
  // req.url is endpoint(route) or file path

  console.log(JSON.stringify(req.headers))
  console.log(req.url)
  res.headers = {
    'content-type': 'application/json'
  }
  // res.end('a Node.js Server')
  res.end(JSON.stringify({'Hello': 'Node.js Server'}))
}

const server = http.createServer(reqHandler)

server.listen(port, (err) => {
  if (err) return console.log('Error: ', err)
  
  console.log(`server is listening on port ${port}`)
})

// Debugging Express
// DEBUG=express* node index.js