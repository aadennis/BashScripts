# Context: simple tidy of Man pages - I open these in e.g.
# Google docs, not in a terminal window
# Remove the newline at position 122 or higher, and related
# leading space. Still some wrinkles to resolve

BEGIN { prev = "" }
{
    if (length(prev) > 121) {
        gsub(/^ */, "", $0);  # remove leading spaces from the current line
        printf "%s %s", prev, $0;  # print the previous line, a space, and the current line
    } else if (prev != "") {
        print prev;
    }
    prev = $0;
}
END { if (prev != "") print prev; }


# archive -------------------------------
# {
#     if (length($0) > 121)
#         printf "%s", $0;
#     else
#         print $0;
# }

