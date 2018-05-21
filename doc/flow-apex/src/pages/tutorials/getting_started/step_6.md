---
title: "Function Invocation"
description: "Function Invocation"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 6
---

## {$page.title}

We can invoke functions in Flows.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('num = add(a, b)');
```

Here we assign the value of `num` to be the result of calling `add(a, b)`.

Funcs from R.apex are imported in Flow.apex. If you want to import custom Funcs, see below.

```javascript
Flow.addFunc('plus', R.add);
```

This will register the Func `R.add` in the name of `plus`. So you can refer it now in FlowScript.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('num = plus(a, b)');
```
