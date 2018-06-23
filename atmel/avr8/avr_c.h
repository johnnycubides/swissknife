/**
 * @file avr_c.h
 * @brief quick access
 * @author: Johnny Cubides
 * contact: jgcubidesc@gmail.com
 * @date: Apr 18, 2018
 * */

#ifndef AVR_C_H
#define AVR_C_H

#define set(n) _BV(n)
#define clear(n) ~_BV(n)
#define GLUE(a, b)	a##b
#define SET_(what, p, m) GLUE(what, p) |= (1 << (m))
#define SET(what, x) SET_(what, x)
#define BS(REGISTER,PIN)	REGISTER |= (1 <<(PIN))

/// Defined the state 1 (bitSet) for a bit in register
#define PIN_HIGH(PIN_NUMBER) (1<<(PIN_NUMBER))
/// Defined the state 0 (bitClear) for a bit in register
#define PIN_LOW(PIN_NUMBER) ~(1<<(PIN_NUMBER))
/// Defined mode for pin with input
#define PIN_INPUT PIN_LOW
/// Defined mode for pin with output
#define PIN_OUTPUT PIN_HIGH
/// Defined Bitwise AND assignment operator
#define BITWISE_AND_ASSIGNMENT &=
/// Defined Bitwise inclusive OR and assignment operator
#define BITWISE_INCLUSIVE_OR_ASSIGNMENT |=
/// Defined operator for put 0 in bit for register
#define OP_PIN_INPUT BITWISE_AND_ASSIGNMENT
/// Defined operator for put 1 in bit for register
#define OP_PIN_OUTPUT BITWISE_INCLUSIVE_OR_ASSIGNMENT
/// Defined operator for write low at bit in register
#define WRITE_PIN_LOW BITWISE_AND_ASSIGNMENT
/// Defined operator for write high at bit in register
#define WRITE_PIN_HIGH BITWISE_INCLUSIVE_OR_ASSIGNMENT
/// Function for select mode to pin in register specific: WORD_REGISTER[A, B, C,...]; PIN_NUMBER[0,1,..]; PIN_MODE[PIN_INPUT, PIN_OUTPUT].
#define GPIO_MODE(WORD_REGISTER, PIN_NUMBER, PIN_MODE) DDR##WORD_REGISTER OP_##PIN_MODE PIN_MODE(PIN_NUMBER)
/// Function for write [1,0] at bit in register: WORD_REGISTER[A,B,C,...], PIN_NUMBER[0,1,...], PIN_VALUE[PIN_LOW, PIN_HIGH].
#define GPIO_WRITE(WORD_REGISTER, PIN_NUMBER, PIN_VALUE) PORT##WORD_REGISTER WRITE_##PIN_VALUE PIN_VALUE(PIN_NUMBER)

#endif /* end of include guard: AVR_C_H */
