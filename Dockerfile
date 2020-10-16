FROM nginx:latest
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./jojoe.txt /usr/share/nginx/html/jojoe.txt
COPY ./jojoe2.txt /usr/share/nginx/html/jojoe2.txt

RUN chmod -R 777 /usr/share/nginx/html/*