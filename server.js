const
  express = require('express'),
  app = express(),
  ws = require('express-ws')(app),
  PORT = 5001,
  clients = []

app.listen(PORT, () => console.log(`Listening on port ${PORT}`))

app.ws('/connect', (sock, req) => {
  console.log('Client connected')

  clients.push(sock)

  sock.on('message', msg => {
    for(const cli of clients) {
      if(1 === cli.readyState) {
        cli.send(msg)
      }
    }
  })
})
