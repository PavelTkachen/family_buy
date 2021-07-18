const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const logger = require("morgan");
const cors = require("cors");
const app = express();

app.use(cors());
app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

let authorize = false;

const checkAuth = (req, res, next) => {
  if (authorize) {
    next();
  } else {
    res.status(401).send("Unauthorized!");
    return;
  }
};

app.use("/", checkAuth);

app.get("/", (req, res) => {
  return res.json({
    message: "Hello Wor2ld!!!",
  });
});

module.exports = app;
