apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: mjbright-ingress

  annotations:
    kubernetes.io/ingress.class: "nginx"

  namespace: default
spec:

  rules:

  - host: quiz.com
    http:
      paths:
      - backend:
          service:
            name: quiz
            port:
              number: 80
        path: /
        pathType: ImplementationSpecific

  - host: vote.com
    http:
      paths:
      - backend:
          service:
            name: vote
            port:
              number: 80
        path: /
        pathType: ImplementationSpecific

  - host: web.com
    http:
      paths:
      - backend:
          service:
            #name: web
            name: web
            port:
              number: 80
        path: /
        pathType: ImplementationSpecific

