<h1 align="center">
<strong>AUT_AP_2024_Spring Homework 1</strong>
</h1>

<p align="center">
<strong> Deadline: 19th of Esfand - 23:59 o'clock</strong>
</p>

# **1<sup>st</sup> Part: Backup Script Development**

The first part of your assignment focuses on the creation of a shell script designed to efficiently perform backup operations and generate comprehensive logs. By completing this task, you'll gain hands-on experience in scripting for backup solutions, enhancing your skills in automation and system administration.

## **Objective**

Develop a bash shell script capable of:

- Executing backup operations for specified directories. The script will backup everything within the `Source Path`, put them all in a zip file, and put the zip file within the `Destination Path`.
- Generating detailed logs covering various aspects of the backup process, such as file specifics, timestamps, and system data.

## **Script Creation**

### **Getting Started**

- **Script File Location:** Find the `backup_script.sh` in the provided `bash` folder. This is where you'll write your script.
- **Make Executable:** Ensure `backup_script.sh` is executable. Use `chmod +x backup_script.sh` in the `bash` folder, if necessary.

### **Script Requirements**

- **Shebang Line:** Begin your script with `#!/bin/bash` to specify the use of Bash.
- **Input Validation:** Your script must accept three parameters:

  - **Source Path:** The directory to back up (required).
  - **Destination Path:** Where the backup will be stored (required).
  - **Compression Level:** Denote with `-c` or `--compression` and a value. (Optional, The default is 1)

  Display an error message and exit if the required inputs are not provided.

- **Backup Operation:** Utilize `zip` to back up the target directory. Format the backup file as `YYYY-MM-DD_directoryname.zip` and save it to the chosen destination path, where `YYYY-MM-DD` is the date of the backup and `directoryname` is the name of the directory being backed up.
- **Error Handling:** Terminate the script with a non-zero status upon encountering errors.

## **Log Generation**

- Produce a `backup_log.txt` in the destination path.
- Ensure the log is clear and structured, following this example:

---

**Backup Log Report**

- **Date:** `2024-02-29`
- **Time:** `14:00:00 UTC`

**Machine Information:**

- **Operating System:** `Linux server 5.4.0-42-generic #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux`

**Backup Details:**

- **Source Path:** `/home/user/data`
- **Destination Path:** `/mnt/backup/2024-02-29_data_backup.zip`
- **Compression Level:** `9`
- **Files Backed Up:** `1,250`
- **Directories Backed Up:** `75`

**Backup Summary:**

- **Start Time:** `14:00:00 UTC`
- **End Time:** `14:05:30 UTC`
- **Total Duration:** `5 minutes 30 seconds`

---

## **Testing and Execution**

Validate your script using the `need_backup` folder supplied for this assignment.

### **Example Command**

```bash
./backup_script.sh /home/user/documents /home/user/backup -c 9
```

### **Expected Outcome**

```text
Backup of /home/user/documents completed successfully.
Saved to /home/user/backup/2024-02-29_documents.zip
```

# **2<sup>nd</sup> Part: `algebra` Namespace**

This part is designed to immerse you in the world of linear algebra through programming. You will create a fully functional algebra namespace in C++ that encompasses a variety of matrix operations. From initializing matrices to performing complex operations like multiplication and finding inverses, this assignment will hone your programming skills and teach you some of the features of `C++20`.

## Objective

Create a namespace with the implementation of all the below functions. be very carefull with all the pitfalls we gave you for each function, you have to check every condition and throw an error anywhere needed.

## `create_matrix`

### Required Types

First, make sure the following types are defined within your `algebra` namespace:

```cpp
// Matrix data structure
template<typename T>
using MATRIX = std::vector<std::vector<T>>;

// Matrix initialization types
enum class MatrixType { Zeros, Ones, Identity, Random };
```

### Function Prototype

```cpp
// Function template for matrix initialization
template<typename T>
MATRIX<T> create_matrix(std::size_t rows, std::size_t columns, std::optional<MatrixType> type = MatrixType::Zeros,
                        std::optional<T> lowerBound = std::nullopt, std::optional<T> upperBound = std::nullopt);
```

### Description

This function initializes a matrix of dimensions `rows x columns` with values depending on the specified `MatrixType`. The optional parameters `lowerBound` and `upperBound` are used for random initialization.

- **Zero**: Initializes all elements to 0.
- **Ones**: Initializes all elements to 1.
- **Identity**: Creates an identity matrix (1s on the diagonal, 0s elsewhere). **Only works for square matrices**.
- **Random**: Fills the matrix with random values within the range `[lowerBound, upperBound]`.

### Pitfalls

- **Dimension Mismatch**: For `MatrixType::Identity`, ensure `rows == columns`. An identity matrix must be square.
- **Random Range**: When `MatrixType::Random` is chosen, both `lowerBound` and `upperBound` must be specified. Ensure `lowerBound < upperBound`. You are also **only** allowed to use `random` library for generating your random numbers.

### Example Usage

```cpp
// Create a 5x5 zero matrix of integers
algebra::MATRIX<int> zerosMatrix = algebra::create_matrix<int>(5, 5);

// Create a 2x2 ones matrix of integers
algebra::MATRIX<int> onesMatrix = algebra::create_matrix<int>(2, 2, algebra::MatrixType::Ones);

// Create a 3x3 identity matrix of doubles
algebra::MATRIX<int> identityMatrix = algebra::create_matrix<int>(3, 3, algebra::MatrixType::Identity);

// Create a 4x4 matrix of random floats within [0.0, 1.0]
algebra::MATRIX<double> randomMatrix = algebra::create_matrix<double>(4, 4, algebra::MatrixType::Random, 0.0, 10.0);
```

## `display`

### Function Prototype:

```cpp
template<typename T>
void display(const MATRIX<T>& matrix);
```

### Description:

This function is designed to output the contents of a matrix in a formatted manner. It iterates through the matrix and prints each element, ensuring that the display is both aesthetically pleasing and informative. The function strictly uses the `<format>` library for formatting output, catering to requirements such as fixed width and precision for each element, thus maintaining uniformity and readability.

### Pitfalls:

- **Formatting Consistency**: Ensure that all numbers are displayed with a maximum width of 7 characters. This requires handling both large numbers and those with many decimal places carefully. Improper handling may lead to misaligned rows or columns, which we don not want.
- **Library Restrictions**: Students are restricted to using only the `<format>` library for formatting.

### Example Usage:

Given a matrix `mat`:

```cpp
algebra::MATRIX<int> mat = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
algebra::display(mat);
```

The expected output should be neatly formatted as follows:

```text
|   1   |   2   |   3   |
|   4   |   5   |   6   |
|   7   |   8   |   9   |
```

## `sum_sub`

### Function Prototype:

```cpp
template<typename T>
MATRIX<T> sum_sub(const MATRIX<T>& matrixA, const MATRIX<T>& matrixB, std::optional<std::string> operation = "sum");
```

### Description:

This function performs either the summation or subtraction of two matrices, depending on the specified operation. By default, the function adds the corresponding elements of the input matrices (`matrixA` and `matrixB`). If the `operation` parameter is explicitly set to `"sub"`, it subtracts `matrixB` from `matrixA`.

### Pitfalls:

- **Dimension Mismatch**: Ensure that both matrices have the same dimensions. Throw an error otherwise.
- **Operation Parameter**: The operation parameter accepts only two values: `"sum"` and `"sub"`. Any other value will default to summation.

### Example Usage:

Summation of two matrices:

```cpp
algebra::MATRIX<int> matrixA = {{1, 2, 3}, {4, 5, 6}};
algebra::MATRIX<int> matrixB = {{6, 5, 4}, {3, 2, 1}};
algebra::MATRIX<int> resultSum = algebra::sum_sub(matrixA, matrixB); // Default operation is "sum"

/* Expected Matrix
|  7  |  7  |  7  |
|  7  |  7  |  7  |
*/
```

Subtraction of two matrices:

```cpp
algebra::MATRIX<int> matrixA = {{10, 20, 30}, {40, 50, 60}};
algebra::MATRIX<int> matrixB = {{1, 2, 3}, {4, 5, 6}};
algebra::MATRIX<int> resultSub = algebra::sum_sub(matrixA, matrixB, "sub");

/* Expected Matrix
|  9  | 18  | 27  |
| 36  | 45  | 54  |
*/
```

## `multiply`

### Function Prototype:

For scalar multiplication:

```cpp
template<typename T>
MATRIX<T> multiply(const MATRIX<T>& matrix, const T scalar);
```

For matrix multiplication:

```cpp
template<typename T>
MATRIX<T> multiply(const MATRIX<T>& matrixA, const MATRIX<T>& matrixB);
```

### Description:

1. **Scalar Multiplication**: Multiplies each element of a given matrix by a scalar value. This operation enhances or reduces the magnitude of matrix elements uniformly, depending on the scalar value.

2. **Matrix Multiplication**: Computes the product of two matrices by performing the dot product of rows and columns. The operation is defined for two matrices `A` and `B` where the number of columns in `A` matches the number of rows in `B`. The resulting matrix will have dimensions that match the number of rows in `A` and the number of columns in `B`.

### Pitfalls:

- **Dimension Mismatch**: For matrix multiplication, it's crucial that the number of columns in `matrixA` matches the number of rows in `matrixB`. Failure to meet this condition must throw an error.

### Example Usage:

Scalar Multiplication:

```cpp
algebra::MATRIX<int> mat = {{1, 2}, {3, 4}};
int scalar = 3;
algebra::MATRIX<int> scaledMatrix = algebra::multiply(mat, scalar);

/* Expected Matrix
|  3  |  6  |
|  9  | 12  |
*/
```

Matrix Multiplication:

```cpp
algebra::MATRIX<int> matrixA = {{1, 2, 3}, {4, 5, 6}};
algebra::MATRIX<int> matrixB = {{7, 8}, {9, 10}, {11, 12}};
algebra::MATRIX<int> productMatrix = algebra::multiply(matrixA, matrixB);

/* Expected Matrix
|  58  |  64  |
| 139  | 154  |
*/
```

## `hadamard_product`

### Function Prototype:

```cpp
template<typename T>
MATRIX<T> hadamard_product(const MATRIX<T>& matrixA, const MATRIX<T>& matrixB);
```

### Description:

This function computes the Hadamard Product (also known as the element-wise product) of two matrices of the same dimensions. The Hadamard Product is obtained by multiplying corresponding elements in the two matrices. The result is a new matrix where each element `C[i][j]` is the product of elements `A[i][j]` and `B[i][j]` from the input matrices.

### Pitfalls:

- **Dimension Mismatch**: The matrices `matrixA` and `matrixB` must be of the same size. Attempting to compute the Hadamard Product of matrices with differing dimensions must result in an error.

### Example Usage:

Given two matrices `matA` and `matB`:

```cpp
algebra::MATRIX<int> matA = {{1, 2, 3}, {4, 5, 6}};
algebra::MATRIX<int> matB = {{7, 8, 9}, {10, 11, 12}};
algebra::MATRIX<int> result = algebra::hadamard_product(matA, matB);

/* Expected Matrix
|  7  | 16  | 27  |
| 40  | 55  | 72  |
*/
```

## `transpose`

### Function Prototype:

```cpp
template<typename T>
MATRIX<T> transpose(const MATRIX<T>& matrix);
```

### Description:

This function returns the transpose of a given matrix. The transpose of a matrix is obtained by flipping the matrix over its diagonal, thus turning its rows into columns and vice versa. This operation does not alter the original matrix but produces a new matrix where the element at position `[i][j]` in the original matrix is moved to position `[j][i]` in the transposed matrix.

### Pitfalls:

- **Empty Matrix**: If the input matrix is empty, the function should gracefully handle this case and return an empty matrix as the transpose.
- **Non-Square Matrices**: The function should correctly handle non-square matrices (where the number of rows does not equal the number of columns). The dimensions of the transposed matrix will be different from the original matrix in such cases.
- **Memory Usage**: Transposing a large matrix may require significant memory for the new matrix, especially if the original matrix is large. Consider the memory implications of your implementation.

### Example Usage:

Given a matrix `mat`:

```cpp
algebra::MATRIX<int> mat = {{1, 2, 3}, {4, 5, 6}};
algebra::MATRIX<int> result = transpose(mat);

/* Expected Matrix
|  1  |  4  |
|  2  |  5  |
|  3  |  6  |
*/
```

## `trace`

### Function Prototype:

```cpp
template<typename T>
T trace(const MATRIX<T>& matrix);
```

### Description:

This function calculates the trace of a given square matrix. The trace of a matrix is defined as the sum of the elements on the main diagonal (from the top left to the bottom right). It is a concept from linear algebra that **applies only to square matrices** and provides a quick, useful measure of a matrix's properties, including its eigenvalues' sum.

### Pitfalls:

- **Square Matrix Requirement**: The trace can only be calculated for square matrices. If the input matrix is not square your program must throw an error.

### Example Usage:

Given a square matrix `mat`:

```cpp
algebra::MATRIX<int> mat = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
int tr = algebra::trace(mat);

/* Expected Result
tr = 1 + 5 + 9 = 15
*/
```

## `determinant`

### Function Prototype:

```cpp
template<typename T>
double determinant(const MATRIX<T>& matrix);
```

### Description:

This function calculates the determinant of a given square matrix. The determinant is a scalar value that provides important information about the matrix, such as whether it is invertible (a non-zero determinant) or singular (a determinant of zero).

### Pitfalls:

- **Square Matrix Requirement**: This function can only be applied to **square matrices** (matrices with equal number of rows and columns). Attempting to calculate the determinant of a non-square matrix must throw an error.
- **Performance**: Calculating the determinant of large matrices can be computationally expensive, especially using recursive methods. Consider the implications of this for very large matrices.
- **Numerical Stability**: For matrices with elements of floating-point types, the calculation of the determinant can suffer from numerical instability, leading to inaccurate results due to the limitations of floating-point arithmetic.

### Example Usage:

Given a square matrix `mat`:

```cpp
algebra::MATRIX<double> mat = {{4, 3}, {6, 3}};
double det = algebra::determinant(mat);

/* Expected Result
det = (4*3) - (3*6) = 12 - 18 = -6.0
*/
```

## `inverse`

### Function Prototype:

```cpp
template<typename T>
MATRIX<double> inverse(const MATRIX<T>& matrix);
```

### Description:

This function calculates the inverse of a given square matrix, if it exists. The inverse of a matrix `A` is another matrix `A^-1` such that the product of `A` and `A^-1` yields the identity matrix. The calculation of the inverse is typically based on the method of Gaussian elimination or finding the adjugate and determinant of the matrix. It is important to note that not all matrices have an inverse; a matrix must be square and have a non-zero determinant to be invertible.

### Pitfalls:

- **Square Matrix Requirement**: Only square matrices (matrices with the same number of rows and columns) can have inverses. The function must check for this condition and handle non-square matrices with throwing error.
- **Determinant Check**: Before attempting to calculate the inverse, it's crucial to check that the determinant of the matrix is not zero. A zero determinant means the matrix is singular and does not have an inverse. if this happens, error is what you need to throw.
- **Numerical Stability**: For matrices with floating-point elements, the process of calculating the inverse may be subject to numerical instability, leading to inaccuracies. It's important to implement the algorithm carefully to minimize errors.

### Example Usage:

Given a square matrix `mat`:

```cpp
algebra::MATRIX<double> mat = {{4, 7}, {2, 6}};
algebra::MATRIX<double> invMat = algebra::inverse(mat);

/* Expected Matrix
|  3/5  | -7/10 |
| -1/5  |  2/5  |
*/
```

## **Final Step: How To Test Your Program**

If you want to debug your code, set the `if` statement to `true`. This will allow you to place your debugging code in the designated section. Once you're done with the debugging process, remember to set the `if` statement back to `false` to test your program using the provided `unit-test.cpp`.

Furthermore, whatever code you write should be implemented in the `algebra.cpp` and `algebra.h` files. Please refrain from making any changes to other files in the project.

```cpp
#include <iostream>
#include <gtest/gtest.h>
#include "algebra.h"

int main(int argc, char **argv)
{
    if (true) // Set to false to run unit-tests
    {
        // Debug section: Place your debugging code here
    }
    else
    {
        ::testing::InitGoogleTest(&argc, argv);
        std::cout << "RUNNING TESTS ..." << std::endl;
        int ret{RUN_ALL_TESTS()};
        if (!ret)
            std::cout << "<<<SUCCESS>>>" << std::endl;
        else
            std::cout << "FAILED" << std::endl;
    }
    return 0;
}
```

<p align="center">
  <img src="./Resource/Say_Hello_To_Other_Errors.webp" alt="Say Hello To Other Errors" style="width: 40%;">
</p>

**Best Regards, [Hamidi](https://github.com/smhamidi)**
