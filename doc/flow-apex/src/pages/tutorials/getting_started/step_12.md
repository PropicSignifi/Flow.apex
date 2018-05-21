---
title: "Switch Block"
description: "Switch Block"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 12
---

## {$page.title}

We can use `switch` in Flows too.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('word = "a"')
    .doSwitch('word', new List<Object>{
        'a', Flow.block().var('output = debug("Matched")'),
        'b', Flow.block().var('output = debug("Not Matched")')
    });
```

Also we can use `break` in `switch` blocks.
