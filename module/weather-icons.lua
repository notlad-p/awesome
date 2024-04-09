-- openweathermap icon codes
local icons = {
  ["01d"] = "clear-sky",
  ["02d"] = "few-clouds",
  ["03d"] = "scattered-clouds",
  ["04d"] = "scattered-clouds", -- indicator is for 'broken-clouds' but I reused scattered-clouds because it's the same
  ["09d"] = "shower-rain",
  ["10d"] = "rain",
  ["11d"] = "thunderstorm",
  ["13d"] = "snow",
  ["50d"] = "mist",
  ["01n"] = "clear-sky-night",
  ["02n"] = "few-clouds-night",
  ["03n"] = "scattered-clouds",
  ["04n"] = "scattered-clouds",
  ["09n"] = "shower-rain",
  ["10n"] = "rain-night",
  ["11n"] = "thunderstorm",
  ["13n"] = "snow",
  ["50n"] = "mist",
}

return icons
