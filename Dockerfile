# Bước 1: Sử dụng image Go chính thức
FROM golang:1.23-alpine AS builder

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Copy mã nguồn vào container
COPY . .

# Tải dependencies và biên dịch ứng dụng
RUN go mod tidy
RUN go build -o main .

# Bước 2: Chạy ứng dụng Go trong một image nhẹ hơn
FROM alpine:latest

WORKDIR /root/

# Copy ứng dụng từ builder image
COPY --from=builder /app/main .

# Mở cổng 8080
EXPOSE 8080

# Chạy ứng dụng
CMD ["./main"]
