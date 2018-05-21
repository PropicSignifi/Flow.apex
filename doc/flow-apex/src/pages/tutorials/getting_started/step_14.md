---
title: "Flow Debug"
description: "Flow Debug"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 14
---

## {$page.title}

We can add debugging information anywhere we want in the block.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .debug();
```

`debug` will print all of the current variables in the block.
