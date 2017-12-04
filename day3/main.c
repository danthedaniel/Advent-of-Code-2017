#include <stdio.h>
#include <assert.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

struct Point {
    int32_t x;
    int32_t y;
};

// Get the manhattan distance from a spiral location to the origin.
uint32_t distance_for(int32_t location);

// Run tests on the provided inputs and corresponding outputs.
void tests();

int main(int argc, char** argv) {
    tests();

    int32_t input = 289326;
    printf("Part 1: %d\n", distance_for(input));

    return 0;
}


uint32_t distance_to_origin(struct Point *coord) {
    return abs(coord->x) + abs(coord->y);
}

/*
 * function spiral(n)
 *         k=ceil((sqrt(n)-1)/2)
 *         t=2*k+1
 *         m=t^2
 *         t=t-1
 *         if n>=m-t then return k-(m-n),-k        else m=m-t end
 *         if n>=m-t then return -k,-k+(m-n)       else m=m-t end
 *         if n>=m-t then return -k+(m-n),k else return k,k-(m-n-t) end
 * end
 */
uint32_t distance_for(int32_t n) {
    struct Point *coord = (struct Point*) malloc(sizeof(struct Point));

    int32_t k = (int32_t) ceil((sqrt((double) n) - 1) / 2);
    int32_t t = 2 * k + 1;
    int32_t m = t * t;
    t = t - 1;

    // TODO: Oh god please clean this up
    if (n >= m - t) {
        coord->x = k - (m - n);
        coord->y = -k;
    } else {
        m = m - t;

        if (n >= m - t) {
            coord->x = -k;
            coord->y = -k + (m - n);
        } else {
            m = m - t;

            if (n >= m - t) {
                coord->x = -k + (m - n);
                coord->y = k;
            } else {
                coord->x = k;
                coord->y = k - (m - n - t);
            }
        }
    }

    uint32_t distance = distance_to_origin(coord);
    free(coord);
    return distance;
}

void tests() {
    assert(distance_for(1) == 0);
    assert(distance_for(12) == 3);
    assert(distance_for(23) == 2);
    assert(distance_for(1024) == 31);
}
