# Flow.apex
Flow.apex is a library to help you weave functions in a procedural style.

## Why Flow.apex?
Flow.apex is created to simplify the creation of a Function. It simulates the procedural invocation of Functions, and weave them to build a larger and more complicated Function. Flow.apex acts as a bridge between the small Funcs and big custom Funcs that you create by subclassing Func.

## Dependencies
Flow.apex has a dependency over [R.apex](https://github.com/Click-to-Cloud/R.apex/) and [Script.apex](https://github.com/Click-to-Cloud/Script.apex/).

Please include them before including Flow.apex.

## Preliminary Knowledge
Flow.apex is in fact an extension of R.apex, and it requires a fair amount of knowledge on R.apex. If you want to go deeper with Flow.apex, please do check out [R.apex](https://github.com/Click-to-Cloud/R.apex/).

## Examples
### Funcs in Script
Flow.apex has a built-in FlowScript to run Funcs dynamically.

Previously, we run `R.product` like this:

```java
Object result = R.product.runN(new List<Object>{ 1, 2, 3, 4});
// Generate 24 from 1 * 2 * 3 * 4
```

Now with FlowScript, we have:

```java
Object result = Flow.eval('product(1, 2, 3, 4)');
// Generate 24 from 1 * 2 * 3 * 4
```

FlowScript makes invocations of Funcs more natural.

### Flow Func Signature
A Flow is actually a Func.

```java
Func f = new Flow()
    .inputAs('a', 'b').returnInteger();
```

Here we create a Func of `(a, b) => Integer`, with an empty body.

Or we can give it a name.

```java
Flow f = new Flow('f')
    .input('a', 'b').returnInteger();
```

This will add Func `f` to FlowScript, so that it can be referenced in the future.

This definition creates a Func that takes `a` and `b` as arguments, and returns `Integer`.

As a Flow is jsut a Func, we can use it wherever we can use Funcs.

```java
Object result = f.run(1, 2); // Call the Flow(Func)
```

### Variable Assignment
We can do variable assignment in Flows.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('num = 0');
```

Here we created a local variable `num` with the value of `0`.

Flows have global variables and local variables. Any variable that is passed from outside is a global one. Any variable that is created inside the Flow is a local one. Variables cannot share the same names, so there is no variable overridden in Flow.apex.

### Function Invocation
We can invoke functions in Flows.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('num = add(a, b)');
```

Here we assign the value of `num` to be the result of calling `add(a, b)`.

Funcs from R.apex are imported in Flow.apex. If you want to import custom Funcs, see below.

```java
Flow.addFunc('plus', R.add);
```

This will register the Func `R.add` in the name of `plus`. So you can refer it now in FlowScript.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('num = plus(a, b)');
```

### Return Statement
`returnXxx` in Flow.apex only specifies what type of result is returned. To actually return something, call `doReturn(Object)` or `doReturnRaw(Object)`.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doReturn(0);
```

If no `doReturn` or equivalent is added, the Flow Func will return `null`.

The difference between `doReturn` and `doReturnRaw` is that `doReturn` treats String as FlowScript while `doReturnRaw` does not.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doReturn('"message"');
```

is equivalent to

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doReturnRaw('message');
```

### If Block
Flow.apex supports `if` and `if not` blocks.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doIf(
        'a == 1',
        Flow.block().doReturn(1)
    );
```

And we can append the `else` block too.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doIf(
        'a == 1',
        Flow.block().doReturn(1),
        Flow.block().doReturn(2)
    );
```

Here `if` needs at least one block. A block in Flow.apex is actually a block of executable statements. We can use the blocks to extend our logic.

```java
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

### For Block
We support two types of `for` blocks in Flow.apex.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doFor('i = 0; i < 10; i = i + 1', Flow.block()
        .var('output = debug(i)')
    );
```

Or

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .doFor('i in range(0, 10)', Flow.block()
        .var('output = debug(i)')
    );
```

### While Block
We can use `while` blocks in Flow.apex like this.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('i = 0')
    .doWhile('i < 10', Flow.block()
        .var('output = debug(i)')
        .var('i = i + 1')
    );
```

### Break and Continue
We can use `break` and `continue` in any loop blocks.

```java
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

### Switch Block
We can use `switch` in Flows too.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .var('word = "a"')
    .doSwitch('word', new List<Object>{
        'a', Flow.block().var('output = debug("Matched")'),
        'b', Flow.block().var('output = debug("Not Matched")')
    });
```

Also we can use `break` in `switch` blocks.

### Recursion
With Flow.apex, recursion is not difficult to achieve.

```java
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

### Flow Debug
We can add debugging information anywhere we want in the block.

```java
Flow f = new Flow()
    .inputAs('a', 'b').returnInteger()
    .debug();
```

`debug` will print all of the current variables in the block.
