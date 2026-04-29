docker build -t jaturon2526/dito-editor-mac-arm:2.0.5 .

docker run --rm --name dito-editor -p 8089:8080 -v /Users/jaturonp/iText/dito-editor-mac-2.0.5:/opt/dito/work jaturon2526/dito-editor-mac:2.0.5

docker run -it \
--name dito-editor \
-p 8089:8080 \
jaturon2526/dito-editor-mac:2.0.5

docker run -d --restart=on-failure:3 \
--name dito-editor \
-e PORT=8080 \
-p 8080:8080 \
-v dito-work:/opt/app/work \
-v dito-log:/opt/app/log \
jaturon2526/dito-editor:2.0.5

docker stop dito-editor && \
docker rm dito-editor && \
docker rmi jaturon2526/dito-editor-mac:2.0.5