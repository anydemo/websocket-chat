FROM golang:1.12 AS builder

# https://tutorialedge.net/golang/makefiles-for-go-developers/

# We create an /app directory in which
# we'll put all of our project code
RUN mkdir /app
ADD . /app
WORKDIR /app
# We want to build our application's binary executable
RUN make

# the lightweight scratch image we'll
# run our application within
FROM alpine:latest AS production
# We have to copy the output from our
# builder stage to our production stage
COPY --from=builder /app/bin/go-websocket go-websocket
# we can then kick off our newly compiled
# binary exectuable!!
CMD ["./go-websocket"]
