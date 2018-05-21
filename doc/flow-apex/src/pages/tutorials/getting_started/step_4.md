---
title: "Flow Func Signature"
description: "Flow Func Signature"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 4
---

## {$page.title}

A Flow is actually a Func.

```javascript
Func f = new Flow()
    .inputAs('a', 'b').returnInteger();
```

Here we create a Func of `(a, b) => Integer`, with an empty body.

Or we can give it a name.

```javascript
Flow f = new Flow('f')
    .input('a', 'b').returnInteger();
```

This will add Func `f` to FlowScript, so that it can be referenced in the future.

This definition creates a Func that takes `a` and `b` as arguments, and returns `Integer`.

As a Flow is jsut a Func, we can use it wherever we can use Funcs.

```javascript
Object result = f.run(1, 2); // Call the Flow(Func)
```
