# ELK-Stack-local-project
This is a workshop on platforms 2, in which we have to configure an ELK locally using minikube.

## Project Structure

```
ELKtaller/
├── deploy.sh
├── doc.pdf
├── elasticsearch/
│   ├── elasticsearch-statefulset.yaml
│   └── elasticsearch-service.yaml
├── kibana/
│   ├── kibana-deployment.yaml
│   └── kibana-service.yaml
├── filebeat/
│   ├── filebeat-configmap.yaml
│   ├── filebeat-daemonset.yaml
│   ├── filebeat-rbac.yaml
│   └── filebeat-serviceaccount.yaml
└── app/
    └── nginx-deployment.yaml
```

# ELK Stack Deployment on Minikube

This project deploys an ELK stack (Elasticsearch, Logstash, Kibana, Filebeat) in a local Kubernetes environment using Minikube and monitors a sample microservice (Nginx).

---

## Requirements

- Minikube (Docker driver recommended)
- Kubernetes CLI (`kubectl`)
- Docker

---

## Deployment Steps

### 1. Start Minikube

```bash
minikube start --driver=docker --cpus=4 --memory=7611 --disk-size=30g
```

---

### 2. Deploy the ELK Stack

Run the script from the project directory:

```bash
bash deploy.sh
```
![image](https://github.com/user-attachments/assets/060bf11c-5032-4ef9-9262-22896a670624)


> Note: The pods may take some time to reach the `Running` state. **Wait a few moments and verify their status before proceeding.**

---

### 3. Verify the ELK Deployment

```bash
kubectl get pods -n logging-stack
kubectl get deployments -n logging-stack
kubectl get daemonsets -n logging-stack
kubectl get services -n logging-stack
kubectl get configmaps -n logging-stack
```
![image](https://github.com/user-attachments/assets/87b9f968-7c3d-4f27-a376-cf7eef1e0cf3)

---

### 4. Verify the Sample App Deployment

```bash
kubectl get pods -n apps
kubectl get deployments -n apps
kubectl get services -n apps
kubectl get configmaps -n apps
```
![image](https://github.com/user-attachments/assets/0ad2e8e0-2482-48ff-87c5-3347760e4ca3)

---

### 5. Expose Services

#### Sample Nginx App

```bash
kubectl expose deployment nginx --port=80 --target-port=80 --type=NodePort -n apps
minikube service nginx -n apps
```

#### Kibana

In a separate terminal:

```bash
minikube service kibana -n logging-stack
```
---

## Configure Kibana

1. Go to Kibana using the provided URL.
   ![image](https://github.com/user-attachments/assets/860c6740-0217-406e-a0fe-afae52ea4598)
   ![image](https://github.com/user-attachments/assets/30c871c7-8423-414f-adfe-79505da089ba)


3. Click on **"Create index pattern"**.
4. Enter the index pattern name, e.g.:

   ```
   filebeat-*
   ```
![image](https://github.com/user-attachments/assets/4f5fda69-6175-406b-be7b-18dae980d3ea)

   *(The name may vary depending on your configuration.)*

5. Select the timestamp field (`@timestamp` or similar).
6. Click **"Create index pattern"**.

---

Done! You should now be able to visualize logs from the Nginx microservice in Kibana.
![image](https://github.com/user-attachments/assets/eefb6ae0-6045-46cf-b86b-19b813ebb0a8)
![image](https://github.com/user-attachments/assets/01cc84b6-dcb6-4620-83f0-486b909c0086)

---
---

## Credits

This setup was created with the helpful guidance of [ChatGPT](https://openai.com/chatgpt) 


2025 - Platforms II Workshop · Telematics Engineering
