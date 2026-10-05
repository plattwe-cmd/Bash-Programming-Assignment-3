#!/usr/bin/awk -f
BEGIN{
    FS=","
    dir = ARGV[1]
    sub("/[^/]+$", "", dir)

    system("> " dir "/Presidents1700.txt")
    system("> " dir "/Presidents1800.txt")
    system("> " dir "/Presidents1900.txt")
    system("> " dir "/Presidents2000.txt")
}
{
    tookDate=substr($4, length($4) -3);
    outdate=substr($5, length($5) -3);
    if(tookDate > 1700 && tookDate < 1800)
    {
        printf "%s\n", $0 > dir "/Presidents1700.txt"; # print to the Presidents1700
    }
    else if(tookDate >= 1800 && tookDate < 1900)
    {
        printf "%s\n", $0 > dir "/Presidents1800.txt"; # print to the Presidents1800
    }
    else if(tookDate >= 1900 && tookDate < 2000)
    {
        printf "%s\n", $0 > dir "/Presidents1900.txt"; # print to the Presidents1900
    }
    else
    {
        printf "%s\n", $0 > dir "/Presidents2000.txt"; # print to the Presidents2000
    }
}