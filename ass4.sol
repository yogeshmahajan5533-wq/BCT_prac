// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentData {

    // Structure
    struct Student {
        uint256 rollNo;
        string name;
        uint256 age;
        string course;
    }

    // Array of students
    Student[] public students;

    // Add student
    function addStudent(
        uint256 _rollNo,
        string memory _name,
        uint256 _age,
        string memory _course
    ) public {
        students.push(
            Student(
                _rollNo,
                _name,
                _age,
                _course
            )
        );
    }

    // Get number of students
    function getStudentCount() public view returns (uint256) {
        return students.length;
    }

    // Get student details
    function getStudent(uint256 _index)
        public
        view
        returns (
            uint256 rollNo,
            string memory name,
            uint256 age,
            string memory course
        )
    {
        Student memory s = students[_index];

        return (
            s.rollNo,
            s.name,
            s.age,
            s.course
        );
    }

    // Fallback function
    fallback() external payable {
        // Executes when no matching function is found
    }

    // Receive Ether
    receive() external payable {
        // Executes when Ether is sent without data
    }
}