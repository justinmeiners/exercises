# Created By: Justin Meiners (2017)
# for a numerical analysis course

import math
import copy

class Polynomial():
    def __init__(self, size):
        self.size = size
        self.coeff = [0.0] * size

    def __len__(self):
        '''returns degree + 1'''
        return self.size

    def degree(self):
        '''returns power of leading coeffecient'''
        return len(self) - 1

    def __getitem__(self, index):
        if index >= len(self):
            return 0
        return self.coeff[index]

    def __setitem__(self, index, value):
        self.coeff[index] = value

    def set_coeffecients(self, l):
        self.size = len(l)
        self.coeff = l

    def leading(self):
        return self[self.degree()]

    def constant(self):
        return self[0]

    def trim(self):
        '''trim array to first nonzero term'''
        for i in range(self.degree(), -1, -1):
            if not self[i] == 0:
                break
        self.coeff = self.coeff[0:i+1]
        self.size = i + 1

    def __call__(self, x):
        '''evaluate value at a particular point'''
        val = self.leading()
        for i in range(self.degree() - 1, -1, -1):
            val = x * val + self[i]
        return val

    def point_and_slope(self, x):
        '''evaluate value and derivative at a particular point'''
        val = self.leading()
        slope = val

        for i in range(len(self) - 2, 0, -1):
            val = x * val + self[i]
            slope = val + x * slope

        val = x * val + self[0]
        return (val, slope)

    def __add__(self, other):
        p = Polynomial(max(len(self), len(other)))
        for i in range(0, len(p)):
            p[i] = self[i] + other[i]
        return p

    def __sub__(self, other):
        p = Polynomial(max(len(self), len(other)))
        for i in range(0, len(p)):
            p[i] = self[i] - other[i]
        return p

    def __mul__(self, other):
        p = Polynomial(len(self) + len(other))
        for i in range(0, len(self)):
            for j in range(0, len(other)):
                p[i + j] += self[i] * other[j]
        p.trim()
        return p

    def __str__(self):
        text = ''
        for i in range(self.degree(), -1, -1):
            if i == 0:
                text += str(self[i])
            else:
                if not self[i] == 0:
                    text += str(self[i]) + 'x^' + str(i) + '+'
        return text

    def derivative(self, n=1):
        if n < 1:
            raise IndexError()
 
        def factorial(n):
            product = 1
            for i in range(2, n):
                product *= i
            return product

        f = float(factorial(n))

        p = Polynomial(len(self) - 1)
        for i in range(n, len(self)):
            p[i - n] = self[i] * float(i) * f
        return p

    def integral(self, constant=0.0):
        p = Polynomial()
        p[0] = constant
        for i in range(1, len(self)):
            p[i] = self[i - 1] / float(i)
        return p

    def find_roots(self, iterations, tolerance = 0.00001, initial=0.5):
        '''find the approximate roots of the polynomial'''
        n = len(self)
        factored = Polynomial(n)
        factored.coeff = copy.copy(self.coeff)
        factored.trim()

        roots = []
        it = 0        
        x_n = initial
        
        while len(factored) > 1 and it < iterations: 
            # newtons method iteration
            (val, slope) = factored.point_and_slope(x_n)
            x_new = x_n - val / slope
            # check that are values are close
            x_close = math.fabs(x_new - x_n) < tolerance 
            y_close = math.fabs(factored(x_new) - val) < tolerance
            x_n = x_new
            it += 1

            if x_close or y_close:
                # if it is close, we have a root
                roots.append(x_n)

                # factor the root out
                k = [0] * (len(factored) - 1)
                k[len(factored) - 2] = factored.leading()

                for i in range(len(factored) - 2, 0, -1):
                    k[i - 1] = factored[i] + x_n * k[i]

                factored.coeff = k
                factored.size -= 1
        return roots 


