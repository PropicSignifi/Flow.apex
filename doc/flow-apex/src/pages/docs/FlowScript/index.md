---
title: "FlowScript"
description: "FlowScript"
layout: "guide"
icon: "cloud"
weight: 4
---

###### {$page.description}

<article id="1">

## What is FlowScript?

FlowScript is a small scripting language packaged with Flow.apex. FlowScript is used to
convert javascript-like scripts into Flow.apex code.

</article>

<article id="2">

## How does FlowScript work?

FlowScript bascially is just an interpreter from a more readable script to Flow.apex code.

```javascript
Flow f = new Flow()
    .var('n = n + 1');
```

This embedded FlowScript is then translated into this:

```javascript
Flow f = new Flow()
    .var('n', Flow.s('n + 1'));
```

`Flow.s(String)` is a tool used to convert Strings into deferred Flow.apex code invocations. It eventually translates the script into:

```javascript
Flow f = new Flow()
    .var('n', Flow.call(R.add.apply(1), Flow.getVar('n')));
```

The purpose of FlowScript is to make the code easier to read, and fundamentally it does not change the code logic.

The interpretation of FlowScript happens only once when the Flow is created. Therefore further performance penalty is avoided.

</article>

<article id="3">

## FlowScript Evaluation

We can evaluate FlowScript independently from Flow.apex.

```javascript
Object value = Flow.eval('add(a, b)', new Map<String, Object>{
    'a' => 1,
    'b' => 2
});
```

</article>

<article id="4">

## FlowScript Syntax

FlowScript follows most of JavaScript syntax, with these exceptions:

- Functions instead of methods
FlowScript supports only functions like `add(1, 2)`, not `a.add(1, 2)`.

- Reference of `this`
In FlowScript, `this` always refers to the current Flow object.


Supported Unary Operators

| Operator | Description |
| -------- | ----------- |
| - | Negate the number |
| ! | Negate the boolean |
| ++(prefixed) | Increment the number |
| --(prefixed) | Decrement the number |

Supported Binary Operators

| Operator | Description |
| -------- | ----------- |
| == | Equals |
| != | Not Equals |
| < | Less than |
| > | Greater than |
| <= | Less than or equals |
| >= | Greater than or equals |
| + | Add |
| - | Minus |
| * | Multiply |
| / | Divide |
| % | Modulo |

Supported Logical Operators

| Operator | Description |
| -------- | ----------- |
| ! | Negate the boolean |
| && | Logical And |
| \|\| | Logical Or |

Supported Ternary Operators

| Operator | Description |
| -------- | ----------- |
| ? : | If ... then ... else ... |

Array Literal

```javascript
Flow f = new Flow()
    .var('a = ["a", "b"]');
```

Map Literal

```javascript
Flow f = new Flow()
    .var('a = { "name" => "value" }');
```

</article>
