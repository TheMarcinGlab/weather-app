Polecenia do zbudowania obrazu:

docker buildx build --no-cache \
  --build-arg VERSION=1.0.0 \
  --platform linux/amd64 \
  -t weather-app:1.0 \
  --load \
  .




Polecenie do uruchomienia obrazu:
docker run -d -p 3000:3000 --name weather-app-container weather-app:1.0


GitHub: https://github.com/TheMarcinGlab/weather-app

DockerHub: https://hub.docker.com/repository/docker/marcin002/weather-app/general


!["Pomyślny push do DockerHub"](zdjecia/pomyślnyPushDoHub.png)


!["Potwierdzenie działania kontenera"](zdjecia/działaLokalnieObraz.png)

