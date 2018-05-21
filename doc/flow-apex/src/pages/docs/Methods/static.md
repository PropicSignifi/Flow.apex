---
title: "Static Methods"
description: "Static Methods"
layout: "guide"
icon: "code-file"
weight: 5
---

###### {$page.description}

<article id="1">

## `this` Placeholder

Flow.apex has a placeholder for the current Flow, and it is `Flow.self`.

```javascript
Flow f = new Flow()
     .inputAs('n').returnInteger()
     .doIf(
         Flow.call(R.equals.apply(0), Flow.getVar('n')),
         Flow.block()
             .doReturn(0)
     )
     .var('ret', Flow.call(R.add.apply(2), Flow.call(Flow.self, Flow.call(R.dec, Flow.getVar('n')))))
     .doReturn(Flow.getVar('ret'));
```

</article>

<article id="2">

## FlowScript Interpretation

Using `Flow.s(String)`, we can convert Strings into Flow.apex invocations.

```javascript
Flow f = new Flow()
    var('n', Flow.s('i'));
```

</article>

<article id="3">

## FlowScript Evaluation

We can evaluate the FlowScript independently from Flows.

```javascript
Object result = Flow.eval('add(1, 2)');
```

</article>

<article id="4">

## FlowScript Evaluation

We can evaluate the FlowScript independently from Flows.

```javascript
Object result = Flow.eval('add(1, 2)');
```

| Method | Description |
| ------ | ----------- |
| eval(String) | Evaluate without context |
| eval(String, Map&lt;String, Object&gt;) | Evaluate with context |

</article>

<article id="5">

## Block Creation

We can create a block like this:

```javascript
Block b = Flow.block();
```

</article>

<article id="6">

## Get Variable

This is how we get the variable value.

```javascript
Flow f = new Flow()
    .var('n', Flow.getVar('a'));
// Get the value of 'a' and set it to 'n'
```

</article>

<article id="7">

## Call Functions

This is how we call functions.

```javascript
Flow f = new Flow()
    .var('ret', Flow.call(R.constant.apply('a')));
// Set value 'a' to 'ret', by calling a 'constant' Func that always returns the value it has received
```

| Method | Description |
| ------ | ----------- |
| call(Func) | Call the Func with no arguments |
| call(Func, Object) | Call the Func with one argument |
| call(Func, Object, Object) | Call the Func with two arguments |
| call(Func, Object, Object) | Call the Func with three arguments |
| call(Func, List&lt;Object&gt;) | Call the Func with a list of arguments |

</article>

<article id="8">

## Add Custom Funcs

We can add custom Funcs like this:

```javascript
Flow.addFuncs(new Map<String, Func>{ 'plus' => R.add });

Flow f = new Flow()
    .doReturn('plus(1, 2)');
```

| Method | Description |
| ------ | ----------- |
| addFuncs(Map&lt;String, Func&gt;) | Add a map of Funcs |
| addFunc(String, Func) | Add Func with the name |
| removeAllFuncs() | Remove all the Funcs |

</article>
