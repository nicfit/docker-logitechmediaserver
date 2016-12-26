.PHONY: image clean squeezeserver

IMG_NAME ?= squeezeserver
CONT_NAME ?= squeezeserver
MUSIC_DIR ?= ~/Music
DATA_DIR ?= /opt/squeezeserver

image:
	docker build -t ${IMG_NAME} .

clean:
	docker rmi ${IMG_NAME}

squeezeserver: image
	docker create --name ${CONT_NAME} \
      --publish 3483:3483 \
      --publish 3483:3483/udp \
      --publish 9000:9000 \
      --volume /etc/localtime:/etc/localtime:ro \
      --volume ${DATA_DIR}:/config \
      --volume ${MUSIC_DIR}:/music:ro \
      ${IMG_NAME}
