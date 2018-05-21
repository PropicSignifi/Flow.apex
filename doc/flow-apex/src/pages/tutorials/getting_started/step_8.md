---
title: "If Block"
description: "If Block"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 8
---

## {$page.title}

Flow.apex supports `if` and `if not` blocks.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doIf(
        'a == 1',
        Flow.block().doReturn(1)
    );
```

And we can append the `else` block too.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doIf(
        'a == 1',
        Flow.block().doReturn(1),
        Flow.block().doReturn(2)
    );
```

Here `if` needs at least one block. A block in Flow.apex is actually a block of executable statements. We can use the blocks to extend our logic.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doIf(
        'a == 1',
        Flow.block()
            .var('b = 2')
            // more logic goes on here
            .doReturn(1)
    );
```
