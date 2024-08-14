
# TODO:

After cluster creation, determine my control node ip address (of trainer-ckad-0.mjbright.click for example)

Go to ~/z/TRAININGS.SETUP/IT.COMPONENTS/AWS_DNS/quiz-and-vote.mjbright.click/
   enter control_ip address for each entry in dns.tf

Then run ./ingress-setup.sh
   initially use ingress.yaml.0
   then add features ...

NOTE: Use of default-backend annotation in ingress.yaml.default-backend
    # NOTE: this used to route to backend services which have 0 endpoints, i.e. are scaled to 0 pods
    #       it is not a default handler for lack of a matching rule - how to do that ?

NOTE: Demonstrate use of curl -X -H "Host: vote.mjbright.click"

NOTE: Demonstrate also use of /etc/hosts

       Put nginx-ingress-controller Cluster IP address in /etc/hosts for vote.com, quiz.com, web.com

       Modify   ingress.yaml to use vote.com, quiz.com, web.com

       curl -X -sL vote.com


