
REMEMBER:
    kubectl label ns default  environment=test
TO UNDO:
    kubectl label ns default  environment- --overwrite

See https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/


TODO:
- How to prevent scaling past limit -> See 2nd policy rule on deployments/scale

