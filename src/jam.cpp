#include <iostream>
#include <string.h>

#include <gsl/gsl>

#include <pjlib.h>
#include <pjlib-util.h>
#include <pjmedia.h>
#include <pjmedia-codec.h>
#include <pjsip.h>
#include <pjsip_simple.h>
#include <pjsip_ua.h>
#include <pjsua-lib/pjsua.h>

#include "jam.h"

void do_somthing()
{
  pj_pool_t* pool;
  pjsip_name_addr* name_addr;
  pjsip_sip_uri* sip_uri;

  // Init PJLIB
  pj_status_t status;
  // Init PJLIB
  status = pj_init();

  pj_caching_pool cp;

  // Init caching pool factory.
  pj_caching_pool_init(&cp, &pj_pool_factory_default_policy, 0);

  // Create pool to allocate memory
  pool = pj_pool_create(&cp.factory, "mypool", 4000, 4000, NULL);
  // Create and initialize a SIP URI instance
  sip_uri       = pjsip_sip_uri_create(pool, PJ_FALSE);
  sip_uri->user = pj_str("alice");
  sip_uri->host = pj_str("sip.example.com");
  // Create a name address to put the SIP URI
  name_addr      = pjsip_name_addr_create(pool);
  name_addr->uri = (pjsip_uri*)sip_uri;
  // Done
}

void test(gsl::owner<int*> ptr) { delete ptr; }

// Just some test code, nothing more.
Jam::Jam(unsigned size) : _ptr(nullptr), _size(size)
{
  Expects(size > 0);
  _ptr = new float(_size);
  do_somthing();
}

Jam::Jam(const Jam& other)
{
  _size = other._size;
  _ptr  = new float(_size);
  memcpy(_ptr, other._ptr, _size * sizeof(float));
}

Jam::Jam(Jam&& other)
{
  _ptr        = other._ptr;
  _size       = other._size;
  other._ptr  = nullptr;
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
  _ptr        = other._ptr;
  _size       = other._size;
  other._ptr  = nullptr;
  other._size = 0;
  return *this;
}

Jam::~Jam() noexcept
{
  if (_ptr != nullptr) {
    delete _ptr;
    _ptr  = nullptr;
    _size = 0;
  }
}
