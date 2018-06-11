siege -c255 -t120S --content-type "application/json" 'http://52.170.135.165:4000/heroes POST { "name": "Batman", "power": "Inteligencia"}'

kubectl delete pod -l app=api-heroes