#include "NotExpression.h"

NotExpression::NotExpression(Expression *e1): first(e1) {}

int NotExpression::eval() const {
    return first->eval() + second->eval();
}

void NotExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}
