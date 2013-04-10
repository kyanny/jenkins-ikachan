#!/usr/bin/perl

while(<>){
  /<result>(.+?)</;
  printf "\x02\x0301,%02d%s\x0f",{A=>8,S=>3,F=>4}->{substr $1,0,1},$1;
}
