import ballerina/io;

function readInput(string filename) returns string[] {
    string[]|io:Error fileReadLines = io:fileReadLines("./" + filename);

    if (fileReadLines is string[]) {
        return fileReadLines;
    } else {
        io:println("Error reading file: ", fileReadLines.message());
        return [];
    }
}

function frmStrErrChk(int|error intToChk) returns int? {
    if (intToChk is int) {
        return intToChk;
    } else {
        return ();
    }
}

type LeftRight record {
    int left;
    int right;
};

public function main() {

    var lines = readInput("input.txt");
    int[] unsortedLeft = [];
    int[] unsortedRight = [];
    LeftRight[] lr = [];
    lines.forEach(function(string line) {
        unsortedLeft.push(<int>frmStrErrChk(int:fromString(line.substring(0, <int>line.indexOf(" ")).trim())));
        unsortedRight.push(<int>frmStrErrChk(int:fromString(line.substring(<int>line.lastIndexOf(" ")).trim())));
    });

    var sortedLeft = unsortedLeft.sort();
    var sortedRight = unsortedRight.sort();

    int i = 0;
    while i < sortedLeft.length() {
        lr.push({
            left: sortedLeft[i],
            right: sortedRight[i]
        });
        i += 1;     
    }

    int sum = 0;
    foreach var v in lr {
        sum += int:abs(v.left - v.right);
    }

    io:println(sum);
}
