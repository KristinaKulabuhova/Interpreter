#pragma once

#include "expressions/Expression.h"
#include "base_elements/BaseElement.h"

#include <string>

class If: public BaseElement {
 public:
    If(Expression* expr, CodeBlock* true_expr, CodeBlock* false_expr);
    void Accept(Visitor* visitor);

    Expression* expression_;
    CodeBlock* true_expr_;
    CodeBlock* false_expr_;
};