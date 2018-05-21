---
title: "For Block"
description: "For Block"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 9
---

## {$page.title}

We support two types of `for` blocks in Flow.apex.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doFor('i = 0; i < 10; i = i + 1', Flow.block()
        .var('output = debug(i)')
    );
```

Or

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doFor('i in range(0, 10)', Flow.block()
        .var('output = debug(i)')
    );
```
