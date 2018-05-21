---
title: "Return Statement"
description: "Return Statement"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 7
---

## {$page.title}

`returnXxx` in Flow.apex only specifies what type of result is returned. To actually return something, call `doReturn(Object)` or `doReturnRaw(Object)`.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doReturn(0);
```

If no `doReturn` or equivalent is added, the Flow Func will return `null`.

The difference between `doReturn` and `doReturnRaw` is that doReturn treats String as FlowScript while `doReturnRaw` does not.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doReturn('"message"');
```

is equivalent to

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doReturnRaw('message');
```
