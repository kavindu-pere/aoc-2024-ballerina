import ballerina/io;

function readInput(string filename) returns string[]|error {
    return io:fileReadLines("./" + filename);
}

public function main() returns error? {
    string[] lines = check readInput("input.txt");
    int[] leftValues = [];
    int[] rightValues = [];

    foreach var line in lines {
        string[] parts = re `${"\\s"}`.split(line);
        if parts.length() >= 2 {
            int left = check int:fromString(parts[0].trim());
            int right = check int:fromString(parts[parts.length() - 1].trim());
            leftValues.push(left);
            rightValues.push(right);
        }
    }

    int[] sortedLeftValues = leftValues.sort();
    int[] sortedRightValues = rightValues.sort();

    int sum = 0;
    foreach int i in 0..<(sortedLeftValues.length()) {
        sum += int:abs(sortedLeftValues[i] - sortedRightValues[i]);
    }

    io:println(sum);
}