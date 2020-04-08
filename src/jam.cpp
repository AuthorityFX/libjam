#include <string.h>

#include "jam.h"

// Just some test code, nothing more.
Jam::Jam(unsigned size)
  : _ptr(nullptr)
  , _size(size)
{
  _ptr = new float(_size);
}

Jam::Jam(const Jam& other)
{
  _size = other._size;
  _ptr = new float(_size);
  memcpy(_ptr, other._ptr, _size * sizeof(float));
}

Jam::Jam(Jam&& other)
{
  _ptr = other._ptr;
  _size = other._size;
  other._ptr = nullptr;
  other._size = 0;
}

Jam& Jam::operator=(const Jam& other)
{
  if (&other != this) {
    if (other._size != _size) {
      _size = other._size;
      if (_ptr != nullptr) {
        delete _ptr;
        _ptr = new float(_size);
      }
      memcpy(_ptr, other._ptr, _size * sizeof(float));
    }
  }
  return *this;
}

Jam& Jam::operator=(Jam&& other)
{
  _ptr = other._ptr;
  _size = other._size;
  other._ptr = nullptr;
  other._size = 0;
  return *this;
}

Jam::~Jam()
{
  if (_ptr != nullptr) {
    delete _ptr;
    _ptr = nullptr;
    _size = 0;
  }
}
