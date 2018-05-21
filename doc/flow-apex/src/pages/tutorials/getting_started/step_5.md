---
title: "Variable Assignment"
description: "Variable Assignment"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 5
---

## {$page.title}

We can do variable assignment in Flows.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('num = 0');
```

Here we created a local variable `num` with the value of `0`.

Flows have global variables and local variables. Any variable that is passed from outside is a global one. Any variable that is created inside the Flow is a local one. Variables cannot share the same names, so there is no variable overridden in Flow.apex.
