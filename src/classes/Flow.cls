/**
 * MIT License
 *
 * Copyright (c) 2018 Click to Cloud Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 **/
/**
 * A Flow is a Func that allows a procedural way of weaving Funcs
 *
 * Flow.apex depends on R.apex and Script.apex
 *
 * */
public class Flow extends Func {
    // The body of the execution
    private Block body;

    // The parameter names of the Flow Func
    private List<String> inputNames;

    // The return type of the Flow Func
    private Type returnVarType;

    /**
     * Construct a default Flow
     * */
    public Flow() {
        this(null);
    }

    /**
     * Construct a Flow with the name registered to the Flow APIs, so that it can be
     * reused in other Flow scripts
     *
     * @param name The name of the Flow
     * */
    public Flow(String name) {
        super(-1);

        this.body = new Block();

        Flow.self = this;

        if(name != null) {
            Flow.addFunc(name, this);
        }
    }

    /**
     * Rename the input parameters
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs(new List<String>{ 'a', 'b', 'c' });
     *
     * @param inputNames The input names
     * @return Flow
     * */
    public Flow inputAs(List<String> inputNames) {
        this.inputNames = inputNames;

        return this;
    }

    /**
     * Rename the first parameter
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('n');
     *
     * @param name1 The first parameter name
     * @return Flow
     * */
    public Flow inputAs(String name1) {
        return this.inputAs(new List<String>{ name1 });
    }

    /**
     * Rename the first, second parameters
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a', 'b');
     *
     * @param name1 The first parameter name
     * @param name2 The second parameter name
     * @return Flow
     * */
    public Flow inputAs(String name1, String name2) {
        return this.inputAs(new List<String>{ name1, name2 });
    }

    /**
     * Rename the first, second and third parameters
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a', 'b', 'c');
     *
     * @param name1 The first parameter name
     * @param name2 The second parameter name
     * @param name3 The third parameter name
     * @return Flow
     * */
    public Flow inputAs(String name1, String name2, String name3) {
        return this.inputAs(new List<String>{ name1, name2, name3 });
    }

    /**
     * Set the return type
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnObject(Integer.class);
     *
     * @param returnVarType The return type
     * @return Flow
     * */
    public Flow returnObject(Type returnVarType) {
        this.returnVarType = returnVarType;

        return this;
    }

    /**
     * Set the return type to Object
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnObject();
     *
     * @return Flow
     * */
    public Flow returnObject() {
        return this.returnObject(null);
    }

    /**
     * Set the return type to Boolean
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnBoolean();
     *
     * @return Flow
     * */
    public Flow returnBoolean() {
        return this.returnObject(Boolean.class);
    }

    /**
     * Set the return type to Integer
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnInteger();
     *
     * @return Flow
     * */
    public Flow returnInteger() {
        return this.returnObject(Integer.class);
    }

    /**
     * Set the return type to Long
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnLong();
     *
     * @return Flow
     * */
    public Flow returnLong() {
        return this.returnObject(Long.class);
    }

    /**
     * Set the return type to Double
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnDouble();
     *
     * @return Flow
     * */
    public Flow returnDouble() {
        return this.returnObject(Double.class);
    }

    /**
     * Set the return type to Decimal
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnDecimal();
     *
     * @return Flow
     * */
    public Flow returnDecimal() {
        return this.returnObject(Decimal.class);
    }

    /**
     * Set the return type to String
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnString();
     *
     * @return Flow
     * */
    public Flow returnString() {
        return this.returnObject(String.class);
    }

    /**
     * Set the return type to List
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnList();
     *
     * @return Flow
     * */
    public Flow returnList() {
        return this.returnObject(List<String>.class);
    }

    /**
     * Set the return type to Set
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnSet();
     *
     * @return Flow
     * */
    public Flow returnSet() {
        return this.returnObject(Set<String>.class);
    }

    /**
     * Set the return type to Map
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnMap();
     *
     * @return Flow
     * */
    public Flow returnMap() {
        return this.returnObject(Map<String, Object>.class);
    }

    /**
     * Set the return type to SObject
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnSObject();
     *
     * @return Flow
     * */
    public Flow returnSObject() {
        return this.returnObject(SObject.class);
    }

    /**
     * Set the return type to Date
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnDate();
     *
     * @return Flow
     * */
    public Flow returnDate() {
        return this.returnObject(Date.class);
    }

    /**
     * Set the return type to Time
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnTime();
     *
     * @return Flow
     * */
    public Flow returnTime() {
        return this.returnObject(Time.class);
    }

    /**
     * Set the return type to Datetime
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnDatetime();
     *
     * @return Flow
     * */
    public Flow returnDatetime() {
        return this.returnObject(Datetime.class);
    }

    /**
     * Set the return type to Func
     *
     * Example:
     * Flow f = new Flow()
     *     .inputAs('a').returnFunc();
     *
     * @return Flow
     * */
    public Flow returnFunc() {
        return this.returnObject(Func.class);
    }

    /**
     * Return the raw value, if the value is String, it will not be treated specially
     *
     * Example:
     * Flow f = new Flow()
     *     .doReturnRaw('raw string');
     *
     * @param returnValue The return value
     * @return Flow
     * */
    public Flow doReturnRaw(Object returnValue) {
        this.body.doReturnRaw(returnValue);

        return this;
    }

    /**
     * Return the value, if the value is String, it will be treated as FlowScript
     *
     * Example:
     * Flow f = new Flow()
     *     .doReturn('"script string"');
     *
     * @param returnValue The return value
     * @return Flow
     * */
    public Flow doReturn(Object returnValue) {
        this.body.doReturn(returnValue);

        return this;
    }

    /**
     * Actually runs the flow as a Func
     *
     * Example:
     * Flow f = new Flow()
     *     .doReturn(0);
     * f.run(); // 0
     *
     * @param args The arguments
     * @return Object
     * */
    public override Object execN(List<Object> args) {
        Map<String, Object> variables = new Map<String, Object>();
        if(this.inputNames != null && !this.inputNames.isEmpty()) {
            for(Integer i = 0; i < this.inputNames.size(); i++) {
                variables.put(this.inputNames.get(i), R.nth.run(i, args));
            }
        }

        try {
            this.execute(variables);
        }
        catch(ReturnException e) {
            return getReturnValue(e.getValue(), this.returnVarType);
        }

        return null;
    }

    /**
     * Execute the flow as a block of code
     *
     * Example:
     * Flow f = new Flow()
     *     .var('tmp = a')
     *     .var('a = b')
     *     .var('b = tmp');
     * f.execute(new Map<String, Object>{ 'a' => 'x', 'b' => 'y' });
     * // swap 'a' and 'b'
     *
     * @param variables The input variables
     * @return Map<String, Object>
     * */
    public Map<String, Object> execute(Map<String, Object> variables) {
        return this.body.execute(variables);
    }

    /**
     * Assign value to the variable
     *
     * Example:
     * Flow f = new Flow()
     *     .var('n = 0');
     * // Assign 'n' to 0
     *
     * @param statement The statement to assign the value
     * @return Flow
     * */
    public Flow var(String statement) {
        this.body.var(statement);

        return this;
    }

    /**
     * Assign value to the variable
     *
     * Example:
     * Flow f = new Flow()
     *     .var('n', 0);
     * // Assign 'n' to 0
     *
     * @param varName The name of the variable
     * @param value The value to assign
     * @return Flow
     * */
    public Flow var(String varName, Object value) {
        this.body.var(varName, value);

        return this;
    }

    /**
     * Execute an 'if' block
     *
     * Example:
     * Flow f = new Flow()
     *     .doIf('n == 1', Flow.block()...);
     * // If n == 1, then do ...
     *
     * @param condition The condition to check
     * @param thenBlock The success block
     * @return Flow
     * */
    public Flow doIf(Object condition, Block thenBlock) {
        this.body.doIf(condition, thenBlock);

        return this;
    }

    /**
     * Execute an 'if/else' block
     *
     * Example:
     * Flow f = new Flow()
     *     .doIf('n == 1', Flow.block()..., Flow.block()...);
     * // If n == 1, then ..., else ...
     *
     * @param condition The condition to check
     * @param thenBlock The success block
     * @param elseBlock The failure block
     * @return Flow
     * */
    public Flow doIf(Object condition, Block thenBlock, Block elseBlock) {
        this.body.doIf(condition, thenBlock, elseBlock);

        return this;
    }

    /**
     * Execute an 'if not' block
     *
     * Example:
     * Flow f = new Flow()
     *     .doIfNot('n == 1', Flow.block()...);
     * // If n != 1, then ...
     *
     * @param condition The condition to check
     * @param thenBlock The then block
     * @return Flow
     * */
    public Flow doIfNot(Object condition, Block thenBlock) {
        this.body.doIfNot(condition, thenBlock);

        return this;
    }

    /**
     * Execute an 'if not/else' block
     *
     * Example:
     * Flow f = new Flow()
     *     .doIfNot('n == 1', Flow.block()..., Flow.block()...);
     * // If n != 1, then ..., else ...
     *
     * @param condition The condition to check
     * @param thenBlock The then block
     * @param elseBlock The else block
     * @return Flow
     * */
    public Flow doIfNot(Object condition, Block thenBlock, Block elseBlock) {
        this.body.doIfNot(condition, thenBlock, elseBlock);

        return this;
    }

    /**
     * Execute a 'for' loop in the form of 'i = 0; i &lt; N; i = i + 1'
     *
     * Example:
     * Flow f = new Flow()
     *     .doFor('i', 0, Flow.s('i != 10'), Flow.s('i + 1'), Flow.block()...);
     * // Loop i from 0 to 10
     *
     * @param varName The index var name
     * @param initialValue The initial value of the index variable
     * @param endCheck Check if the loop ends
     * @param nextStep Get the value of the index for the next loop
     * @param body The loop body
     * @return Flow
     * */
    public Flow doFor(String varName, Object initialValue, Object endCheck, Object nextStep, Block body) {
        this.body.doFor(varName, initialValue, endCheck, nextStep, body);

        return this;
    }

    /**
     * Execute a 'for' loop in the form of 'i in range'
     *
     * Example:
     * Flow f = new Flow()
     *     .doFor('i', Flow.s('nums'), Flow.block()...);
     * // Loop i in list of nums
     *
     * @param varName The index variable name
     * @param rangeValue The value for the loop range
     * @param body The loop body
     * @return Flow
     * */
    public Flow doFor(String varName, Object rangeValue, Block body) {
        this.body.doFor(varName, rangeValue, body);

        return this;
    }

    /**
     * Execute a simplified 'for' loop
     *
     * Example:
     * Flow f1 = new Flow()
     *     .doFor('i in nums', Flow.block()...);
     *
     * Flow f2 = new Flow()
     *     .doFor('i = 0; i != 10; i = i + 1', Flow.block()...);
     *
     * @param statement The for loop expression
     * @param body The loop body
     * @return Flow
     * */
    public Flow doFor(String statement, Block body) {
        this.body.doFor(statement, body);

        return this;
    }

    /**
     * Execute a 'while' loop
     *
     * Example:
     * Flow f = new Flow()
     *     .doWhile('n != 10', Flow.block()...);
     * // While n != 10, do ...
     *
     * @param condition The condition
     * @param body The while body
     * @return Flow
     * */
    public Flow doWhile(Object condition, Block body) {
        this.body.doWhile(condition, body);

        return this;
    }

    /**
     * Execute a 'switch'
     *
     * Example:
     * Flow f = new Flow()
     *     .doSwitch('word', new List<Object>{
     *         'a', Flow.block()...,
     *         'b', Flow.block()...
     *     });
     *
     * @param switchValue The value to check against
     * @param segments The list of segments
     * @return Flow
     * */
    public Flow doSwitch(Object switchValue, List<Object> segments) {
        this.body.doSwitch(switchValue, segments);

        return this;
    }

    /**
     * Print the debug information of current variables
     *
     * Example:
     * Flow f = new Flow()
     *     .var('num = 1')
     *     .debug();
     *
     * @return Flow
     * */
    public Flow debug() {
        this.body.debug();

        return this;
    }

    /**
     * Break at the current line of code
     *
     * Example:
     * Flow f = new Flow()
     *     .doFor('i in nums', Flow.block()
     *         .doBreak()
     *     );
     *
     * @return Flow
     * */
    public Flow doBreak() {
        this.body.doBreak();

        return this;
    }

    /**
     * Continue at the current line of code
     *
     * Example:
     * Flow f = new Flow()
     *     .doFor('i in nums', Flow.block()
     *         .doContinue()
     *     );
     *
     * @return Flow
     * */
    public Flow doContinue() {
        this.body.doContinue();

        return this;
    }

    // Keep track of the last used block
    private static Block lastBlock = null;

    // A cache of the parsed FlowScripts
    private static final Map<String, Jsep.Node> cache = new Map<String, Jsep.Node>();

    // Member Func to get the property out of an object
    private static final Func member = new MemberFunc();

    // Conditional Func to do the tertiary operator
    private static final Func conditional = new ConditionalFunc();

    // Deferred array Func to return an array
    private static final Func deferredArray = new ArrayFunc();

    // Deferred map Func to return a map
    private static final Func deferredMap = new MapFunc();

    // The Script Engine
    private static final ScriptEngine engine = new ScriptEngine();

    // The APIs used in the FlowScript
    private static final Map<String, Func> API = new Map<String, Func>();

    static {
        API.putAll(R.API);
    }

    /**
     * Placeholder to represent the current Flow
     * Primarily used in recursions
     *
     * Example:
     * Flow f = new Flow()
     *      .inputAs('n').returnInteger()
     *      .doIf(
     *          Flow.call(R.equals.apply(0), Flow.getVar('n')),
     *          Flow.block()
     *              .doReturn(0)
     *      )
     *      .var('ret', Flow.call(R.add.apply(2), Flow.call(Flow.self, Flow.call(R.dec, Flow.getVar('n')))))
     *      .doReturn(Flow.getVar('ret'));
     */
    public static Flow self = null;

    /**
     * Parse the script into Flow invocable objects
     *
     * Example:
     * Flow f = new Flow()
     *     var('n', Flow.s('i'));
     *
     * @param script The script parameter
     * @return IInvocation
     * */
    public static IInvocation s(String script) {
        return (IInvocation)engine.eval(script);
    }

    /**
     * Evaluate the script using FlowScript APIs
     *
     * Example:
     * Object result = Flow.eval('add(1, 2)');
     *
     * @param script The FlowScript
     * @return Object
     * */
    public static Object eval(String script) {
        return eval(script, null);
    }

    /**
     * Evaluate the script using FlowScript APIs and extra variables
     *
     * Example:
     * Object result = Flow.eval('add(a, b)', new Map<String, Object>{
     *     'a' => 1,
     *     'b' => 2
     * });
     *
     * @param script The FlowScript
     * @param data The variables
     * @return Object
     * */
    public static Object eval(String script, Map<String, Object> data) {
        if(data == null) {
            data = new Map<String, Object>();
        }

        try {
            new Block().doReturn(Flow.s(script)).execute(data);
        }
        catch(ReturnException e) {
            return e.getValue();
        }

        return null;
    }

    /**
     * Create a block
     *
     * @return Block
     * */
    public static Block block() {
        return new Block();
    }

    /**
     * Get the value of the variable in a deferred way
     * This actual process is not triggered until the Flow is being executed
     *
     * Example:
     * Flow f = new Flow()
     *     .var('n', Flow.getVar('a'));
     * // Get the value of 'a' and set it to 'n'
     *
     * @param varName The variable name
     * @return IInvocation
     * */
    public static IInvocation getVar(String varName) {
        if(Flow.lastBlock == null) {
            throw new FlowException('No blocks found');
        }

        return Flow.lastBlock.getVar(varName);
    }

    /**
     * Call the Func in a deferred way
     * The actuall process is not triggerd until the Flow ins being executed
     *
     * Example:
     * Flow f = new Flow()
     *     .var('ret', Flow.call(R.constant.apply('a')));
     * // Set value 'a' to 'ret', by calling a 'constant' Func that always returns the value it has received
     *
     * @param f The Func to call
     * @return IInvocation
     * */
    public static IInvocation call(Func f) {
        return call(f, new List<Object>());
    }

    /**
     * Call the Func in a deferred way
     * The actuall process is not triggerd until the Flow ins being executed
     *
     * Example:
     * Flow f = new Flow()
     *     .var('ret', Flow.call(R.inc, 1));
     * // Set the value of 'ret' to be 1 incremented by 1
     *
     * @param f The Func to call
     * @param var1 The first variable
     * @return IInvocation
     * */
    public static IInvocation call(Func f, Object var1) {
        return call(f, new List<Object>{ var1 });
    }

    /**
     * Call the Func in a deferred way
     * The actuall process is not triggerd until the Flow ins being executed
     *
     * Example:
     * Flow f = new Flow()
     *     .var('ret', Flow.call(R.add, 1, 2));
     * // Set the value of 'ret' to be 1 added by 2
     *
     * @param f The Func to call
     * @param var1 The first variable
     * @param var2 The second variable
     * @return IInvocation
     * */
    public static IInvocation call(Func f, Object var1, Object var2) {
        return call(f, new List<Object>{ var1, var2 });
    }

    /**
     * Call the Func in a deferred way
     * The actuall process is not triggerd until the Flow ins being executed
     *
     * Example:
     * Flow f = new Flow()
     *     .var('ret', Flow.call(R.product, 1, 2, 3));
     * // Set the value of 'ret' to be 1 * 2 * 3
     *
     * @param f The Func to call
     * @param var1 The first variable
     * @param var2 The second variable
     * @param var3 The third variable
     * @return IInvocation
     * */
    public static IInvocation call(Func f, Object var1, Object var2, Object var3) {
        return call(f, new List<Object>{ var1, var2, var3 });
    }

    /**
     * Call the Func in a deferred way
     * The actuall process is not triggerd until the Flow ins being executed
     *
     * Example:
     * Flow f = new Flow()
     *     .var('ret', Flow.call(R.product, new List<Object>{ 1, 2, 3 }));
     * // Set the value of 'ret' to be 1 * 2 * 3
     *
     * @param f The Func to call
     * @param vars The variables
     * @return IInvocation
     * */
    public static IInvocation call(Func f, List<Object> vars) {
        if(Flow.lastBlock == null) {
            throw new FlowException('No blocks found');
        }

        return Flow.lastBlock.call(f, vars);
    }

    /**
     * Register Funcs to the Flow APIs
     *
     * Example:
     * Flow.addFuncs(new Map<String, Func>{ 'plus' => R.add });
     *
     * Flow f = new Flow()
     *     .doReturn('plus(1, 2)');
     *
     * @param funcs The new Funcs
     * */
    public static void addFuncs(Map<String, Func> funcs) {
        for(String name : funcs.keySet()) {
            addFunc(name, funcs.get(name));
        }
    }

    /**
     * Register Funcs to the Flow APIs
     *
     * Example:
     * Flow.addFuncs('plus', R.add);
     *
     * Flow f = new Flow()
     *     .doReturn('plus(1, 2)');
     *
     * @param name The name of the Func
     * @param f The new Func
     * */
    public static void addFunc(String name, Func f) {
        if(name != null && f != null) {
            Flow.API.put(name, f);
        }
    }

    /**
     * Remove all registered Funcs
     *
     * Example:
     * Flow.removeAllFuncs();
     *
     * */
    public static void removeAllFuncs() {
        Flow.API.clear();
    }

    private static Boolean toBoolean(Object value) {
        return (Boolean)R.toBoolean.run(value);
    }

    private static String toString(Object value) {
        return (String)R.toString.run(value);
    }

    private static List<Object> toList(Object value) {
        return (List<Object>)R.toList.run(value);
    }

    private static Set<String> toSet(Object value) {
        return (Set<String>)R.toSet.run(value);
    }

    private static Map<String, Object> extractVariables(Map<String, Object> all, Map<String, Object> scope) {
        Map<String, Object> resultVariables = new Map<String, Object>();

        for(String varName : scope.keySet()) {
            resultVariables.put(varName, all.get(varName));
        }

        return resultVariables;
    }

    private static Object getComputedValue(Object value, Map<String, Object> context) {
        if(value instanceof IInvocation) {
            IInvocation invocation = (IInvocation)value;
            return invocation.invoke(context);
        }
        else {
            return value;
        }
    }

    private static Object getComputedValue(Object value) {
        return getComputedValue(value, null);
    }

    private static Object getValue(String varName, Block body, Map<String, Object> context) {
        if(context == null) {
            context = new Map<String, Object>();
        }

        if(context.containsKey(varName)) {
            return context.get(varName);
        }

        if(body.hasVariable(varName)) {
            return body.getVariable(varName);
        }

        return Flow.API.get(varName);
    }

    private static String stringOf(Object value) {
        return value == null ? 'null' : String.valueOf(value);
    }

    private static Boolean isInteger(String val) {
        try {
            Integer.valueOf(val);
            return true;
        }
        catch(Exception e) {
            return false;
        }
    }

    private static Object getReturnValue(Object val, Type returnVarType) {
        if(returnVarType == Boolean.class) {
            return R.toBoolean.run(val);
        }
        else if(returnVarType == Integer.class) {
            return R.toInteger.run(val);
        }
        else if(returnVarType == Long.class) {
            return R.toLong.run(val);
        }
        else if(returnVarType == Double.class) {
            return R.toDouble.run(val);
        }
        else if(returnVarType == Decimal.class) {
            return R.toDecimal.run(val);
        }
        else if(returnVarType == String.class) {
            return R.toString.run(val);
        }
        else if(returnVarType == List<Object>.class) {
            return R.toList.run(val);
        }
        else if(returnVarType == Set<String>.class) {
            return R.toSet.run(val);
        }
        else if(returnVarType == Map<String, Object>.class) {
            return R.toMap.run(val);
        }
        else if(returnVarType == SObject.class) {
            return R.toSObject.run(val);
        }
        else if(returnVarType == Date.class) {
            return R.toDate.run(val);
        }
        else if(returnVarType == Time.class) {
            return R.toTime.run(val);
        }
        else if(returnVarType == Datetime.class) {
            return R.toDatetime.run(val);
        }
        else if(returnVarType == Func.class) {
            return R.toFunc.run(val);
        }
        else {
            return val;
        }
    }

    /**
     * Block represents the block of code to be executed
     *
     * A Block contains a list of statements
     *
     * A Block has global variables and local variables
     * Global variables are passed in from outside and local variables are created inside the block
     *
     * Local variables are not visible to outside of the block
     *
     * A variable can only be either a global variable or a local variable, so there are no
     * duplicate variables that exist in both global variales and local variables
     *
     * */
    public class Block {
        // The global variables of the Block
        private Map<String, Object> globalVariables = null;

        // The local variables of the Block
        private Map<String, Object> localVariables = null;

        // Statements in the block
        private List<IStatement> statements = new List<IStatement>();

        /**
         * Construct a default block
         * */
        public Block() {
            Flow.lastBlock = this;
        }

        /**
         * Execute the block with the variables
         *
         * Example:
         * Flow.block()
         *     .var('b = a')
         *     .execute(new Map<String, Object>{ 'a' => 1, 'b' => null });
         *
         * @param variables The variables
         * @return Map<String, Object>
         * */
        public Map<String, Object> execute(Map<String, Object> variables) {
            this.globalVariables = new Map<String, Object>(variables);
            this.localVariables = new Map<String, Object>();

            Map<String, Object> contextVariables = this.getVariables();

            for(IStatement expr : this.statements) {
                contextVariables = expr.execute(contextVariables);

                this.setVariables(contextVariables);
            }

            return this.globalVariables;
        }

        /**
         * Get a deferred variable value from this block
         *
         * @param varName The variable name
         * @return IInvocation
         * */
        public IInvocation getVar(String varName) {
            return new VariableInvocation(this, varName);
        }

        /**
         * Get a deferred Func call
         *
         * @param f The Func
         * @return IInvocation
         * */
        public IInvocation call(Func f) {
            return this.call(f, new List<Object>());
        }

        /**
         * Get a deferred Func call
         *
         * @param f The Func
         * @param var1 The first variable
         * @return IInvocation
         * */
        public IInvocation call(Func f, Object var1) {
            return this.call(f, new List<Object>{ var1 });
        }

        /**
         * Get a deferred Func call
         *
         * @param f The Func
         * @param var1 The first variable
         * @param var2 The second variable
         * @return IInvocation
         * */
        public IInvocation call(Func f, Object var1, Object var2) {
            return this.call(f, new List<Object>{ var1, var2 });
        }

        /**
         * Get a deferred Func call
         *
         * @param f The Func
         * @param var1 The first variable
         * @param var2 The second variable
         * @param var3 The third variable
         * @return IInvocation
         * */
        public IInvocation call(Func f, Object var1, Object var2, Object var3) {
            return this.call(f, new List<Object>{ var1, var2, var3 });
        }

        /**
         * Get a deferred Func call
         *
         * @param f The Func
         * @param vars The variables
         * @return IInvocation
         * */
        public IInvocation call(Func f, List<Object> vars) {
            return new FunctionInvocation(this, f, vars);
        }

        private Block addStatement(IStatement expr) {
            this.statements.add(expr);

            Flow.lastBlock = this;

            return this;
        }

        /**
         * Set the value of the variable
         *
         * Example:
         * Flow.block()
         *     .var('num = 1');
         *
         * @param statement The statement to set the value
         * @return Block
         * */
        public Block var(String statement) {
            if(!String.isBlank(statement)) {
                Integer pos = statement.indexOf('=');
                if(pos > 0) {
                    String varName = statement.substring(0, pos).trim();
                    String expr = statement.substring(pos + 1).trim();

                    return this.var(varName, Flow.s(expr));
                }
                else {
                    throw new FlowException('Invalid expression for: ' + statement);
                }
            }

            return this;
        }

        /**
         * Set the value of the variable
         *
         * Example:
         * Flow.block()
         *     .var('num', 0);
         *
         * @param varName The variable name
         * @param value The variable value
         * @return Block
         * */
        public Block var(String varName, Object value) {
            this.addStatement(new VarStatement(varName, value));

            return this;
        }

        /**
         * Execute an 'if' block
         *
         * Example:
         * Flow.block()
         *     .doIf('n == 1', Flow.block()...);
         *
         * @param condition The condition
         * @param thenBlock The then block
         * @return Block
         * */
        public Block doIf(Object condition, Block thenBlock) {
            return this.doIf(condition, thenBlock, null);
        }

        /**
         * Execute an 'if/else' block
         *
         * Example:
         * Flow.block()
         *     .doIf('n == 1', Flow.block()..., Flow.block()...);
         *
         * @param condition The condition
         * @param thenBlock The then block
         * @param elseBlock The else block
         * @return Block
         * */
        public Block doIf(Object condition, Block thenBlock, Block elseBlock) {
            Object cond = condition;
            if(cond instanceof String) {
                cond = Flow.s((String)cond);
            }

            this.addStatement(new IfStatement(cond, thenBlock, elseBlock, false));

            return this;
        }

        /**
         * Execute an 'if not' block
         *
         * Example:
         * Flow.block()
         *     .doIfNot('n == 1', Flow.block()...);
         *
         * @param condition The condition
         * @param thenBlock The then block
         * @return Block
         * */
        public Block doIfNot(Object condition, Block thenBlock) {
            return this.doIfNot(condition, thenBlock, null);
        }

        /**
         * Execute an 'if not/else' block
         *
         * Example:
         * Flow.block()
         *     .doIfNot('n == 1', Flow.block()..., Flow.block()...);
         * // If n != 1, then ..., else ...
         *
         * @param condition The condition
         * @param thenBlock The then block
         * @param elseBlock The else block
         * @return Block
         * */
        public Block doIfNot(Object condition, Block thenBlock, Block elseBlock) {
            Object cond = condition;
            if(cond instanceof String) {
                cond = Flow.s((String)cond);
            }

            this.addStatement(new IfStatement(cond, thenBlock, elseBlock, true));

            return this;
        }

        /**
         * Execute a 'for' block in the form of 'i = 0; i != 10; i = i + 1'
         *
         * Example:
         * Flow.block()
         *     .doFor('i', 0, Flow.s('i != 10'), Flow.s('i + 1'), Flow.block()...);
         *
         * @param varName The variable name
         * @param initialValue The initial value
         * @param endCheck The end check
         * @param nextStep The next value
         * @param body The loop block
         * @return Block
         * */
        public Block doFor(String varName, Object initialValue, Object endCheck, Object nextStep, Block body) {
            this.addStatement(new ForStatement(varName, initialValue, endCheck, nextStep, body));

            return this;
        }

        /**
         * Execute a 'for' block in the form of 'i in numbers'
         *
         * Example:
         * Flow.block()
         *     .doFor('i', Flow.s('numbers'), Flow.block()...);
         *
         * @param varName The variable name
         * @param rangeValue The range value
         * @param body The loop block
         * @return Block
         * */
        public Block doFor(String varName, Object rangeValue, Block body) {
            this.addStatement(new ForStatement(varName, rangeValue, body));

            return this;
        }

        /**
         * Execute a simplified 'for' block
         *
         * Example:
         * Flow.block()
         *     .doFor('i = 0; i != 10; i = i + 1', Flow.block()...);
         *
         * Flow.block()
         *     .doFor('i in numbers', Flow.block()...);
         *
         * @param statement The for loop statement
         * @param body The loop body
         * @return Block
         * */
        public Block doFor(String statement, Block body) {
            if(!String.isBlank(statement)) {
                if(statement.contains(';')) {
                    List<String> parts = statement.split(';');
                    if(parts.size() >= 3) {
                        String initial = parts.get(0).trim();
                        String check = parts.get(1).trim();
                        String next = parts.get(2).trim();

                        Integer pos = initial.indexOf('=');
                        if(pos > 0) {
                            String varName = initial.substring(0, pos).trim();
                            Object initialValue = Flow.s(initial.substring(pos + 1).trim());
                            Object endCheck = Flow.s(check);

                            pos = next.indexOf('=');
                            if(pos > 0) {
                                Object nextStep = Flow.s(next.substring(pos + 1).trim());

                                return doFor(varName, initialValue, endCheck, nextStep, body);
                            }
                        }
                    }
                }
                else {
                    Integer pos = statement.indexOf(' in ');
                    if(pos > 0) {
                        String varName = statement.substring(0, pos).trim();
                        Object rangeValue = Flow.s(statement.substring(pos + 4).trim());

                        return doFor(varName, rangeValue, body);
                    }
                }

                throw new FlowException('Invalid expression for: ' + statement);
            }

            return this;
        }

        /**
         * Execute a 'while' block
         *
         * Example:
         * Flow.block()
         *     .doWhile('n != 10', Flow.block()...);
         *
         * @param condition The condition
         * @param body The while body
         * @return Block
         * */
        public Block doWhile(Object condition, Block body) {
            if(condition instanceof String) {
                condition = Flow.s((String)condition);
            }

            this.addStatement(new WhileStatement(condition, body));

            return this;
        }

        /**
         * Execute a 'switch' block
         *
         * Example:
         * Flow.block()
         *     .doSwitch('word', new List<Object>{
         *         'a', Flow.block()...,
         *         'b', Flow.block()...
         *     });
         *
         * @param switchValue The switch value to be tested
         * @param segments The list of switch segments
         * @return Block
         * */
        public Block doSwitch(Object switchValue, List<Object> segments) {
            if(switchValue instanceof String) {
                switchValue = Flow.s((String)switchValue);
            }

            this.addStatement(new SwitchStatement(switchValue, segments));

            return this;
        }

        /**
         * Print the debug information of the current variables in the block
         *
         * Example:
         * Flow.block()
         *     .var('n = 1')
         *     .debug();
         *
         * @return Block
         * */
        public Block debug() {
            this.addStatement(new DebugStatement());

            return this;
        }

        /**
         * Return the object, if it is String, treat it as a FlowScript
         *
         * Example:
         * Flow.block()
         *     .doReturn('"message"');
         *
         * @param returnValue The return value
         * @return Block
         * */
        public Block doReturn(Object returnValue) {
            if(returnValue instanceof String) {
                returnValue = Flow.s((String)returnValue);
            }

            return this.doReturnRaw(returnValue);
        }

        /**
         * Return the raw object, if it is String, it is not treated specially
         *
         * Example:
         * Flow.block()
         *     .doReturnRaw('message');
         *
         * @param returnValue The return value
         * @return Block
         * */
        public Block doReturnRaw(Object returnValue) {
            this.addStatement(new ReturnStatement(returnValue));

            return this;
        }

        /**
         * Break at the current code of the block
         *
         * Example:
         * Flow.block()
         *     .doFor('i in numbers', Flow.block().doBreak());
         *
         * @return Block
         * */
        public Block doBreak() {
            this.addStatement(new BreakStatement());

            return this;
        }

        /**
         * Continue at the current code of the block
         *
         * Example:
         * Flow.block()
         *     .doFor('i in numbers', Flow.block().doContinue());
         *
         * @return Block
         * */
        public Block doContinue() {
            this.addStatement(new ContinueStatement());

            return this;
        }

        // Get all variables of the block
        Map<String, Object> getVariables() {
            Map<String, Object> variables = new Map<String, Object>();
            variables.putAll(this.globalVariables);
            variables.putAll(this.localVariables);

            return variables;
        }

        // Set the variables of the block
        void setVariables(Map<String, Object> variables) {
            for(String varName : variables.keySet()) {
                this.setVariable(varName, variables.get(varName));
            }
        }

        // Set the specific variable of the block
        void setVariable(String varName, Object value) {
            if(this.globalVariables.containsKey(varName)) {
                this.globalVariables.put(varName, value);
            }
            else {
                this.localVariables.put(varName, value);
            }
        }

        // Get the value of the variable in the block
        Object getVariable(String varName) {
            if(this.localVariables.containsKey(varName)) {
                return this.localVariables.get(varName);
            }
            else if(this.globalVariables.containsKey(varName)) {
                return this.globalVariables.get(varName);
            }
            else {
                return null;
            }
        }

        // Check if the block has the variable
        Boolean hasVariable(String varName) {
            return (this.localVariables != null && this.localVariables.containsKey(varName)) ||
                (this.globalVariables != null && this.globalVariables.containsKey(varName));
        }
    }

    /**
     * A statement is a line of code in a block
     * */
    interface IStatement {
        Map<String, Object> execute(Map<String, Object> variables);
    }

    class VarStatement implements IStatement {
        private String varName;
        private Object value;

        public VarStatement(String varName, Object value) {
            this.varName = varName;
            this.value = value;
        }

        public Map<String, Object> execute(Map<String, Object> variables) {
            Object val = getComputedValue(this.value);

            variables.put(this.varName, val);

            return variables;
        }
    }

    class IfStatement implements IStatement {
        private Object condition;
        private Block thenBlock;
        private Block elseBlock;
        private Boolean negate;

        public IfStatement(Object condition, Block thenBlock, Block elseBlock, Boolean negate) {
            this.condition = condition;
            this.thenBlock = thenBlock;
            this.elseBlock = elseBlock;
            this.negate = negate;
        }

        public Map<String, Object> execute(Map<String, Object> variables) {
            if(this.thenBlock == null) {
                return variables;
            }

            Boolean pass = toBoolean(getComputedValue(this.condition, variables));

            if(negate) {
                pass = !pass;
            }

            if(pass) {
                return this.thenBlock.execute(variables);
            }
            else {
                if(this.elseBlock != null) {
                    return this.elseBlock.execute(variables);
                }
            }

            return variables;
        }
    }

    class ForStatement implements IStatement {
        private String varName;
        private Object initialValue;
        private Object endCheck;
        private Object nextStep;
        private Object rangeValue;
        private Block body;

        public ForStatement(String varName, Object initialValue, Object endCheck, Object nextStep, Block body) {
            this.varName = varName;
            this.initialValue = initialValue;
            this.endCheck = endCheck;
            this.nextStep = nextStep;
            this.body = body;
        }

        public ForStatement(String varName, Object rangeValue, Block body) {
            this.varName = varName;
            this.rangeValue = rangeValue;
            this.body = body;
        }

        public Map<String, Object> execute(Map<String, Object> variables) {
            if(this.body == null) {
                return variables;
            }

            Map<String, Object> contextVariables = new Map<String, Object>(variables);

            if(this.rangeValue != null) {
                Object rawValue = getComputedValue(this.rangeValue, contextVariables);
                if(rawValue instanceof List<Object>) {
                    List<Object> values = toList(rawValue);

                    for(Object value : values) {
                        contextVariables.put(this.varName, value);

                        try {
                            contextVariables = this.body.execute(contextVariables);
                        }
                        catch(BreakException e) {
                            contextVariables = e.getVariables();
                            break;
                        }
                        catch(ContinueException e) {
                            contextVariables = e.getVariables();
                            continue;
                        }
                    }
                }
                else if(rawValue instanceof Set<String>) {
                    Set<String> values = toSet(rawValue);

                    for(String value : values) {
                        contextVariables.put(this.varName, value);

                        try {
                            contextVariables = this.body.execute(contextVariables);
                        }
                        catch(BreakException e) {
                            contextVariables = e.getVariables();
                            break;
                        }
                        catch(ContinueException e) {
                            contextVariables = e.getVariables();
                            continue;
                        }
                    }
                }
                else {
                    throw new FlowException('Cannot loop over: ' + stringOf(rawValue));
                }
            }
            else {
                Object init = getComputedValue(this.initialValue, contextVariables);
                Object value = init;
                contextVariables.put(this.varName, value);
                while(true) {
                    Boolean pass = toBoolean(getComputedValue(this.endCheck, contextVariables));
                    if(!pass) {
                        break;
                    }

                    try {
                        contextVariables = this.body.execute(contextVariables);
                    }
                    catch(BreakException e) {
                        contextVariables = e.getVariables();
                        break;
                    }
                    catch(ContinueException e) {
                        contextVariables = e.getVariables();
                        continue;
                    }

                    value = getComputedValue(this.nextStep, contextVariables);
                    contextVariables.put(this.varName, value);
                }
            }

            return extractVariables(contextVariables, variables);
        }
    }

    class WhileStatement implements IStatement {
        private Object condition;
        private Block body;

        public WhileStatement(Object condition, Block body) {
            this.condition = condition;
            this.body = body;
        }

        public Map<String, Object> execute(Map<String, Object> variables) {
            Boolean pass = null;
            while(true) {
                pass = toBoolean(getComputedValue(this.condition, variables));
                if(!pass) {
                    break;
                }

                if(this.body != null) {
                    try {
                        variables = this.body.execute(variables);
                    }
                    catch(BreakException e) {
                        variables = e.getVariables();
                        break;
                    }
                    catch(ContinueException e) {
                        variables = e.getVariables();
                        continue;
                    }
                }
            }

            return variables;
        }
    }

    class SwitchStatement implements IStatement {
        private Object switchValue;
        private List<Object> segments;

        public SwitchStatement(Object switchValue, List<Object> segments) {
            this.switchValue = switchValue;
            this.segments = segments;
        }

        public Map<String, Object> execute(Map<String, Object> variables) {
            if(this.segments == null || this.segments.size() < 2) {
                return variables;
            }

            Object switchValue = getComputedValue(this.switchValue, variables);

            for(Integer i = 0; i < this.segments.size() - 1; i += 2) {
                Object conditionValue = getComputedValue(this.segments.get(i), variables);

                Boolean pass = false;
                if(conditionValue instanceof Boolean) {
                    pass = toBoolean(conditionValue);
                }
                else {
                    pass = (conditionValue == switchValue);
                }

                if(!pass) {
                    continue;
                }

                Object bodyObj = this.segments.get(i + 1);
                if(!(bodyObj instanceof Block)) {
                    throw new FlowException('Some segments in switch-case statements are not instances of Block');
                }
                Block body = (Block)bodyObj;

                try {
                    variables = body.execute(variables);
                }
                catch(BreakException e) {
                    variables = e.getVariables();
                    break;
                }
            }

            return variables;
        }
    }

    class DebugStatement implements IStatement {
        public Map<String, Object> execute(Map<String, Object> variables) {
            for(String varName : variables.keySet()) {
                Object value = variables.get(varName);

                System.debug('Variable: ' + varName + ' => ' + stringOf(value));
            }

            return variables;
        }
    }

    class ReturnStatement implements IStatement {
        private Object returnValue;

        public ReturnStatement(Object returnValue) {
            this.returnValue = returnValue;
        }

        public Map<String, Object> execute(Map<String, Object> variables) {
            Object value = getComputedValue(this.returnValue, variables);

            throw new ReturnException(value);

            return variables;
        }
    }

    class BreakStatement implements IStatement {
        public Map<String, Object> execute(Map<String, Object> variables) {
            throw new BreakException(variables);

            return variables;
        }
    }

    class ContinueStatement implements IStatement {
        public Map<String, Object> execute(Map<String, Object> variables) {
            throw new ContinueException(variables);

            return variables;
        }
    }

    public interface IInvocation {
        Object invoke();

        Object invoke(Map<String, Object> context);
    }

    class VariableInvocation implements IInvocation {
        private Block body;
        private String varName;

        public VariableInvocation(Block body, String varName) {
            this.body = body;
            this.varName = varName;
        }

        public Object invoke(Map<String, Object> context) {
            return getValue(this.varName, this.body, context);
        }

        public Object invoke() {
            return this.invoke(null);
        }
    }

    class FunctionInvocation extends Func implements IInvocation {
        private Block body;
        private Func f;
        private List<Object> vars;

        public FunctionInvocation(Block body, Func f, List<Object> vars) {
            super(0);

            this.body = body;
            this.f = f;
            this.vars = vars;
        }

        public override Object exec() {
            return this.invoke();
        }

        public Object invoke(Map<String, Object> context) {
            List<Object> args = new List<Object>();
            for(Object var : this.vars) {
                Object arg = null;
                if(var instanceof IInvocation) {
                    arg = ((IInvocation)var).invoke(context);
                }
                else {
                    arg = var;
                }
                args.add(arg);
            }

            return this.f.runN(args);
        }

        public Object invoke() {
            return this.invoke(null);
        }
    }

    public class FlowException extends Exception {
    }

    class ReturnException extends Exception {
        private Object value;

        public ReturnException(Object value) {
            this.value = value;
        }

        public Object getValue() {
            return this.value;
        }
    }

    class BreakException extends Exception {
        private Map<String, Object> variables;

        public BreakException(Map<String, Object> variables) {
            this.variables = variables;
        }

        public Map<String, Object> getVariables() {
            return this.variables;
        }
    }

    class ContinueException extends Exception {
        private Map<String, Object> variables;

        public ContinueException(Map<String, Object> variables) {
            this.variables = variables;
        }

        public Map<String, Object> getVariables() {
            return this.variables;
        }
    }

    private class MemberFunc extends Func {
        public MemberFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String property = toString(arg1);
            Object target = arg2;

            if(target instanceof List<Object> && isInteger(property)) {
                return ((List<Object>)target).get(Integer.valueOf(property));
            }
            else if(target instanceof Map<String, Object>) {
                return ((Map<String, Object>)target).get(property);
            }
            else if(target instanceof String && isInteger(property)) {
                return ((String)target).split('').get(Integer.valueOf(property));
            }
            else if(target instanceof SObject) {
                return ((SObject)target).get(property);
            }

            return arg2;
        }
    }

    private class ConditionalFunc extends Func {
        public ConditionalFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Object test = arg1;
            Object consequent = arg2;
            Object alternate = arg3;

            if(test != null && test instanceof Boolean) {
                if((Boolean)test) {
                    return consequent;
                }
                else {
                    return alternate;
                }
            }
            else {
                throw new FlowException('Failed to execute conditional expression as test is not boolean');
            }
        }
    }

    private class ArrayFunc extends Func {
        public ArrayFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> deferredList = (List<Object>)arg;
            List<Object> mList = new List<Object>();

            for(Object deferred : deferredList) {
                mList.add(getComputedValue(deferred));
            }

            return mList;
        }
    }

    private class MapFunc extends Func {
        public MapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> deferredMap = (Map<String, Object>)arg;
            Map<String, Object> mMap = new Map<String, Object>();

            for(String key : deferredMap.keySet()) {
                mMap.put(key, getComputedValue(deferredMap.get(key)));
            }

            return mMap;
        }
    }

    /**
     * Customized script engine for FlowScript
     * */
    class ScriptEngine {
        public ScriptEngine() {
        }

        private Object evalIdentifier(String name, Map<String, Object> context) {
            return Flow.getVar(name);
        }

        private Object evalMember(Object target, String property, Map<String, Object> context) {
            return Flow.call(Flow.member, property, target);
        }

        private Object evalThis(Map<String, Object> context) {
            return Flow.self;
        }

        private Object evalCall(Object callee, List<Object> arguments, Map<String, Object> context) {
            Func f = (Func)getComputedValue(callee);
            if(f == null) {
                throw new FlowException('Cannot find function: ' + stringOf(callee));
            }

            return Flow.call(f, arguments);
        }

        public Object eval(String code) {
            Jsep.Node node = cache.get(code);
            if(node == null) {
                node = new Jsep(code).parse();
                cache.put(code, node);
            }

            return this.eval(node, null);
        }

        private Object eval(Jsep.Node node, Map<String, Object> context) {
            if(context == null) {
                context = new Map<String, Object>();
            }

            if(node instanceof Jsep.CompoundNode) {
                return eval((Jsep.CompoundNode)node, context);
            }
            else if(node instanceof Jsep.IdentifierNode) {
                return eval((Jsep.IdentifierNode)node, context);
            }
            else if(node instanceof Jsep.MemberExpressionNode) {
                return eval((Jsep.MemberExpressionNode)node, context);
            }
            else if(node instanceof Jsep.LiteralNode) {
                return eval((Jsep.LiteralNode)node, context);
            }
            else if(node instanceof Jsep.ThisExpressionNode) {
                return eval((Jsep.ThisExpressionNode)node, context);
            }
            else if(node instanceof Jsep.CallExpressionNode) {
                return eval((Jsep.CallExpressionNode)node, context);
            }
            else if(node instanceof Jsep.UnaryExpressionNode) {
                return eval((Jsep.UnaryExpressionNode)node, context);
            }
            else if(node instanceof Jsep.BinaryExpressionNode) {
                return eval((Jsep.BinaryExpressionNode)node, context);
            }
            else if(node instanceof Jsep.LogicalExpressionNode) {
                return eval((Jsep.LogicalExpressionNode)node, context);
            }
            else if(node instanceof Jsep.ConditionalExpressionNode) {
                return eval((Jsep.ConditionalExpressionNode)node, context);
            }
            else if(node instanceof Jsep.ArrayExpressionNode) {
                return eval((Jsep.ArrayExpressionNode)node, context);
            }
            else if(node instanceof Jsep.AssignmentExpressionNode) {
                return eval((Jsep.AssignmentExpressionNode)node, context);
            }
            else if(node instanceof Jsep.ObjectExpressionNode) {
                return eval((Jsep.ObjectExpressionNode)node, context);
            }

            throw new FlowException('Invalid node to evaluate');
        }

        private Object eval(Jsep.CompoundNode node, Map<String, Object> context) {
            throw new FlowException('Compound node not supported');
        }

        private Object eval(Jsep.IdentifierNode node, Map<String, Object> context) {
            return this.evalIdentifier(node.name, context);
        }

        private Object eval(Jsep.MemberExpressionNode node, Map<String, Object> context) {
            Object target = this.eval(node.target, context);
            String property = null;
            if(node.computed) {
                property = String.valueOf(this.eval(node.property, context));
            }
            else {
                property = ((Jsep.IdentifierNode)node.property).name;
            }
            return this.evalMember(target, property, context);
        }

        private Object eval(Jsep.LiteralNode node, Map<String, Object> context) {
            return Flow.call(R.constant.apply(node.value));
        }

        private Object eval(Jsep.ThisExpressionNode node, Map<String, Object> context) {
            return this.evalThis(context);
        }

        private Object eval(Jsep.CallExpressionNode node, Map<String, Object> context) {
            Object callee = this.eval(node.callee, context);
            List<Object> arguments = new List<Object>();
            for(Jsep.Node argNode : node.arguments) {
                arguments.add(this.eval(argNode, context));
            }

            return this.evalCall(callee, arguments, context);
        }

        private Object eval(Jsep.UnaryExpressionNode node, Map<String, Object> context) {
            Object val = this.eval(node.argument, context);
            String op = node.operator;
            if(op == '-') {
                return Flow.call(R.negate, val);
            }
            else if(op == '!') {
                return Flow.call(R.doNot, val);
            }
            else if(op == '++') {
                return Flow.call(R.inc, val);
            }
            else if(op == '--') {
                return Flow.call(R.dec, val);
            }
            else {
                throw new FlowException('Unsupported operator for "' + op + '"');
            }
        }

        private Object eval(Jsep.BinaryExpressionNode node, Map<String, Object> context) {
            Object left = this.eval(node.left, context);
            Object right = this.eval(node.right, context);
            String operator = node.operator;
            if(operator == '==') {
                return Flow.call(R.equals, left, right);
            }
            else if(operator == '!=') {
                return Flow.call(R.doNot, Flow.call(R.equals, left, right));
            }
            else if(operator == '<') {
                return Flow.call(R.lt, left, right);
            }
            else if(operator == '>') {
                return Flow.call(R.gt, left, right);
            }
            else if(operator == '<=') {
                return Flow.call(R.lte, left, right);
            }
            else if(operator == '>=') {
                return Flow.call(R.gte, left, right);
            }
            else if(operator == '+') {
                return Flow.call(R.add, left, right);
            }
            else if(operator == '-') {
                return Flow.call(R.subtract, left, right);
            }
            else if(operator == '*') {
                return Flow.call(R.multiply, left, right);
            }
            else if(operator == '/') {
                return Flow.call(R.divide, left, right);
            }
            else if(operator == '%') {
                return Flow.call(R.mod, left, right);
            }
            else {
                throw new FlowException('Unsupported operator for "' + operator + '"');
            }
        }

        private Object eval(Jsep.LogicalExpressionNode node, Map<String, Object> context) {
            Object left = this.eval(node.left, context);
            Object right = this.eval(node.right, context);
            String operator = node.operator;
            if(operator == '&&') {
                return Flow.call(R.doAnd, left, right);
            }
            else if(operator == '||') {
                return Flow.call(R.doOr, left, right);
            }
            else {
                throw new FlowException('Unsupported operator for "' + operator + '"');
            }
        }

        private Object eval(Jsep.AssignmentExpressionNode node, Map<String, Object> context) {
            throw new FlowException('Assignment is not supported');

            return null;
        }

        private Object eval(Jsep.ConditionalExpressionNode node, Map<String, Object> context) {
            Object test = this.eval(node.test, context);
            Object consequent = this.eval(node.consequent, context);
            Object alternate = this.eval(node.alternate, context);

            return Flow.call(Flow.conditional, test, consequent, alternate);
        }

        private Object eval(Jsep.ArrayExpressionNode node, Map<String, Object> context) {
            List<Object> mList = new List<Object>();
            for(Jsep.Node elementNode : node.elements) {
                mList.add(this.eval(elementNode, context));
            }

            return Flow.call(Flow.deferredArray.apply(mList));
        }

        private Object eval(Jsep.ObjectExpressionNode node, Map<String, Object> context) {
            Map<String, Object> mMap = new Map<String, Object>();
            for(Jsep.Node key : node.data.keySet()) {
                Jsep.Node value = node.data.get(key);
                String keyStr = null;
                if(key instanceof Jsep.LiteralNode) {
                    keyStr = String.valueOf(((Jsep.LiteralNode)key).value);
                }
                else {
                    keyStr = ((Jsep.IdentifierNode)key).name;
                }

                mMap.put(keyStr, this.eval(value, context));
            }

            return Flow.call(Flow.deferredMap.apply(mMap));
        }
    }
}
