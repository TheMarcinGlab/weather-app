const express = require('express');
const router = express.Router();
const axios = require('axios');
const config = require('../config');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { weather: null, error: null });
});

/* POST weather request */
router.post('/', async function(req, res, next) {
  const city = req.body.city;
  const url = `${config.url}&q=${city}`;

  try {
    const response = await axios.get(url);
    const weather = response.data;

    if (!weather.main || !weather.name) {
      console.error(`No weather data was available for ${city}.`);
      return res.render('index', { weather: null, error: 'Error, please try again!' });
    }

    const weatherText = `It's ${weather.main.temp} degrees in ${weather.name}!`;
    console.log(`Found weather data for ${city}.`);
    res.render('index', { weather: weatherText, error: null });

  } catch (err) {
    console.error(`There was an error trying to lookup weather data for ${city}:`, err.message);
    res.render('index', { weather: null, error: 'Error, please try again!' });
  }
});

module.exports = router;
