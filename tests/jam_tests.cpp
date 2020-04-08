#include <memory>

#include "jam.h"

void test_constructor() {
  auto jam = std::unique_ptr<Jam>(new Jam(10000));
}

int main ()
{
  test_constructor();
}
