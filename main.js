'use strict';

var localStorageKey = 'googleappsscript-firebase-elm';
var storedState = localStorage.getItem(localStorageKey);
var startingState = storedState ? JSON.parse(storedState) : null;
var elm = Elm.Main.fullscreen(startingState);

elm.ports.setStorage.subscribe(function (state) {
    localStorage.setItem(localStorageKey, JSON.stringify(state));
});


var config = {
    apiKey: "<FIREBASE-API-KEY>",
    databaseURL: "https://<FIREBASE-URL>.firebaseio.com",
    messagingSenderId: "<FIREBASE-MESSAGING-SENDER-ID>"
};

firebase.initializeApp(config);

var pocasi = firebase.database().ref('pocasi').limitToLast(60);;

pocasi.on('child_added', function (snapshot) {
    elm.ports.add.send(snapshot.val());
});
