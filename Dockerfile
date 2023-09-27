FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.21.1 as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR /workspace

COPY go.mod go.mod
COPY go.sum go.sum

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -a -o /go/bin/motiong-cli ./cmd/

FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine

COPY --from=builder /go/bin/motiong-cli /usr/local/bin/motiong-cli

ENTRYPOINT ["/usr/local/bin/motiong-cli"]
