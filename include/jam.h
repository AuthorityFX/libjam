#ifndef JAM_H_
#define JAM_H_

#define GSL_THROW_ON_CONTRACT_VIOLATION 1
#include <gsl/gsl>

class Jam {
public:
  Jam(unsigned size);
  Jam(const Jam& other);
  Jam(Jam&& other);
  Jam& operator=(const Jam& other);
  Jam& operator=(Jam&& other);
  ~Jam() noexcept;

private:
  float* _ptr;
  unsigned _size;
};

#endif  // JAM_H_
