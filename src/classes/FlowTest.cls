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
@isTest
private class FlowTest {
    @isTest
    private static void varTest() {
        Flow f = new Flow()
            .var('tmp', Flow.getVar('x'))
            .var('x', Flow.getVar('y'))
            .var('y', Flow.getVar('tmp'))
            .debug();

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'x' => 'x',
            'y' => 'y'
        });

        System.assertEquals('y', data.get('x'));
        System.assertEquals('x', data.get('y'));
    }

    @isTest
    private static void scriptVarTest() {
        Flow f = new Flow()
            .var('tmp = x')
            .var('x = y')
            .var('y = tmp')
            .debug();

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'x' => 'x',
            'y' => 'y'
        });

        System.assertEquals('y', data.get('x'));
        System.assertEquals('x', data.get('y'));
    }

    @isTest
    private static void callTest() {
        Flow f = new Flow()
            .var('result', Flow.call(R.add, Flow.getVar('a'), Flow.getVar('b')));

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'a' => 1,
            'b' => 2,
            'result' => null
        });

        System.assertEquals(3, data.get('result'));
    }

    @isTest
    private static void scriptCallTest() {
        Flow f = new Flow()
            .var('result = a + b');

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'a' => 1,
            'b' => 2,
            'result' => null
        });

        System.assertEquals(3, data.get('result'));
    }

    @isTest
    private static void ifTest() {
        Flow f = new Flow()
            .doIf(
                Flow.getVar('flag'),
                Flow.block()
                    .var('result', 'then'),
                Flow.block()
                    .var('result', 'else')
            );

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'flag' => true,
            'result' => null
        });
        System.assertEquals('then', data.get('result'));

        data = f.execute(new Map<String, Object>{
            'flag' => false,
            'result' => null
        });
        System.assertEquals('else', data.get('result'));
    }

    @isTest
    private static void runFlowTest() {
        Flow f = new Flow()
            .inputAs('x', 'y').returnInteger()
            .var('sum', Flow.call(R.add, Flow.getVar('x'), Flow.getVar('y')))
            .doReturn(Flow.getVar('sum'));

        Integer result = (Integer)f.run(1, 2);

        System.assertEquals(3, result);
    }

    @isTest
    private static void scriptRunFlowTest() {
        Flow f = new Flow()
            .inputAs('x', 'y').returnInteger()
            .var('sum = x + y')
            .doReturn('sum');

        Integer result = (Integer)f.run(1, 2);

        System.assertEquals(3, result);
    }

    @isTest
    private static void forTest() {
        Flow f = new Flow()
            .doFor('i', 0, Flow.call(R.lt.apply(R.placeholder, 3), Flow.getVar('i')), Flow.call(R.inc, Flow.getVar('i')), Flow.block()
                .var('num', Flow.call(R.add.apply(2), Flow.getVar('num')))
            );

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'num' => 0
        });

        System.assertEquals(6, data.get('num'));
    }

    @isTest
    private static void scriptForTest() {
        Flow f = new Flow()
            .doFor('i = 0; i < 3; i = i + 1', Flow.block()
                .var('num = num + 2')
            );

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'num' => 0
        });

        System.assertEquals(6, data.get('num'));
    }

    @isTest
    private static void forInTest() {
        Flow f = new Flow()
            .doFor('i', Flow.getVar('nums'), Flow.block()
                .var('sum', Flow.call(R.add, Flow.getVar('i'), Flow.getVar('sum')))
            );

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'nums' => new List<Object>{ 1, 2, 3 },
            'sum' => 0
        });

        System.assertEquals(6, data.get('sum'));
    }

    @isTest
    private static void scriptForInTest() {
        Flow f = new Flow()
            .doFor('i in nums', Flow.block()
                .var('sum = sum + i')
            );

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'nums' => new List<Object>{ 1, 2, 3 },
            'sum' => 0
        });

        System.assertEquals(6, data.get('sum'));
    }

    @isTest
    private static void whileTest() {
        Flow f= new Flow()
            .var('i', 0)
            .var('num', 0)
            .doWhile(Flow.call(R.lt.apply(R.placeholder, 3), Flow.getVar('i')), Flow.block()
                .var('num', Flow.call(R.inc, Flow.getVar('num')))
                .var('i', Flow.call(R.inc, Flow.getVar('i')))
            );

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'num' => null
        });

        System.assertEquals(3, data.get('num'));
    }

    @isTest
    private static void scriptWhileTest() {
        Flow f= new Flow()
            .var('i = 0')
            .var('num = 0')
            .doWhile('i < 3', Flow.block()
                .var('num = num + 1')
                .var('i = i + 1')
            );

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'num' => null
        });

        System.assertEquals(3, data.get('num'));
    }

    @isTest
    private static void switchTest() {
        Flow f = new Flow()
            .doSwitch(Flow.getVar('name'), new List<Object>{
                'a', Flow.block().var('result', 'a'),
                'b', Flow.block().var('result', 'b')
            });

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'name' => 'b',
            'result' => null
        });

        System.assertEquals('b', data.get('result'));
    }

    @isTest
    private static void scriptSwitchTest() {
        Flow f = new Flow()
            .doSwitch('name', new List<Object>{
                'a', Flow.block().var('result = "a"'),
                'b', Flow.block().var('result = "b"')
            });

        Map<String, Object> data = f.execute(new Map<String, Object>{
            'name' => 'b',
            'result' => null
        });

        System.assertEquals('b', data.get('result'));
    }

    @isTest
    private static void recursionTest() {
        Flow f = new Flow()
            .inputAs('n').returnInteger()
            .doIf(
                Flow.call(R.equals.apply(0), Flow.getVar('n')),
                Flow.block()
                    .doReturn(0)
            )
            .var('ret', Flow.call(R.add.apply(2), Flow.call(Flow.self, Flow.call(R.dec, Flow.getVar('n')))))
            .doReturn(Flow.getVar('ret'));

        Integer result = (Integer)f.run(2);

        System.assertEquals(4, result);
    }

    @isTest
    private static void scriptRecursionTest() {
        Flow f = new Flow()
            .inputAs('n').returnInteger()
            .doIf(
                'n == 0',
                Flow.block()
                    .doReturn(0)
            )
            .var('ret = 2 + this(n - 1)')
            .doReturn('ret');

        Integer result = (Integer)f.run(2);

        System.assertEquals(4, result);
    }

    @isTest
    private static void breakTest() {
        Flow f = new Flow()
            .inputAs('numbers').returnBoolean()
            .var('found', false)
            .doFor('n', Flow.getVar('numbers'), Flow.block()
                .doIf(
                    Flow.call(R.equals.apply(1), Flow.getVar('n')),
                    Flow.block()
                        .var('found', true)
                        .doBreak()
                )
            )
            .doReturn(Flow.getVar('found'));

        Boolean ret = (Boolean)f.run(new List<Integer>{ 1, 2, 3 });

        System.assert(ret);
    }

    @isTest
    private static void scriptBreakTest() {
        Flow f = new Flow()
            .inputAs('numbers').returnBoolean()
            .var('found = false')
            .doFor('n in numbers', Flow.block()
                .doIf(
                    'n == 1',
                    Flow.block()
                        .var('found = true')
                        .doBreak()
                )
            )
            .doReturn('found');

        Boolean ret = (Boolean)f.run(new List<Integer>{ 1, 2, 3 });

        System.assert(ret);
    }

    @isTest
    private static void continueTest() {
        Flow f = new Flow()
            .inputAs('numbers').returnInteger()
            .var('count', 0)
            .doFor('n', Flow.getVar('numbers'), Flow.block()
                .doIf(
                    Flow.call(R.equals.apply(1), Flow.getVar('n')),
                    Flow.block()
                        .doContinue(),
                    Flow.block()
                        .var('count', Flow.call(R.inc, Flow.getVar('count')))
                )
            )
            .doReturn(Flow.getVar('count'));

        Integer ret = (Integer)f.run(new List<Integer>{ 1, 2, 3 });

        System.assertEquals(2, ret);
    }

    @isTest
    private static void scriptContinueTest() {
        Flow f = new Flow()
            .inputAs('numbers').returnInteger()
            .var('count = 0')
            .doFor('n in numbers', Flow.block()
                .doIf(
                    'n == 1',
                    Flow.block()
                        .doContinue(),
                    Flow.block()
                        .var('count = count + 1')
                )
            )
            .doReturn('count');

        Integer ret = (Integer)f.run(new List<Integer>{ 1, 2, 3 });

        System.assertEquals(2, ret);
    }

    @isTest
    private static void returnValueTest() {
        Flow f = new Flow()
            .inputAs('obj').returnObject()
            .doReturn(Flow.getVar('obj'));

        Object retObject = (Object)f.run(1);
        System.assert(retObject != null);

        f = new Flow()
            .inputAs('obj').returnBoolean()
            .doReturn(Flow.getVar('obj'));

        Boolean retBoolean = (Boolean)f.run(true);
        System.assert(retBoolean != null);

        f = new Flow()
            .inputAs('obj').returnInteger()
            .doReturn(Flow.getVar('obj'));

        Integer retInteger = (Integer)f.run(1);
        System.assert(retInteger != null);

        f = new Flow()
            .inputAs('obj').returnLong()
            .doReturn(Flow.getVar('obj'));

        Long retLong = (Long)f.run(1);
        System.assert(retLong != null);

        f = new Flow()
            .inputAs('obj').returnDouble()
            .doReturn(Flow.getVar('obj'));

        Double retDouble = (Double)f.run(1);
        System.assert(retDouble != null);

        f = new Flow()
            .inputAs('obj').returnDecimal()
            .doReturn(Flow.getVar('obj'));

        Decimal retDecimal = (Decimal)f.run(1);
        System.assert(retDecimal != null);

        f = new Flow()
            .inputAs('obj').returnString()
            .doReturn(Flow.getVar('obj'));

        String retString = (String)f.run('abc');
        System.assert(retString != null);

        f = new Flow()
            .inputAs('obj').returnList()
            .doReturn(Flow.getVar('obj'));

        List<Object> retList = (List<Object>)f.run(new List<String>());
        System.assert(retList != null);

        f = new Flow()
            .inputAs('obj').returnSet()
            .doReturn(Flow.getVar('obj'));

        Set<String> retSet = (Set<String>)f.run(new Set<String>());
        System.assert(retSet != null);

        f = new Flow()
            .inputAs('obj').returnMap()
            .doReturn(Flow.getVar('obj'));

        Map<String, Object> retMap = (Map<String, Object>)f.run(new Map<String, Object>());
        System.assert(retMap != null);

        f = new Flow()
            .inputAs('obj').returnSObject()
            .doReturn(Flow.getVar('obj'));

        SObject retSObject = (SObject)f.run(new Account());
        System.assert(retSObject != null);

        f = new Flow()
            .inputAs('obj').returnDate()
            .doReturn(Flow.getVar('obj'));

        Date retDate = (Date)f.run(Date.newInstance(2018, 1, 1));
        System.assert(retDate != null);

        f = new Flow()
            .inputAs('obj').returnTime()
            .doReturn(Flow.getVar('obj'));

        Time retTime = (Time)f.run(Time.newInstance(10, 0, 0, 0));
        System.assert(retTime != null);

        f = new Flow()
            .inputAs('obj').returnDatetime()
            .doReturn(Flow.getVar('obj'));

        Datetime retDatetime = (Datetime)f.run(Datetime.now());
        System.assert(retDatetime != null);

        f = new Flow()
            .inputAs('obj').returnFunc()
            .doReturn(Flow.getVar('obj'));

        Func retFunc = (Func)f.run(R.identity);
        System.assert(retFunc != null);
    }

    @isTest
    private static void memberTest() {
        Flow f = new Flow()
            .inputAs('m').returnObject()
            .doReturn(Flow.s('m.name'));

        System.assertEquals('test', f.run(new Map<String, Object>{ 'name' => 'test' }));
    }

    @isTest
    private static void evalTest() {
        Object val = Flow.eval('add(a, b)', new Map<String, Object>{
            'a' => 1,
            'b' => 2
        });

        System.assertEquals(3, val);
    }

    @isTest
    private static void unaryOperatorTest() {
        Flow f = new Flow()
            .inputAs('a')
            .doReturn(Flow.s('-a'));

        System.assertEquals(-1, f.run(1));

        f = new Flow()
            .inputAs('a')
            .doReturn(Flow.s('!a'));

        System.assertEquals(false, f.run(true));

        f = new Flow()
            .inputAs('a')
            .doReturn(Flow.s('++a'));

        System.assertEquals(2, f.run(1));

        f = new Flow()
            .inputAs('a')
            .doReturn(Flow.s('--a'));

        System.assertEquals(2, f.run(3));
    }

    @isTest
    private static void binaryOperatorTest() {
        Flow f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a == b'));

        System.assertEquals(false, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a != b'));

        System.assertEquals(true, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a < b'));

        System.assertEquals(true, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a > b'));

        System.assertEquals(false, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a <= b'));

        System.assertEquals(true, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a >= b'));

        System.assertEquals(false, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a + b'));

        System.assertEquals(3, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a - b'));

        System.assertEquals(-1, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a * b'));

        System.assertEquals(2, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a / b'));

        System.assertEquals(0.5, f.run(1, 2));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a % b'));

        System.assertEquals(1, f.run(1, 2));
    }

    @isTest
    private static void logicalOperatorTest() {
        Flow f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a && b'));

        System.assertEquals(false, f.run(true, false));

        f = new Flow()
            .inputAs('a', 'b')
            .doReturn(Flow.s('a || b'));

        System.assertEquals(true, f.run(true, false));
    }

    @isTest
    private static void conditionalOperatorTest() {
        Flow f = new Flow()
            .inputAs('a', 'b', 'c')
            .doReturn(Flow.s('a ? b : c'));

        System.assertEquals(2, f.run(true, 2, 1));
    }

    @isTest
    private static void arrayExpressionTest() {
        Flow f = new Flow()
            .doReturn(Flow.s('["abc"]'));

        System.assertEquals(new List<String>{ 'abc' }, f.run());
    }

    @isTest
    private static void mapExpressionTest() {
        Flow f = new Flow()
            .doReturn(Flow.s('{ "name": "test" }'));

        System.assertEquals(new Map<String, String>{ 'name' => 'test' }, f.run());
    }

    @isTest
    private static void functionTest() {
        Flow f = new Flow()
            .inputAs('a', 'b').returnInteger()
            .doReturn(Flow.s('add(a, b)'));

        System.assertEquals(3, f.run(1, 2));
    }

    @isTest
    private static void addFuncsTest() {
        Flow.addFuncs(new Map<String, Func>{
            'plus' => R.add
        });

        Flow f = new Flow()
            .inputAs('a', 'b').returnInteger()
            .doReturn(Flow.s('plus(a, b)'));

        System.assertEquals(3, f.run(1, 2));
    }

    @isTest
    private static void removeAllFuncsTest() {
        Flow.removeAllFuncs();

        try {
            Flow f = new Flow()
                .inputAs('a', 'b').returnInteger()
                .doReturn(Flow.s('add(a, b)'));

            f.run(1, 2);

            System.assert(false);
        }
        catch(Exception e) {
            System.assert(true);
        }
    }

    @isTest
    private static void complexSwitchTest() {
        Flow f = new Flow()
            .inputAs('n').returnInteger()
            .doSwitch('n', new List<Object>{
                Flow.s('n == 1'), Flow.block().doReturn(1),
                Flow.s('n != 1'), Flow.block().doReturn(2)
            });

        System.assertEquals(1, f.run(1));
        System.assertEquals(2, f.run(2));
    }
}
