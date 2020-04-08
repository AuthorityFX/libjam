#ifndef JAM_H_
#define JAM_H_

class Jam {
public:
    Jam(unsigned size);
    Jam(const Jam& other);
    Jam(Jam&& other);
    Jam& operator=(const Jam& other);
    Jam& operator=(Jam&& other);
    ~Jam();
private:
  float* _ptr;
  unsigned _size;
};

#endif // JAM_H_
