#include "If.h"

If::If(Expression* expr, CodeBlock* true_expr, CodeBlock* false_expr)
: expression_(expr), true_expr_(true_expr), false_expr_(false_expr) {}


void If::Accept(Visitor* visitor) {
    visitor->Visit(this);
}