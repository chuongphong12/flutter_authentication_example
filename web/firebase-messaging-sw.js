importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js');

firebase.initializeApp({
	apiKey: 'AIzaSyBZuUEEO8_gLbswPoEFtd68sfbREbV2lfk',
	authDomain: 'flutter-authentication-93518.firebaseapp.com',
	projectId: 'flutter-authentication-93518',
	storageBucket: 'flutter-authentication-93518.appspot.com',
	messagingSenderId: '618035919595',
	appId: '1:618035919595:web:ddbd56e9f094de106f5cae',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
	console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
});
