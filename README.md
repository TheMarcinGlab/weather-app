docker build --no-cache --build-arg VERSION=1.0.0 -t weather-app:latest .


docker run -d -p 3000:3000 --name weather-app-container weather-app:latest