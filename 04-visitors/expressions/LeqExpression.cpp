#include "LeqExpression.h"

LeqExpression::LeqExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int LeqExpression::eval() const {
    return first->eval() + second->eval();
}

void LeqExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}
