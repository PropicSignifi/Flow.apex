---
title: "Block Methods"
description: "Block Methods"
layout: "guide"
icon: "code-file"
weight: 4
---

###### {$page.description}

<article id="1">

## Block Trigger

These methods trigger the block to run.

| Method | Description |
| ----------- | ----------- |
| execute(Map&lt;String, Object&gt;) | Execute the block with the variables |

</article>

<article id="2">

## Assign Variables

These methods assign the variable values.

| Method | Description |
| ----------- | ----------- |
| var(String) | Run the simplified assignment |
| var(String, Object) | Assign the value to the variable with the name |

</article>

<article id="3">

## If Control

These methods do the `if` control.

| Method | Description |
| ----------- | ----------- |
| doIf(Object, Block) | If ... then ... |
| doIf(Object, Block, Block) | If ... then ... else ... |
| doIfNot(Object, Block, Block) | If not ... then ... else ... |
| doIfNot(Object, Block) | If not ... then ... |

</article>

<article id="4">

## For Control

These methods do the `for` control.

| Method | Description |
| ----------- | ----------- |
| doFor(String, Object, Object, Object, Block) | for i = 0; i != 10; i = i + 1 loop |
| doFor(String, Object, Block) | for ... in loop |
| doFor(String, Block) | Simplified for loop statement |

</article>

<article id="5">

## While Control

These methods do the `while` control.

| Method | Description |
| ----------- | ----------- |
| doWhile(Object, Block) | while ..., do ... |

</article>

<article id="6">

## Switch Control

These methods do the `switch` control.

| Method | Description |
| ----------- | ----------- |
| doSwitch(Object, List&lt;Object&gt;) | switch ... case ... |

</article>

<article id="7">

## Break && Continue

These methods are useful in loop and switches.

| Method | Description |
| ----------- | ----------- |
| doBreak() | Break |
| doContinue() | Continue |

</article>

<article id="8">

## Debug

These methods are useful for debugging.

| Method | Description |
| ----------- | ----------- |
| debug() | Print the variables in the current block |

</article>
