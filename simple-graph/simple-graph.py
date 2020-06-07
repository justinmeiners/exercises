# Created By: Justin Meiners (2017)
import math

class Image:
    def __init__(self, width, height):
        self.width = width
        self.height = height
        self.data = []
        for row in range(0, self.height):
            for col in range(0, self.width):
                self.data.append((255, 255, 255))

    def at(self, col, row):
        if (row >= self.height or row < 0):
            return
        if (col >= self.width or col < 0):
            return 
        return self.data[col + row * self.width]

    def set(self, val, col, row):
        if (row >= self.height or row < 0):
            return
        if (col >= self.width or col < 0):
            return
        self.data[col + row * self.width] = val

    def to_ppm(self, filename):
        with open(filename, 'wb') as f:
            f.write(b'P6 %i %i %i ' % (self.width, self.height, 255))
            for row in range(0, self.height): 
                for col in range(0, self.width):
                    f.write(b'%c%c%c' % self.at(col, row))


# generates a numerical derivative function
def derive_forward(func, h):
    def result(x):
        return (func(x + h) - func(x)) / h
    return result

class Window:
    def __init__(self):
        self.offset = (-10.0, -10.0)
        self.size = (20.0, 20.0)

    def from_norm(self, coord):
        return tuple(x * self.size[i] + self.offset[i] for i, x in enumerate(coord))

    def to_norm(self, coord):
        return tuple((x - self.offset[i]) / self.size[i] for i, x in enumerate(coord))


# functions of y. x = f(y)

def f_y(func, color, image, win):
    func_prime = derive_forward(func, 0.00001)

    iy = 0.0    
    while iy < image.height:
        ny = iy / image.height
        _, y = win.from_norm((0.0, ny))
        x = func(y)
        nx, _ = win.to_norm((x, 0.0))

        ix = nx * image.width
        m = func_prime(y)

        dy = 1
        if abs(m) > 1:
            dy = 1 / abs(m)

        iy += dy if dy > 0.01 else 0.01
        image.set(color, int(ix), int(iy))


# functions of x. y = f(x)

def f_x(func, color, image, win):
    func_prime = derive_forward(func, 0.00001)

    ix = 0.0    
    while ix < image.width:
        nx = ix / image.width
        x, _ = win.from_norm((nx, 0.0))
        y = func(x)
        _, ny = win.to_norm((0.0, y))

        iy = ny * image.height
        m = func_prime(x)

        dx = 1
        if abs(m) > 1:
            dx = 1 / abs(m)

        ix += dx if dx > 0.01 else 0.01
        image.set(color, int(ix), int(iy))

win = Window()
image = Image(512, 512)

draw_grid = True
draw_axis = True

# vertical and horizontal axis
if draw_axis:
    f_y(lambda y: 0, (0, 0, 0), image, win)
    f_x(lambda x: 0, (0, 0, 0), image, win)

# background grid
if draw_grid:
    sx, sy = win.offset
    ex, ey = tuple(x + win.size[i] for i, x in enumerate(win.offset))
    grid_color = (200, 200, 200)

    while (sx < ex):
        f_y(lambda y: sx, grid_color, image, win)
        sx += 1 

    while (sy < ey):
        f_x(lambda x: sy, grid_color, image, win)
        sy += 1


# x^2
f_x(lambda x: x*x, (255, 0, 0), image, win)
# vertical and horizontal sins
f_x(math.sin, (0, 0, 255), image, win)
f_y(math.sin, (0, 0, 255), image, win)
#f_x(math.tan, (0, 100, 0), image, win)

# test polynomial
f_x(lambda x: -(x**5) + 4 * (x ** 3), (255, 0, 255), image, win)

image.to_ppm('test.ppm')

