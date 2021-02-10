#pragma once
#include "Expression.h"

class NotExpression: public Expression {
 public:
    NotExpression(Expression* e1);
    int eval() const override;
    void Accept(Visitor* visitor) override;
    Expression* first;
};