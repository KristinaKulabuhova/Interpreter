#include "Program.h"

Program::Program(
    std::string name, 
    std::vector<VariableDeclBlock*> Var, 
    StatementBlock* StatBlock
): name_(name), Var_(Var), StatBlock_(StatBlock);

