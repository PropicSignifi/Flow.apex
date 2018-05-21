---
title: "Recursion"
description: "Recursion"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 13
---

## {$page.title}

With Flow.apex, recursion is not difficult to achieve.

```javascript
Flow f = new Flow()
    .inputAs('n').returnInteger()
    .doIf(
        'n == 0',
        Flow.block()
            .doReturn(0)
    )
    .var('ret = 2 + this(n - 1)')
    .doReturn('ret');
```
