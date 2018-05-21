---
title: "Break and Continue"
description: "Break and Continue"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 11
---

## {$page.title}

We can use `break` and `continue` in any loop blocks.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('i = 0')
    .doWhile('i < 10', Flow.block()
        .doIf('i == 3', Flow.block()
            .doBreak()
        )
        .var('output = debug(i)')
        .var('i = i + 1')
    );
```
