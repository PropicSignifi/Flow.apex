---
title: "Function Methods"
description: "Function Methods"
layout: "guide"
icon: "code-file"
weight: 3
---

###### {$page.description}

<article id="1">

## Func Arguments

These methods specify the arguments of the Flow Func.

| Method | Description |
| ----------- | ----------- |
| inputAs(String) | Rename first argument |
| inputAs(String, String) | Rename first two arguments |
| inputAs(String, String, String) | Rename first three arguments |
| inputAs(List&lt;String&gt;) | Rename the givne arguments |

</article>

<article id="2">

## Func Return Type

These methods specify the return type of the Flow Func.

| Method | Description |
| ----------- | ----------- |
| returnObject(Type) | Specify the return type |
| returnObject() | Return Object |
| returnBoolean() | Return Boolean |
| returnInteger() | Return Integer |
| returnLong() | Return Long |
| returnDouble() | Return Double |
| returnDecimal() | Return Decimal |
| returnString() | Return String |
| returnList() | Return List&lt;Object&gt; |
| returnSet() | Return Set&lt;String&gt; |
| returnMap() | Return Map&lt;String, Object&gt; |
| returnSObject() | Return SObject |
| returnDate() | Return Date |
| returnTime() | Return Time |
| returnDatetime() | Return Datetime |
| returnFunc() | Return Func |

</article>

<article id="3">

## Func Do Return

These methods return a value from the Flow Func.

| Method | Description |
| ----------- | ----------- |
| doReturn(Object) | Return the value, treating Strings as FlowScript |
| doReturnRaw(Object) | Return the value, treating Strings as raw |

</article>

<article id="4">

## Func Trigger

These methods trigger the Flow Func to run.

| Method | Description |
| ----------- | ----------- |
| run(...) | Run the Func with the arguments |
| runN(List&lt;Object&gt;) | Run the Func with the list of arguments |

</article>
