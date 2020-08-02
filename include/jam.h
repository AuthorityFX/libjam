// =============================================================================
// libjam - C++ library for jamming over SIP protocol
//
// Copyright (C) 2020, Ryan P. Wilson
//   Authority FX, Inc.
//   www.authorityfx.com
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
// =============================================================================

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
