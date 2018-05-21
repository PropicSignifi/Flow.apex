---
title: "While Block"
description: "While Block"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 10
---

## {$page.title}

We can use `while` blocks in Flow.apex like this.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('i = 0')
    .doWhile('i < 10', Flow.block()
        .var('output = debug(i)')
        .var('i = i + 1')
    );
```
