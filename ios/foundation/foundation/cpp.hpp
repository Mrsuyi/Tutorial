//
//  cpp.hpp
//  foundation
//
//  Created by Yi Su on 2/27/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef cpp_hpp
#define cpp_hpp

#include <stdio.h>

class Shit {
public:
  Shit() {
    printf("You created a shit.\n");
  }
  Shit(const Shit& s) : value(s.value) {
    printf("You created a shit by const&.\n");
  }
  Shit(Shit&& s) : value(s.value) {
    printf("You created a shit by &&.\n");
  }
  
  Shit& operator==(const Shit& s) {
    printf("You assigned a shit by const&.\n");
    value = s.value;
    return *this;
  }
  Shit& operator==(Shit&& s) {
    value = s.value;
    printf("You assigned a shit by &&.\n");
    return *this;
  }
  
  int value = 0;
};

#endif /* cpp_hpp */
