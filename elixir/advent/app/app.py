import sys

ins = []
xs = []
ys = []
zs = []

lines = [
"on x=10..12,y=10..12,z=10..12",
"on x=11..13,y=11..13,z=11..13" ]

# for line in lines:
for line in open('./input.txt').readlines():
    status, positions = line.split()
    x, y, z = positions.split(",")
    x1, x2 = map(int, x.split("=")[1].split(".."))
    y1, y2 = map(int, y.split("=")[1].split(".."))
    z1, z2 = map(int, z.split("=")[1].split(".."))
    ins.append((status == "on", (x1, x2), (y1, y2), (z1, z2)))
    xs.extend([x1, x2 + 1])
    ys.extend([y1, y2 + 1])
    zs.extend([z1, z2 + 1])

ins.reverse()
xs.sort()
ys.sort()
zs.sort()

count = 0

for x1, x2 in zip(xs, xs[1:]):
    print(f"x={x1}")
    ins_x = [(a, x, y, z) for a, x, y, z in ins if x[0] <= x1 <= x[1] and a]
    for y1, y2 in zip(ys, ys[1:]):
        ins_y = [(a, x, y, z) for a, x, y, z in ins_x if y[0] <= y1 <= y[1]]
        for z1, z2 in zip(zs, zs[1:]):
            ins_z = [a for a, x, y, z in ins_y if z[0] <= z1 <= z[1]]
            next_z = next(iter(ins_z), False)
            if next_z:
                add = (x2 - x1) * (y2 - y1) * (z2 - z1)
                count += add

print(count)
