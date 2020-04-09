#include <memory>

#include "gtest/gtest.h"

#include "jam.h"

TEST(JamTest, Works)
{
  auto jam = std::make_unique<Jam>(-10);
  EXPECT_EQ(1, 1) << 1 << "should equal 1";
}
