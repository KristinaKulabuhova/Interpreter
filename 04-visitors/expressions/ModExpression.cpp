#include "ModExpression.h"

ModExpression::ModExpression(Expression *e1, Expression *e2): first(e1), second(e2) {}

int ModExpression::eval() const {
    return first->eval() + second->eval();
}

void ModExpression::Accept(Visitor* visitor) {
    visitor->Visit(this);
}
