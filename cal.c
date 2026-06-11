#include "types.h"
#include "stat.h"
#include "user.h"

// Sakamoto's algorithm to find the day of the week (0 = Sunday, 1 = Monday, etc)
int dayofweek(int d, int m, int y) {
    static int t[] = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 };
    if (m < 3) y -= 1;
    return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
}

int is_leap_year(int year) {
    if (year % 400 == 0) return 1;
    if (year % 100 == 0) return 0;
    if (year % 4 == 0) return 1;
    return 0;
}

int main(int argc, char *argv[]) {
    if(argc < 3) {
        printf(1, "Usage: cal <month 1-12> <year e.g. 2026>\n");
        exit();
    }

    int month = atoi(argv[1]);
    int year = atoi(argv[2]);

    if(month < 1 || month > 12 || year < 1) {
        printf(1, "Invalid month or year!\n");
        exit();
    }

    int days_in_month[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    char *months[] = { "January", "February", "March", "April", "May", "June", 
                       "July", "August", "September", "October", "November", "December" };

    if (month == 2 && is_leap_year(year)) {
        days_in_month[1] = 29;
    }

    printf(1, "    %s %d\n", months[month-1], year);
    printf(1, " Su Mo Tu We Th Fr Sa\n");

    // Find starting day of the month
    int start_day = dayofweek(1, month, year);

    // Print initial spaces
    int i;
    for(i = 0; i < start_day; i++) {
        printf(1, "   ");
    }

    // Print all the days
    int day;
    for(day = 1; day <= days_in_month[month-1]; day++) {
        if(day < 10) printf(1, "  %d", day);
        else printf(1, " %d", day);

        if((day + start_day) % 7 == 0) {
            printf(1, "\n");
        }
    }
    printf(1, "\n\n");
    exit();
}
//very simple process aint it?
