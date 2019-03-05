#!/bin/bash
#By Kristjan Krusic aka. krusic22
###Don't forget to adjust the variables to your own needs!
###We only support Java 8!
###Note: This script is optimised for Speed and will not lower Ram usage!
#Less time you spend in GC the better the performance! But higher the Ram usage.
#Note: 1G = 1024M
STARTRAM=512M           #USE VALUES IN M! Setting this the same value as MAXRAM can help sometimes...
MAXRAM=512M            #USE VALUES IN M!
JARNAME=spigot.jar      #Spigoterino.Jar
IS64=true               #Disable this if you don't have 64 bit Java installed
EXP=false               #Enable experimental stuff... It can cause problems just so you know
LP=false                #Enable only if you have Large/Huge Pages enabled.
#Normal Parameters
PARMS="
-server
-XX:+AlwaysPreTouch
-XX:+DisableExplicitGC
-XX:+UseG1GC
-XX:+UnlockExperimentalVMOptions
-XX:+AggressiveOpts
-XX:+UseGCOverheadLimit
-XX:+OptimizeStringConcat
-XX:+UseFastAccessorMethods"
#Set ParallelGCThreads same as Logical CPU cores and ConcGCThreads to one fourth of that (but don't go under 1).
THREADS="
-XX:ParallelGCThreads=8
-XX:ConcGCThreads=2"
#G1 optimizations...
GONE="
-XX:MaxGCPauseMillis=75
-XX:TargetSurvivorRatio=90
-XX:G1NewSizePercent=50
-XX:G1MaxNewSizePercent=80
-XX:InitiatingHeapOccupancyPercent=10
-XX:G1MixedGCLiveThresholdPercent=50
-XX:G1HeapWastePercent=8"
#Experimental options... Use at your own risk
if ("$EXP" = true ) then
echo "You have enabled Experimental Options! Use at your own risk!"
fi
#Large Pages config
if ("$LP" = true ) then
PARMS="-XX:+UseLargePagesInMetaspace -XX:LargePageSizeInBytes=2M -XX:+UseLargePages $PARMS"
fi
#64Bit Java Toggle
if ("$IS64" = true ) then
PARMS="-d64 $PARMS"
fi

### Auto Jar Updater. It works but it's not the best.
#wget InsertURLToJarHere -O $JARNAME
###

### You can stop the script by pressing CTRL+C multiple times.
while true
do
java -Xms$STARTRAM -Xmx$MAXRAM $PARMS $THREADS $GONE -jar $JARNAME
echo "Server will restart in:"
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
echo "Starting!"
done