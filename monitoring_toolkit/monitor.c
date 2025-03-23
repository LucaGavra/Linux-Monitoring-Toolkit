#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>
#include <unistd.h>

void getCPUUsage() {
    FILE *fp = popen("uptime | awk '{print $8, $9, $10}'", "r");
    char result[100];
    fgets(result, sizeof(result), fp);
    pclose(fp);
    printw("CPU Load: %s\n", result);
}

void getMemoryUsage() {
    FILE *fp = popen("free -h | grep Mem | awk '{print $3 \"/\" $2}'", "r");
    char result[100];
    fgets(result, sizeof(result), fp);
    pclose(fp);
    printw("Memory Usage: %s\n", result);
}

int main() {
    initscr();  
    while (1) {
        clear();
        getCPUUsage();
        getMemoryUsage();
        refresh();
        sleep(2);
    }
    endwin();
    return 0;
}
