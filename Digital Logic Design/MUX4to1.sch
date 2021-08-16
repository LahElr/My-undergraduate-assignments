<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="S(1:0)" />
        <signal name="S(1)" />
        <signal name="S(0)" />
        <signal name="XLXN_5" />
        <signal name="XLXN_6" />
        <signal name="I0" />
        <signal name="I1" />
        <signal name="I2" />
        <signal name="I3" />
        <signal name="XLXN_15" />
        <signal name="XLXN_16" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18" />
        <signal name="XLXN_24" />
        <signal name="XLXN_26" />
        <signal name="XLXN_27" />
        <signal name="XLXN_28" />
        <signal name="O" />
        <port polarity="Input" name="S(1:0)" />
        <port polarity="Input" name="I0" />
        <port polarity="Input" name="I1" />
        <port polarity="Input" name="I2" />
        <port polarity="Input" name="I3" />
        <port polarity="Output" name="O" />
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <blockdef name="or4">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="48" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="48" y1="-256" y2="-256" x1="0" />
            <line x2="192" y1="-160" y2="-160" x1="256" />
            <arc ex="112" ey="-208" sx="192" sy="-160" r="88" cx="116" cy="-120" />
            <line x2="48" y1="-208" y2="-208" x1="112" />
            <line x2="48" y1="-112" y2="-112" x1="112" />
            <line x2="48" y1="-256" y2="-208" x1="48" />
            <line x2="48" y1="-64" y2="-112" x1="48" />
            <arc ex="48" ey="-208" sx="48" sy="-112" r="56" cx="16" cy="-160" />
            <arc ex="192" ey="-160" sx="112" sy="-112" r="88" cx="116" cy="-200" />
        </blockdef>
        <block symbolname="inv" name="XLXI_1">
            <blockpin signalname="S(1)" name="I" />
            <blockpin signalname="XLXN_5" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_2">
            <blockpin signalname="S(0)" name="I" />
            <blockpin signalname="XLXN_6" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_3">
            <blockpin signalname="XLXN_6" name="I0" />
            <blockpin signalname="XLXN_5" name="I1" />
            <blockpin signalname="XLXN_15" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_4">
            <blockpin signalname="S(0)" name="I0" />
            <blockpin signalname="XLXN_5" name="I1" />
            <blockpin signalname="XLXN_16" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_5">
            <blockpin signalname="S(1)" name="I0" />
            <blockpin signalname="XLXN_6" name="I1" />
            <blockpin signalname="XLXN_17" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_6">
            <blockpin signalname="S(1)" name="I0" />
            <blockpin signalname="S(0)" name="I1" />
            <blockpin signalname="XLXN_18" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_7">
            <blockpin signalname="I0" name="I0" />
            <blockpin signalname="XLXN_15" name="I1" />
            <blockpin signalname="XLXN_24" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_8">
            <blockpin signalname="I1" name="I0" />
            <blockpin signalname="XLXN_16" name="I1" />
            <blockpin signalname="XLXN_26" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_9">
            <blockpin signalname="I2" name="I0" />
            <blockpin signalname="XLXN_17" name="I1" />
            <blockpin signalname="XLXN_27" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_10">
            <blockpin signalname="I3" name="I0" />
            <blockpin signalname="XLXN_18" name="I1" />
            <blockpin signalname="XLXN_28" name="O" />
        </block>
        <block symbolname="or4" name="XLXI_11">
            <blockpin signalname="XLXN_28" name="I0" />
            <blockpin signalname="XLXN_27" name="I1" />
            <blockpin signalname="XLXN_26" name="I2" />
            <blockpin signalname="XLXN_24" name="I3" />
            <blockpin signalname="O" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="S(1:0)">
            <wire x2="512" y1="544" y2="544" x1="384" />
            <wire x2="512" y1="544" y2="592" x1="512" />
            <wire x2="512" y1="592" y2="720" x1="512" />
            <wire x2="512" y1="368" y2="496" x1="512" />
            <wire x2="512" y1="496" y2="544" x1="512" />
        </branch>
        <bustap x2="608" y1="496" y2="496" x1="512" />
        <bustap x2="608" y1="592" y2="592" x1="512" />
        <iomarker fontsize="28" x="384" y="544" name="S(1:0)" orien="R180" />
        <instance x="736" y="528" name="XLXI_1" orien="R0" />
        <instance x="736" y="624" name="XLXI_2" orien="R0" />
        <instance x="1200" y="624" name="XLXI_3" orien="R0" />
        <instance x="1200" y="800" name="XLXI_4" orien="R0" />
        <instance x="1200" y="960" name="XLXI_5" orien="R0" />
        <instance x="1200" y="1136" name="XLXI_6" orien="R0" />
        <branch name="XLXN_5">
            <wire x2="1056" y1="496" y2="496" x1="960" />
            <wire x2="1200" y1="496" y2="496" x1="1056" />
            <wire x2="1056" y1="496" y2="672" x1="1056" />
            <wire x2="1200" y1="672" y2="672" x1="1056" />
        </branch>
        <branch name="XLXN_6">
            <wire x2="1072" y1="592" y2="592" x1="960" />
            <wire x2="1072" y1="592" y2="832" x1="1072" />
            <wire x2="1200" y1="832" y2="832" x1="1072" />
            <wire x2="1072" y1="560" y2="592" x1="1072" />
            <wire x2="1200" y1="560" y2="560" x1="1072" />
        </branch>
        <branch name="S(1)">
            <wire x2="720" y1="496" y2="496" x1="608" />
            <wire x2="736" y1="496" y2="496" x1="720" />
            <wire x2="720" y1="496" y2="896" x1="720" />
            <wire x2="1200" y1="896" y2="896" x1="720" />
            <wire x2="720" y1="896" y2="1072" x1="720" />
            <wire x2="1200" y1="1072" y2="1072" x1="720" />
        </branch>
        <branch name="S(0)">
            <wire x2="656" y1="592" y2="592" x1="608" />
            <wire x2="736" y1="592" y2="592" x1="656" />
            <wire x2="656" y1="592" y2="736" x1="656" />
            <wire x2="1200" y1="736" y2="736" x1="656" />
            <wire x2="656" y1="736" y2="1008" x1="656" />
            <wire x2="1200" y1="1008" y2="1008" x1="656" />
        </branch>
        <branch name="I1">
            <wire x2="1184" y1="1296" y2="1296" x1="528" />
            <wire x2="1536" y1="1296" y2="1296" x1="1184" />
            <wire x2="1744" y1="768" y2="768" x1="1536" />
            <wire x2="1536" y1="768" y2="1296" x1="1536" />
        </branch>
        <branch name="I2">
            <wire x2="1184" y1="1344" y2="1344" x1="528" />
            <wire x2="1568" y1="1344" y2="1344" x1="1184" />
            <wire x2="1744" y1="928" y2="928" x1="1568" />
            <wire x2="1568" y1="928" y2="1344" x1="1568" />
        </branch>
        <branch name="I3">
            <wire x2="1184" y1="1392" y2="1392" x1="528" />
            <wire x2="1632" y1="1392" y2="1392" x1="1184" />
            <wire x2="1744" y1="1104" y2="1104" x1="1632" />
            <wire x2="1632" y1="1104" y2="1392" x1="1632" />
        </branch>
        <iomarker fontsize="28" x="528" y="1232" name="I0" orien="R180" />
        <iomarker fontsize="28" x="528" y="1296" name="I1" orien="R180" />
        <iomarker fontsize="28" x="528" y="1344" name="I2" orien="R180" />
        <iomarker fontsize="28" x="528" y="1392" name="I3" orien="R180" />
        <branch name="XLXN_15">
            <wire x2="1744" y1="528" y2="528" x1="1456" />
        </branch>
        <branch name="XLXN_16">
            <wire x2="1744" y1="704" y2="704" x1="1456" />
        </branch>
        <branch name="XLXN_17">
            <wire x2="1744" y1="864" y2="864" x1="1456" />
        </branch>
        <branch name="XLXN_18">
            <wire x2="1744" y1="1040" y2="1040" x1="1456" />
        </branch>
        <instance x="1744" y="656" name="XLXI_7" orien="R0" />
        <instance x="1744" y="832" name="XLXI_8" orien="R0" />
        <instance x="1744" y="992" name="XLXI_9" orien="R0" />
        <instance x="1744" y="1168" name="XLXI_10" orien="R0" />
        <branch name="I0">
            <wire x2="1184" y1="1232" y2="1232" x1="528" />
            <wire x2="1504" y1="1232" y2="1232" x1="1184" />
            <wire x2="1744" y1="592" y2="592" x1="1504" />
            <wire x2="1504" y1="592" y2="1232" x1="1504" />
        </branch>
        <instance x="2176" y="976" name="XLXI_11" orien="R0" />
        <branch name="XLXN_24">
            <wire x2="2176" y1="560" y2="560" x1="2000" />
            <wire x2="2176" y1="560" y2="720" x1="2176" />
        </branch>
        <branch name="XLXN_26">
            <wire x2="2080" y1="736" y2="736" x1="2000" />
            <wire x2="2080" y1="736" y2="784" x1="2080" />
            <wire x2="2176" y1="784" y2="784" x1="2080" />
        </branch>
        <branch name="XLXN_27">
            <wire x2="2080" y1="896" y2="896" x1="2000" />
            <wire x2="2080" y1="848" y2="896" x1="2080" />
            <wire x2="2176" y1="848" y2="848" x1="2080" />
        </branch>
        <branch name="XLXN_28">
            <wire x2="2176" y1="1072" y2="1072" x1="2000" />
            <wire x2="2176" y1="912" y2="1072" x1="2176" />
        </branch>
        <branch name="O">
            <wire x2="2464" y1="816" y2="816" x1="2432" />
        </branch>
        <iomarker fontsize="28" x="2464" y="816" name="O" orien="R0" />
    </sheet>
</drawing>