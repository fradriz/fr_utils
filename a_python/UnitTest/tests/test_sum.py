import unittest
from fractions import Fraction

from a_python.UnitTest.my_sum import my_sum


class TestSum(unittest.TestCase):
    def test_list_int(self):
        """
        Test that it can sum a list of integers
        """
        data = [1, 2, 3]
        result = my_sum(data)
        self.assertEqual(result, 6)

        # Why just don't do this: 'assert result == 6, "Should be 6"' ???

    def test_list_fraction(self):
        """
        Test that it can sum a list of fractions
        """
        data = [Fraction(1, 4), Fraction(1, 4), Fraction(2, 5)]
        result = sum(data)
        # self.assertEqual(result, 1)
        self.assertEqual(result, Fraction(9, 10))


if __name__ == '__main__':
    unittest.main()
