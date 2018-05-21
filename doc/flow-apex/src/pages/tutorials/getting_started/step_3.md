---
title: "FlowScript"
description: "FlowScript"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 3
---

## {$page.title}

Flow.apex has a built-in FlowScript to run Funcs dynamically.

Previously, we run `R.product` like this:

```javascript
Object result = R.product.runN(new List<Object>{ 1, 2, 3, 4});
// Generate 24 from 1 * 2 * 3 * 4
```

Now with FlowScript, we have:

```javascript
Object result = Flow.eval('product(1, 2, 3, 4)');
// Generate 24 from 1 * 2 * 3 * 4
```

FlowScript makes invocations of Funcs more natural.
