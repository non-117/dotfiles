import requests
nona = lambda : requests.post( "https://openyo.nna774.net/yo/",{"api_ver":0.1,"api_token":"0b7cc841-5af7-450c-9329-e1daef58f089","username":"nona7"}).content
def rep(f, n, w):
    import time
    for i in range(n):
        f()
        time.sleep(w)
