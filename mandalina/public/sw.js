var CACHE_NAME = 'filmdizimob-v1.65';
var urlsToCache = [
    //'/',
    //'/styles/main.css',
    //'/script/main.js'
];

self.addEventListener('install', function (event) {
    self.skipWaiting();
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(function (cache) {
                console.log('Opened cache');
                return cache.addAll(urlsToCache);
            })
    );
});



self.addEventListener('activate', function (event) {

    var cacheAllowlist = [CACHE_NAME];

    event.waitUntil(
        caches.keys().then(function (cacheNames) {
            return Promise.all(
                cacheNames.map(function (cacheName) {
                    if (cacheAllowlist.indexOf(cacheName) === -1) {
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
});

self.addEventListener('push', function (event) {
    let data = event.data.json()
    if (!(self.Notification && self.Notification.permission === 'granted')) {
        return;
    }
    const title = data.title;
    const options = {
        body: data.body,
        icon: data.icon,
        badge: data.badge,
        image: data.image,
        data: {
            url: data.url
        }
    };

    event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener('notificationclick', function (event) {

    if (event.notification.data.url) {
        clients.openWindow(event.notification.data.url);
    }
}
    , false);