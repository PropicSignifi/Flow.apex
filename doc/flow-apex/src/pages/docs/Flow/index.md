---
title: "Flows"
description: "Flows and Funcs"
layout: "guide"
icon: "flash"
weight: 1
---

###### {$page.description}

<article id="1">

## What is a Flow?

A Flow is a Func that is created in a procedural way by weaving other Funcs.

According to [R.apex](https://github.com/Click-to-Cloud/R.apex), we normally have two ways to create a Func.

- Func Composition
An example of this is below:

```javascript
Func notEqBy3 = (Func)R.complement.run(R.equals.apply(3));
```

In this way, we compose a large Func out of small Funcs. This more functional way of creating Funcs
is limited by the number of existing Funcs that we can use, and the complexity of composing them. Basically,
it works perfectly for small and simple functions, but not so good with large and complicated functions.

- Func Inheritance
Another way of creating a Func is by subclassing `Func`.

```javascript
public class CustomFunc extends Func {
    public CustomFunc() {
        super(1);
    }

    public override Object exec(Object arg) {
        // Custom logic here
        return ...;
    }
}
```

We write our same old logic here in the custom Func, and wraps our complex code in a custom Func.
The issue, however, is that creating custom Funcs all the time is quite heavy. We kind of miss the adorable composing
abilities from the first approach.

- Flow Funcs
So here comes Flow.apex for the rescue.

```javascript
Func f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('sum = a + b')
    .doReturn('sum');
```

Flows, subclassing from `Func`, come with another style of functional composition, the procedural style of functional chaining.

The intention of Flow.apex is not to promote procedural programming camouflaged in functional programming. Instead, it is just a bridge
between the pure functional way and the pure procedural way, trying to glue the Funcs to create the ultimate complex monster by utilizing
a little power of both. So the takeaway is to try to keep your Flow logic as simple as possible, and reuse as many Funcs as possible.

</article>

<article id="2">

## Flow Concepts

Before we dive in, we need to clarify several concepts.

- Flow
A Flow is an object of type `Flow`, and it is a `Func`. A Flow is a `Block` decorated with arguments and return types.

- Block
A Block is a group of executable codes. A flow is backed by a block. A block contains a list of statements.

- Statement
A Statement is a line of executable code, usually grouped in a block.

</article>

<article id="3">

## Flows

Flows are just custom Funcs in a more declarative way. Apex in Salesforce does not support anonymous inner classes, and that makes it hard
to dynamically create Funcs. Flow.apex is just a workaround to make that less painful.

Flows are just blocks of executable codes. Normally, flows can be used in one of the two forms.

- Flow as a Func
A Func takes arguments, returns values and possibly has a name. This is where flows are like Funcs.

```javascript
Flow f = new Flow('sum')
    .inputAs('a', 'b').returnInteger()
    .doReturn('a + b');
```

This Flow Func is equivalent to the following function:

```javascript
Integer sum(Integer a, Integer b);
```

And it works just like a `sum` Func.

```javascript
Object result = f.run(1, 2); // 3
```

- Flow as a Block
Blocks are the internal implementations of flows. And naturally flows expose the behavior of blocks.

A block is a group of code that operates on a set of variables.

```javascript
Flow f = new Flow()
    .var('sum = a + b');
```

Blocks do not need any arguments, or return values. All they need is a set of variables to work on.

```javascript
Map<String, Object> result = (Map<String, Object>)f.execute(new Map<String, Object>{
    'a' => 1,
    'b' => 2,
    'sum' => null
});
```

</article>

<article id="4">

## Flow Funcs
Here are the factors we need take into consideration when we define a Flow Func.

- Func Parameters
We need to give meaningful Func parameter names, although Func parameters always have type as Object.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b');
```

Here we define a Flow Func that takes parameter `a` and parameter `b`.

- Func Return Type
We can also specify the return type of the Flow Func, though not required.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger();
```

`returnInteger()` indicates that this Flow Func returns an `Integer`, and when we do the `doReturn`,
Flow.apex will try to convert the returning value to the return type we have previously declared.

- Func Name
Again, Flow name is not required.

```javascript
Flow f = new Flow('f');
```

The only benefit of declaring a Flow Func with a name is to add this Flow Func to the Flow APIs(used in FlowScript) for you,
which you can do it by yourself later.

```javascript
Flow.addFunc('f', f);
```

- Do the Return
We return the value by calling `doReturn` or `doReturnRaw`. The difference is subtle:

```javascript
Flow f = new Flow()
    .doReturn('"message"');
```

v.s

```javascript
Flow f = new Flow()
    .doReturnRaw('message');
```

`doReturn` will try to treat your String as FlowScripts, while `doReturnRaw` will not.

</article>

<article id="5">

## Blocks
We can create blocks by calling `Flow.block()`.

```javascript
Flow.block()
    .var('name = "Wilson"');
```

Blocks own their statements and local variables, and can mutate global variables to share information with
outside of the blocks.

Blocks are seldom used standalone. Instead, they are mostly used combined with various controlling structures.

</article>

<article id="6">

## Deferred Execution

Each statement in a block encapsulates a deferred execution of code.

```javascript
Flow f = new Flow()
    .var('sum = a + b');

f.execute(...);
```

Statements are not executed until `execute` or `run` is called on `Func`, or `execute` is called on `Block`.

</article>

<article id="7">

## Variables

Variables are ubiquitous in flows, and they act as the carriers of data. We can access the variable values like this:

```javascript
Flow f = new Flow()
    .var('b', Flow.getVar('a'));
```

Here we get the value of `a` by calling `Flow.getVar(String)`, and set it to another variable by calling `var(String, Object)`.

Variables in Flow.apex have scopes.

In terms of scopes, variables are divided into global variables and local variables in a block.

- Global variables
Global variables are passed in to the block from outside. Blocks can mutate the values of global variables, but can never add
or remove global variables.

- Local variables
Local variables are created inside the block. The blocks are responsible for managing the lifecycle of the local variables. Local
variables are **NOT** visible to outside of the block.

The global variables and the local variables share the names. That means we cannot have variables with duplicate names in the same block.
A variable can either be global or local, and there is no variable overridden in Flow.apex. That is to say, if we have code like this,

```javascript
Flow f = new Flow()
    .var('sum = a + b');
```

If the Flow accepts `sum` from the outside variables, it will use it as a global variable and set its value. Otherwise it will create
a local variable and set its value. It will not create a local variable with the same name as the global variable, and override it.

We can print the debugging information of all the variables in the current block.

```javascript
Flow.block()
    .debug();
```

</article>

<article id="8">

## Functions

Flows actually weave Funcs into a complex Func. It's just that we have not noticed that.

```javascript
Flow f = new Flow()
    .var('sum = concat(a, b)');
```

In this Flow, `R.concat` is called with `a` and `b`. This is the same as below:

```javascript
Flow f = new Flow()
    .var('sum', Flow.call(R.concat, Flow.getVar('a'), Flow.getVar('b')));
```

This snippet is more cumbersome, but clearly explains the Func-invoking thing here.

All Funcs from R.apex have already been imported to Flow.apex, and you can freely use them.

In order to import your own Funcs, do this:

```javascript
Flow.addFunc('customFunc', new CustomFunc());
```

Make sure you import the Funcs you need before you actually use them.

</article>

<article id="9">

## Functions

Flows actually weave Funcs into a complex Func. It's just that we have not noticed that.

```javascript
Flow f = new Flow()
    .var('sum = concat(a, b)');
```

In this Flow, `R.concat` is called with `a` and `b`. This is the same as below:

```javascript
Flow f = new Flow()
    .var('sum', Flow.call(R.concat, Flow.getVar('a'), Flow.getVar('b')));
```

This snippet is more cumbersome, but clearly explains the Func-invoking thing here.

All Funcs from R.apex have already been imported to Flow.apex, and you can freely use them.

In order to import your own Funcs, do this:

```javascript
Flow.addFunc('customFunc', new CustomFunc());
```

Make sure you import the Funcs you need before you actually use them.

</article>

<article id="10">

## Branch Control

Flow.apex offers branch control with `if` and `switch`.

- If Statement
We have `if` and `if not`, and we can append `else` blocks.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doIf(
        'a == 1',
        Flow.block().doReturn(1)
    );
```

Or

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doIf(
        'a == 1',
        Flow.block().doReturn(1),
        Flow.block().doReturn(2)
    );
```

- Switch Statement
We have `switch` to handle multiple branching cases.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('word = "a"')
    .doSwitch('word', new List<Object>{
        'a', Flow.block().var('output = debug("Matched")'),
        'b', Flow.block().var('output = debug("Not Matched")')
    });
```

Or we can have more complicated switching.

```javascript
Flow f = new Flow()
    .inputAs('n').returnInteger()
    .doSwitch('n', new List<Object>{
        Flow.s('n == 1'), Flow.block().var('output = debug("Matched")'),
        Flow.s('n != 1'), Flow.block().var('output = debug("Not Matched")')
    });
```

Here `Flow.s(String)` convert a String into a deferred condition check for `swtich`.

</article>

<article id="11">

## Loop Control

Flow.apex has three types of loop control.

- For Loop
Here is the normal `for` loop that we can use.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doFor('i = 0; i < 10; i = i + 1', Flow.block()
        .var('output = debug(i)')
    );
```

Notice that here we use `i = i + 1`, as `i++` is not supported in Flow.apex.

- For-In Loop
We can also use `for ... in` like structure.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doFor('i in range(0, 10)', Flow.block()
        .var('output = debug(i)')
    );
```

- While Loop
We support the use of `while`.

```javascript
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('i = 0')
    .doWhile('i < 10', Flow.block()
        .var('output = debug(i)')
        .var('i = i + 1')
    );
```

To better control the loops, we have `break` and `continue` available.

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

</article>

<article id="12">

## Recursion

We can easily achieve recursion in Flow.apex.

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

Here `this(n - 1)` is calling Flow `f`, with argument `n - 1`.

</article>
