
# FROM golang:onbuild
# EXPOSE 8500

FROM golang AS build-env
WORKDIR /go/src/
RUN go get -d -v github.com/gorilla/mux
COPY main.go . 
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# final stage
FROM alpine
WORKDIR /root/
COPY --from=build-env /go/src/main .   
CMD ["./main"]
EXPOSE 8500