# Personal Diary Software Introduction

There are four programs:`pdlist`, `pdshow`, `pdadd`, `pdremove`.

---

`pdshow` has 3 parameters:

* If there's no parameter for it, it lists all diaries existing
* If one parameter, it lists all diaries which have the same year with the parameter
* If two parameters, it lists all diaries which have the same year and month with the parameter
* If three or more parameters, it lists all diaries which have the same date with the parameter

---

`pdlist` can accept 6 parameters:

* no parameter: lists all diaries
* 1 parameter: take it as the year of starting, list all diaries after and in the year
* 2 parameters: take them as the year of start and end
* 3: year and month of the start and year of the end
* 4: year and month for start and end
* 5: date for start and year and month for end
* 6: date for start and end

---

`pdadd` has no parameter

It would give hint message for the input format

---

`pdremove` has 3 parameters:

* If there's no parameter for it, it does nothing
* If one parameter, it removes all diaries which have the same year with the parameter
* If two parameters, it removes all diaries which have the same year and month with the parameter
* If three or more parameters, it removes all diaries which have the same date with the parameter