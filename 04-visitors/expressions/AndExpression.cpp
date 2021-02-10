#include "AndExpression.h"

AndExpression::AndExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int AndExpression::eval() const {
    return first->eval() + second->eval();
}

void AndExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}
