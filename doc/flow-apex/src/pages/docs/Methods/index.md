---
title: "Flow Methods"
description: "Flow Methods"
layout: "guide"
icon: "code-file"
weight: 2
---

###### {$page.description}

<article id="1">

## Flow Method Reference

Here is the reference for Flow.apex.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('num = a + b')
    .doReturn('num');

Object result = f.run(1, 2);
```

</article>
