# expression evaluation in xojo: the one that will be thrown away
 
The app intended for experimentation and then throwing away…

> In most projects, the first system built is barely usable… Hence plan to throw one away; you will, anyhow.
> Fred Brooks, The Mythical Man-Month (https://en.wikipedia.org/wiki/The_Mythical_Man-Month)

(Or … Publish and be damned.)

I'm working on some apps which need to be able to tokenise, parse and evaluate Excel-type formulas/expressions.

This was my first take on the problem. Hence there's plenty that will likely change, and plenty of TODOs scattered everywhere…

## tokenisation

Since tokenisation and parsing related matters are not really my forte, I’ve handled as much as possible by breaking things up into various "passes":

`var tokens as Tokens = Evaluation.tokenise( expression )`

The first tokenisation is just straightforwards looking at what's next in the string, and adding the appropriate Token class to a list. There's no attempt at semantic analysis or processing. (And the tokenisation doesn't use RegEx, which is just silly, but it just didn't occur to me.)

## parsing passes

### 1: parseUnaryMinusOperators

`tokens = Evaluation.parseUnaryMinusOperators( tokens )`

This passes over the list of tokens, identifying which minus/plus tokens are likely unary, and substituting them in the list of tokens.

### 2: checkBalancedBrackets

`Evaluation.checkBalancedBrackets( tokens )`

Does a simple pass counting open and close brackets (both `()` and `[]`), checking that they match

### 3: parseSymbolsFunctionsBrackets

`tokens = Evaluation.parseSymbolsFunctionsBrackets( tokens )`

Go through the tokens identifying (1) bracketed sub-expressions, (2) function parameters, (3) lists, replacing tokens (`TokenSymbol`, `TokenBracket`, `TokenComma` etc) with `TokenOperand` subclasses: `TokenOperandSubClause`, `TokenOperandFunctionCall`, `TokenVariableLookUp`, `TokenOperandList`, which all use `TokenOperandSubClause` to re-organise into a tree-like structure.

At this stage everthing is still infix.

### 4: parseInfixToRPN

`tokens = Evaluation.parseInfixToRPN( tokens )`

Now go over the tokens, coverting to RPN (postfix) via the shunting yard algorithm. `TokenOperandFunctionCall`, `TokenOperandList` and `TokenOperandSubClause` are all handled recursively.

(https://en.wikipedia.org/wiki/Shunting_yard_algorithm)

(I've made a mistake in the recursive descent of bracketed sub-expressions and function call arguments - it all works, so in that sense no problem, but looking over how I've handled the recursion in `parseInfixToRPN`, it's not quite how it should be.)

## execution / evaluation

The list of tokens is converted to equivalent list of `Instruction` subclasses: `InstructionOperands` and `InstructionOperators` from `TokenOperands`/`TokenOperators`. Recursive creation of `InstructionOperandSubClauses` from `TokenOperandSubClause`. (Likewise for `TokenOperandFunctionCall` and `TokenOperandList`.)

The `Token` class has a `asInstruction` which returns its equivalent `Instruction` (if applicable: as Tokens like brackets are parsed into sub-clause operands, there are no `InstructionBracket` equivalents to `TokenBracket`. Likewise, `TokenSymbol` are parsed out to either variable operands or function call operands, so there is no `InstructionSymbol`, only `InstructionOperandFunctionCall` and `InstructionOperandVariableLookUp`).

`var instructions as Instructions = tokens.asInstructions()`

The resulting list of `Instructions` is what can then be executed/evaluated. (And also cached, so if an expression/formula string remains unchanged, it does not need to be re-compiled if re-executed.)

`var result as Variant = Evaluation.evaluate( instructions )`

At this point, joy! We’re at the straightforward execution of a RPN sequence of `InstructionOperands` and `InstructionOperators`.

(https://en.wikipedia.org/wiki/Reverse_Polish_notation)

Operands are evaluated in order: strings and numbers go on the stack, sub-clauses are evaluated then result put on stack, function parameters each evaluated (as a sub-clause), results on stack, then the itself is function called, the result put on the stack, etc etc.

(`TokenOperandFunctionCall` / `InstructionOperandFunctionCall` hold data from earlier in the parsing process about how many parameters they were called with.)

Operators pop values off stack, evaluate, push result back onto stack in the usual fasion.

In a correct epxression, at the end, there will be only one value left on the stack: the end result.

At the moment the result comes back as Variant, and all evaluation is done with Xojo's inbuilt types. Which means there's lots of very ugly Variant handling scattered everywhere. I'll likely eventually change this to use my own `Value` class.

Also, I want the result to come back with lots of other extra information: mainly what all the nested `InstructionOperandSubClauses`, `InstructionOperandFunctionCall` and `InstructionOperandList` evaluated to, so the host app can display all of this in the (sort of AST) structure of the formula to the user, allowing them to understand what they've written (and helping them debug if neccesary).

I found a basic suite of test expressions which I've copied and pasted, plus a few extra of my own, and at the moment the results seem to come back correct. (At least the ones I’ve checked by pasting them in Google and seeing what their calculator returns.)

![ideas](https://github.com/user-attachments/assets/8991dcdf-d381-414e-862b-d2443021f0c6)

PDF: [ideas.pdf](https://github.com/user-attachments/files/19930565/ideas.pdf)
