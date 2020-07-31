export default {
    convertTurkish2English(phrase) {
        var maxLength = 100;

        var returnString = phrase.toLowerCase();
        //Convert Characters
        returnString = returnString.replace(/ö/g, 'o');
        returnString = returnString.replace(/ç/g, 'c');
        returnString = returnString.replace(/ş/g, 's');
        returnString = returnString.replace(/ı/g, 'i');
        returnString = returnString.replace(/ğ/g, 'g');
        returnString = returnString.replace(/ü/g, 'u');

        // if there are other invalid chars, convert them into blank spaces
        returnString = returnString.replace(/[^a-z0-9\s-]/g, "");
        // convert multiple spaces and hyphens into one space       
        returnString = returnString.replace(/[\s-]+/g, " ");
        // trims current string
        returnString = returnString.replace(/^\s+|\s+$/g, "");
        // cuts string (if too long)
        if (returnString.length > maxLength)
            returnString = returnString.substring(0, maxLength);
        // add hyphens
        returnString = returnString.replace(/\s/g, "-");

        return returnString
    },
    getDbVersion() {
        return 1;
    },
    getMovieTypeForDb(type) {
        var objName = null;
        if (type == 1)
            objName = "movies"
        else if (type == 2)
            objName = "series"
        else { return }

        return objName;
    },
    openUserDb(version) {
        var db;
        var request = window.indexedDB.open("userMovies", version);

        request.onerror = function (event) {
            console.log("Error happens when request to DB: " + event.target.errorCode)
        };
        request.onsuccess = function (event) {
            db = event.target.result
        };

        request.onupgradeneeded = function (event) {
            var db = event.target.result;

            // Create an objectStore for this database
            var movieObjectStore = db.createObjectStore("movies", { keyPath: "id" });
            var serieObjectStore = db.createObjectStore("series", { keyPath: "id" });
        };

        return request;
    },
    addMovie2db(db, movie, type) {
        movie.watchedTime = null;
        var objName = this.getMovieTypeForDb(type);


        var transaction = db.transaction([objName], "readwrite");

        transaction.oncomplete = function (event) {
            console.log("Movie Transaction is opened");
        };

        transaction.onerror = function (event) {
            console.log("Movie Transaction gives an error: " + event.target.result);
        };

        var objectStore = transaction.objectStore(objName);
        var request = objectStore.add(movie);
        request.onsuccess = function (event) {
            console.log(event.target.result)
        };
    },
    deleteMovieFromDb(db, movie, type) {
        var objName = this.getMovieTypeForDb(type)

        var request = db.transaction([objName], "readwrite")
            .objectStore(objName)
            .delete(movie.id);
        request.onsuccess = function (event) {
            console.log(`${movie.id} is deleted`)
        };
    },
    getAllMoviesFromDb(db, type) {
        var objName = this.getMovieTypeForDb(type)

        db.transaction(objName).objectStore(objName).getAll().onsuccess = function (event) {
            return event.target.result;
        };
    },
    getTimeFromMovieInDb(db, movie, type) {
        var objName = this.getMovieTypeForDb(type)

        db.transaction(objName).objectStore(objName).get(movie.id).onsuccess = function (event) {
            return event.target.result.watchedTime;
        };
    },
    setTimeToMovieInDb(db, movie, type, time) {
        var objName = this.getMovieTypeForDb(type)

        var objectStore = db.transaction([objName], "readwrite").objectStore(objName);
        var request = objectStore.get(movie.id);
        request.onerror = function (event) {
            console.log("Error happend when set time: " + event.target.result)
        };
        request.onsuccess = function (event) {
            var data = event.target.result;

            data.watchedTime = time;

            var requestUpdate = objectStore.put(data);
            requestUpdate.onerror = function (event) {
                console.log("Error occured when time is setted: " + event.target.result)
            };
            requestUpdate.onsuccess = function (event) {
                console.log("Time setted")
            };
        };
    }

}