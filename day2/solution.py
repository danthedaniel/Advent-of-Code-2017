#!/usr/bin/env python3

from copy import copy


def is_int(number):
    """Return if a number can be represented as an integer."""
    return int(number) == number


def read_tsv(path):
    """Read in a TSV file and return it as a list of lists."""
    return [
        [int(x) for x in line.split('\t')]
        for line in open(path, 'r').readlines()
    ]


def checksum(path):
    """Calculate the checksum of a TSV.

    The checksum of the TSV is calculated as the sum of the differences between
    the maximum and minimum values of each row.

    Arguments
    ---------
    path : str
        Path to a TSV file.

    Returns
    -------
    The checksum of the file.
    """
    lines = read_tsv(path)
    differences = [max(line) - min(line) for line in lines]
    return sum(differences)


def checksum2(path):
    """Calculate the checksum of a TSV.

    The checksum of a TSV is calculated as the sum of the division between the
    only two numbers in each row that evenly divide each other.

    Arguments
    ---------
    path : str
        Path to a TSV file.

    Returns
    -------
    The checksum of the file.
    """
    lines = read_tsv(path)

    def _even_division(line):
        for i, a in enumerate(line):
            # Copy the line and remove the current element (left)
            line_copy = copy(line)
            line_copy.pop(i)

            for b in line_copy:
                if is_int(a / b):
                    return int(a / b)
                if is_int(b / a):
                    return int(b / a)

        raise ValueError('No even divisions found!')

    divisions = [_even_division(line) for line in lines]
    return sum(divisions)


print(checksum('input'))
print(checksum2('input'))
