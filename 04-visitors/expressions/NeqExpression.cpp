#include "NeqExpression.h"

NeqExpression::NeqExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int NeqExpression::eval() const {
    return first->eval() + second->eval();
}

void NeqExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}
