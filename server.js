var express = require('express');
var app = express();
var bodyParser = require('body-parser')
const say = require('say')

app.use(bodyParser())
app.use(express.static('public'))

// reply to request with "Hello World!"
app.get('/', function (req, res) {
  res.send('Hello Theodo!');
});

app.post('/say/', function (req, res) {
  const body = req.body;
  const text = body.name_field;
  const voice = body.voice_name;
  var sys  = require('util'),
      exec = require('child_process').exec,
      child;
  child = exec(`espeak "${text}"`, function (error, stdout, stderr) 
    {
        if (error) // There was an error executing our script
        {
            console.log(error)
        }

        return res.status(200).send(stdout); // Show output in this case the success message
    });
});



//start a server on port 80 and log its start to our console
var server = app.listen(80, function () {

  var port = server.address().port;
  console.log('Example app listening on port ', port);

});
