1. Kiểm tra lại trạng thái của pod và service trong Kubernetes
1.1. Kiểm tra các pod:
Chạy lệnh sau để kiểm tra trạng thái của các pod trong namespace default
kubectl get pods -n default

1.2. Kiểm tra các service:
Chạy lệnh này để kiểm tra trạng thái của các service trong namespace default:
kubectl get svc -n default

2. Kiểm tra xem Deployment đã tạo service chưa
Dưới đây là một ví dụ về cách tạo một service cho ứng dụng trong deployment.yaml:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: go-docker-app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: go-docker-app
  template:
    metadata:
      labels:
        app: go-docker-app
    spec:
      containers:
      - name: go-docker-app
        image: go-docker-app:latest
        ports:
        - containerPort: 8080

---
apiVersion: v1
kind: Service
metadata:
  name: go-docker-app-service
spec:
  selector:
    app: go-docker-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: NodePort

Áp dụng lại tệp deployment.yaml:
kubectl apply -f deployment.yaml

3. Truy cập Service thông qua Minikube
3.1. Kiểm tra danh sách các dịch vụ của Minikube:
minikube service list

3.2. Truy cập service bằng Minikube:
minikube service go-docker-app-service -n default

4. Xử lý Namespace
Nếu bạn đang sử dụng một namespace khác ngoài default, hãy chắc chắn rằng bạn cung cấp đúng namespace khi truy cập service.
minikube service go-docker-app-deployment-866b745f98-887tt -n my-app

5. Kiểm tra lại quá trình tạo pod và service
kubectl logs go-docker-app-deployment-866b745f98-887tt

Tóm Tắt:
Kiểm tra lại trạng thái của pod và service bằng các lệnh kubectl get pods -n default và kubectl get svc -n default.
Đảm bảo rằng bạn đã cấu hình đúng tệp deployment.yaml, bao gồm cả service.
Sử dụng minikube service list để xác minh rằng service đã được tạo ra và có thể truy cập.
Nếu có namespace khác, hãy chắc chắn rằng bạn sử dụng -n <namespace> khi truy cập.
Sau khi kiểm tra và cấu hình lại các yếu tố trên, bạn sẽ có thể truy cập được service mà không gặp phải lỗi SVC_NOT_FOUND.


Scale Up hoặc Scale Down Deployment
  Scale Up (Tăng số lượng replicas):
    kubectl scale deployment go-docker-app-deployment --replicas=5
  Scale Down (Giảm số lượng replicas):
    kubectl scale deployment go-docker-app-deployment --replicas=2

Sử Dụng Horizontal Pod Autoscaler (Tự Động Scale Dựa Trên Tải)
 kubectl autoscale deployment go-docker-app-deployment --cpu-percent=50 --min=2 --max=10
