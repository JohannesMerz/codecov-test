const index = require("./index");

test("returns expected string", () =>
  expect(index()).toEqual("this is a test"));
