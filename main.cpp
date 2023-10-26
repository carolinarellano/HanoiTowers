#include <iostream>
#include <stack>

// Function to move a disk from one tower to another
void moveDisk(std::stack<int> &source, std::stack<int> &destination)
{
    int top_disk = source.top();
    source.pop();
    destination.push(top_disk);
    std::cout << "Move disk " << top_disk << " from source to destination." << std::endl;
}

// Recursive function to solve Tower of Hanoi
void towerOfHanoi(int n, std::stack<int> &source, std::stack<int> &auxiliary, std::stack<int> &destination)
{
    if (n == 1)
    {
        moveDisk(source, destination);
    }
    else
    {
        towerOfHanoi(n - 1, source, destination, auxiliary);
        moveDisk(source, destination);
        towerOfHanoi(n - 1, auxiliary, source, destination);
    }
}

int main()
{
    int num_disks;
    std::cout << "Enter the number of disks: ";
    std::cin >> num_disks;

    std::stack<int> source, auxiliary, destination;

    // Initialize the source tower with disks
    for (int i = num_disks; i >= 1; i--)
    {
        source.push(i);
    }

    towerOfHanoi(num_disks, source, auxiliary, destination);

    return 0;
}
