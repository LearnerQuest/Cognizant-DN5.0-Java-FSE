"use strict";

/* =========================================================
   1. JAVASCRIPT BASICS AND SETUP
   ========================================================= */

console.log("Welcome to the Community Portal");

window.addEventListener("load", function () {
    alert("Community Portal loaded successfully.");
});


/* =========================================================
   2. SYNTAX, DATA TYPES AND OPERATORS
   ========================================================= */

const portalName = "Local Community Event Portal";
const portalYear = 2026;
let totalAvailableSeats = 95;

console.log(`${portalName} is active in ${portalYear}.`);
console.log(`Total available seats: ${totalAvailableSeats}`);


/* =========================================================
   3. EVENT CLASS, OBJECTS AND PROTOTYPES
   ========================================================= */

class Event {
    constructor(id, title, category, date, location, seats) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.date = date;
        this.location = location;
        this.seats = seats;
    }

    checkAvailability() {
        return this.seats > 0;
    }
}

Event.prototype.getSummary = function () {
    return `${this.title} at ${this.location}`;
};


/* =========================================================
   4. EVENT ARRAY
   ========================================================= */

let events = [
    new Event(
        1,
        "Tech Innovators Meetup",
        "Technology",
        "2026-07-20",
        "Mathura",
        30
    ),

    new Event(
        2,
        "Community Music Festival",
        "Music",
        "2026-07-22",
        "Delhi",
        20
    ),

    new Event(
        3,
        "Frontend Development Workshop",
        "Workshop",
        "2026-07-25",
        "Noida",
        25
    ),

    new Event(
        4,
        "Artificial Intelligence Seminar",
        "Technology",
        "2026-07-28",
        "Agra",
        20
    )
];


/* =========================================================
   5. DOM REFERENCES
   ========================================================= */

const eventContainer = document.querySelector("#eventContainer");
const categoryFilter = document.querySelector("#categoryFilter");
const searchInput = document.querySelector("#searchInput");
const selectedEvent = document.querySelector("#selectedEvent");
const spinner = document.querySelector("#spinner");


/* =========================================================
   6. FUNCTIONS, CALLBACKS AND HIGHER-ORDER FUNCTIONS
   ========================================================= */

function addEvent(eventObject) {
    events.push(eventObject);
    displayEvents(events);
    populateEventDropdown();
}

function filterEventsByCategory(category, callback) {
    const filteredEvents =
        category === "all"
            ? [...events]
            : events.filter(event => event.category === category);

    callback(filteredEvents);
}

function searchEvents(searchText, callback) {
    const filteredEvents = events.filter(event =>
        event.title.toLowerCase().includes(searchText.toLowerCase())
    );

    callback(filteredEvents);
}


/* =========================================================
   7. CLOSURE TO TRACK REGISTRATIONS
   ========================================================= */

function createRegistrationTracker() {
    let registrationCount = 0;

    return function () {
        registrationCount++;
        return registrationCount;
    };
}

const trackRegistration = createRegistrationTracker();


/* =========================================================
   8. CONDITIONALS, LOOPS AND ERROR HANDLING
   ========================================================= */

function getValidUpcomingEvents(eventList) {
    const today = new Date();

    return eventList.filter(event => {
        const eventDate = new Date(event.date);

        if (eventDate >= today && event.seats > 0) {
            return true;
        }

        return false;
    });
}

function registerUser(eventId) {
    try {
        const event = events.find(item => item.id === eventId);

        if (!event) {
            throw new Error("Event not found.");
        }

        if (!event.checkAvailability()) {
            throw new Error("No seats available.");
        }

        event.seats--;
        totalAvailableSeats--;

        const totalRegistrations = trackRegistration();

        document.querySelector("#closureOutput").textContent =
            `Total registrations tracked using closure: ${totalRegistrations}`;

        displayEvents(events);
        populateEventDropdown();

        alert(`Registration successful for ${event.title}`);
    } catch (error) {
        alert(error.message);
        console.error(error);
    }
}

function cancelRegistration(eventId) {
    const event = events.find(item => item.id === eventId);

    if (event) {
        event.seats++;
        totalAvailableSeats++;

        displayEvents(events);
        populateEventDropdown();

        alert(`Registration cancelled for ${event.title}`);
    }
}


/* =========================================================
   9. DOM MANIPULATION
   ========================================================= */

function displayEvents(eventList) {
    eventContainer.innerHTML = "";

    const upcomingEvents = getValidUpcomingEvents(eventList);

    if (upcomingEvents.length === 0) {
        eventContainer.innerHTML = "<p>No matching events found.</p>";
        return;
    }

    upcomingEvents.forEach(event => {
        const card = document.createElement("div");
        card.className = "event-card";

        const title = document.createElement("h3");
        title.textContent = event.title;

        const category = document.createElement("p");
        category.textContent = `Category: ${event.category}`;

        const date = document.createElement("p");
        date.textContent = `Date: ${event.date}`;

        const location = document.createElement("p");
        location.textContent = `Location: ${event.location}`;

        const seats = document.createElement("p");
        seats.textContent = `Available seats: ${event.seats}`;

        const registerButton = document.createElement("button");
        registerButton.textContent = "Register";
        registerButton.onclick = function () {
            registerUser(event.id);
        };

        const cancelButton = document.createElement("button");
        cancelButton.textContent = "Cancel";
        cancelButton.className = "cancel-btn";
        cancelButton.onclick = function () {
            cancelRegistration(event.id);
        };

        card.append(
            title,
            category,
            date,
            location,
            seats,
            registerButton,
            cancelButton
        );

        eventContainer.appendChild(card);
    });
}

function populateEventDropdown() {
    selectedEvent.innerHTML =
        '<option value="">Choose an event</option>';

    events.forEach(event => {
        if (event.seats > 0) {
            const option = document.createElement("option");

            option.value = event.id;
            option.textContent =
                `${event.title} (${event.seats} seats)`;

            selectedEvent.appendChild(option);
        }
    });
}


/* =========================================================
   10. ARRAY METHODS AND MODERN JAVASCRIPT
   ========================================================= */

const musicEvents = events.filter(
    event => event.category === "Music"
);

const formattedEventNames = events.map(
    event => `${event.category}: ${event.title}`
);

const clonedEventList = [...events];

const [firstEvent] = events;

const {
    title: firstEventTitle,
    location: firstEventLocation
} = firstEvent;

document.querySelector("#arrayOutput").textContent =
    `Music events: ${musicEvents.length}. Formatted list: ${formattedEventNames.join(
        " | "
    )}`;

document.querySelector("#objectOutput").textContent =
    `Object entries: ${Object.entries(firstEvent)
        .map(([key, value]) => `${key}=${value}`)
        .join(", ")}. First event: ${firstEventTitle}, ${firstEventLocation}. Cloned events: ${clonedEventList.length}`;


/* =========================================================
   11. FILTER AND KEYBOARD EVENT HANDLING
   ========================================================= */

categoryFilter.addEventListener("change", function () {
    filterEventsByCategory(this.value, displayEvents);
});

searchInput.addEventListener("keydown", function () {
    setTimeout(() => {
        searchEvents(this.value, displayEvents);
    }, 0);
});


/* =========================================================
   12. ADD EVENT FORM
   ========================================================= */

document
    .querySelector("#addEventForm")
    .addEventListener("submit", function (event) {
        event.preventDefault();

        const title = document.querySelector("#newTitle").value.trim();
        const category =
            document.querySelector("#newCategory").value;
        const date = document.querySelector("#newDate").value;
        const location =
            document.querySelector("#newLocation").value.trim();
        const seats =
            Number(document.querySelector("#newSeats").value);

        const newEvent = new Event(
            Date.now(),
            title,
            category,
            date,
            location,
            seats
        );

        addEvent(newEvent);

        document.querySelector("#addEventMessage").textContent =
            "New event added successfully.";

        document.querySelector("#addEventMessage").className =
            "message success";

        this.reset();
    });


/* =========================================================
   13. REGISTRATION FORM AND VALIDATION
   ========================================================= */

document
    .querySelector("#registrationForm")
    .addEventListener("submit", function (event) {
        event.preventDefault();

        const formElements = this.elements;

        const name = formElements["userName"].value.trim();
        const email = formElements["userEmail"].value.trim();
        const eventId = Number(
            formElements["selectedEvent"].value
        );

        let isValid = true;

        document.querySelector("#nameError").textContent = "";
        document.querySelector("#emailError").textContent = "";
        document.querySelector("#eventError").textContent = "";

        if (name.length < 3) {
            document.querySelector("#nameError").textContent =
                "Name must contain at least 3 characters.";

            isValid = false;
        }

        const emailPattern =
            /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test(email)) {
            document.querySelector("#emailError").textContent =
                "Enter a valid email address.";

            isValid = false;
        }

        if (!eventId) {
            document.querySelector("#eventError").textContent =
                "Please select an event.";

            isValid = false;
        }

        if (!isValid) {
            return;
        }

        registerUser(eventId);

        document.querySelector("#registrationMessage").textContent =
            `Registration submitted successfully for ${name}.`;

        document.querySelector("#registrationMessage").className =
            "message success";

        this.reset();
    });


/* =========================================================
   14. ASYNC JAVASCRIPT, PROMISES AND FETCH
   ========================================================= */

function loadEventsUsingThen() {
    spinner.style.display = "block";

    fetch("events.json")
        .then(response => {
            if (!response.ok) {
                throw new Error("Unable to load event data.");
            }

            return response.json();
        })
        .then(data => {
            events = data.map(
                event =>
                    new Event(
                        event.id,
                        event.title,
                        event.category,
                        event.date,
                        event.location,
                        event.seats
                    )
            );

            displayEvents(events);
            populateEventDropdown();
        })
        .catch(error => {
            console.error(error);

            alert("JSON events could not be loaded.");
        })
        .finally(() => {
            spinner.style.display = "none";
        });
}

async function loadEventsUsingAsyncAwait() {
    spinner.style.display = "block";

    try {
        const response = await fetch("events.json");

        if (!response.ok) {
            throw new Error("Unable to load event data.");
        }

        const data = await response.json();

        events = data.map(
            event =>
                new Event(
                    event.id,
                    event.title,
                    event.category,
                    event.date,
                    event.location,
                    event.seats
                )
        );

        displayEvents(events);
        populateEventDropdown();
    } catch (error) {
        console.error(error);

        alert("Error while loading JSON events.");
    } finally {
        spinner.style.display = "none";
    }
}

document
    .querySelector("#loadEventsBtn")
    .addEventListener("click", loadEventsUsingAsyncAwait);


/* =========================================================
   15. AJAX POST REQUEST
   ========================================================= */

async function sendRegistrationToServer(userData) {
    try {
        const response = await fetch(
            "https://jsonplaceholder.typicode.com/posts",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(userData)
            }
        );

        if (!response.ok) {
            throw new Error("Registration request failed.");
        }

        const result = await response.json();

        setTimeout(() => {
            console.log(
                "Mock server registration response:",
                result
            );
        }, 1000);
    } catch (error) {
        console.error(error);
    }
}

document
    .querySelector("#registrationForm")
    .addEventListener("submit", function () {
        const userData = {
            name: document.querySelector("#userName").value,
            email: document.querySelector("#userEmail").value,
            eventId: document.querySelector("#selectedEvent").value
        };

        sendRegistrationToServer(userData);
    });


/* =========================================================
   16. JQUERY
   ========================================================= */

$(document).ready(function () {
    $("#eventContainer").hide().fadeIn(800);

    $("#loadEventsBtn").click(function () {
        $("#eventContainer").fadeOut(200).fadeIn(600);
    });
});


/* =========================================================
   17. INITIAL PAGE RENDER
   ========================================================= */

displayEvents(events);
populateEventDropdown();

console.table(events);