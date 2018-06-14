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
 * */
public class FlowPackage extends Func.DefaultPackage {
    public override void init() {
        this.export('eval', new EvalFunc());
        this.export('addFuncs', new AddFuncsFunc());
        this.export('addFunc', new AddFuncFunc());
    }

    private class EvalFunc extends Func {
        public EvalFunc() {
            super(-1);
        }

        public override Object exec(Object arg1) {
            String script = (String)R.toString.run(arg1);

            return Flow.eval(script);
        }

        public override Object exec(Object arg1, Object arg2) {
            String script = (String)R.toString.run(arg1);
            Map<String, Object> context = (Map<String, Object>)R.toMap.run(arg2);

            return Flow.eval(script, context);
        }
    }

    private class AddFuncsFunc extends Func {
        public AddFuncsFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Func> funcs = (Map<String, Func>)R.toFuncMap.run(arg);

            Flow.addFuncs(funcs);

            return null;
        }
    }

    private class AddFuncFunc extends Func {
        public AddFuncFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String name = (String)R.toString.run(arg1);
            Func f = (Func)R.toFunc.run(arg2);

            Flow.addFunc(name, f);

            return null;
        }
    }
}
