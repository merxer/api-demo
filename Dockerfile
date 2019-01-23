FROM golang:1.11.4-stretch as firststage
WORKDIR /go/src
ADD . .
RUN GOPATH=/go && export GOPATH &&  \
    go get -v github.com/labstack/echo  && \
    go get -v github.com/labstack/echo/middleware  && \
    go get -u golang.org/x/sys/cpu && \
    go get -u golang.org/x/sys/unix && \
    GOOS=linux GOARCH=386 go build api.go


FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=firststage /go/src/api .
EXPOSE 1323
CMD ["./api"] 
