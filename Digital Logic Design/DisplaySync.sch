<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="SCAN(1:0)" />
        <signal name="HEXS(15:0)" />
        <signal name="HEXS(3:0)" />
        <signal name="HEXS(7:4)" />
        <signal name="HEXS(11:8)" />
        <signal name="HEXS(15:12)" />
        <signal name="point(3:0)" />
        <signal name="point(0)" />
        <signal name="point(1)" />
        <signal name="point(2)" />
        <signal name="point(3)" />
        <signal name="LES(3:0)" />
        <signal name="LES(0)" />
        <signal name="LES(1)" />
        <signal name="LES(2)" />
        <signal name="LES(3)" />
        <signal name="V1" />
        <signal name="V0" />
        <signal name="V1,V1,V1,V0" />
        <signal name="V1,V1,V0,V1" />
        <signal name="V1,V0,V1,V1" />
        <signal name="V0,V1,V1,V1" />
        <signal name="AN(3:0)" />
        <signal name="LE" />
        <signal name="P" />
        <signal name="HEX(3:0)" />
        <port polarity="Input" name="SCAN(1:0)" />
        <port polarity="Input" name="HEXS(15:0)" />
        <port polarity="Input" name="point(3:0)" />
        <port polarity="Input" name="LES(3:0)" />
        <port polarity="Output" name="AN(3:0)" />
        <port polarity="Output" name="LE" />
        <port polarity="Output" name="P" />
        <port polarity="Output" name="HEX(3:0)" />
        <blockdef name="MUX4to1b4">
            <timestamp>2019-10-30T10:19:15</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-300" height="24" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
        </blockdef>
        <blockdef name="MUX4to1">
            <timestamp>2019-10-30T11:43:55</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <block symbolname="MUX4to1b4" name="XLXI_1">
            <blockpin signalname="SCAN(1:0)" name="S(1:0)" />
            <blockpin signalname="HEXS(3:0)" name="I0(3:0)" />
            <blockpin signalname="HEXS(7:4)" name="I1(3:0)" />
            <blockpin signalname="HEXS(11:8)" name="I2(3:0)" />
            <blockpin signalname="HEXS(15:12)" name="I3(3:0)" />
            <blockpin signalname="HEX(3:0)" name="O(3:0)" />
        </block>
        <block symbolname="MUX4to1b4" name="XLXI_2">
            <blockpin signalname="SCAN(1:0)" name="S(1:0)" />
            <blockpin signalname="V1,V1,V1,V0" name="I0(3:0)" />
            <blockpin signalname="V1,V1,V0,V1" name="I1(3:0)" />
            <blockpin signalname="V1,V0,V1,V1" name="I2(3:0)" />
            <blockpin signalname="V0,V1,V1,V1" name="I3(3:0)" />
            <blockpin signalname="AN(3:0)" name="O(3:0)" />
        </block>
        <block symbolname="MUX4to1" name="XLXI_3">
            <blockpin signalname="SCAN(1:0)" name="S(1:0)" />
            <blockpin signalname="point(0)" name="I0" />
            <blockpin signalname="point(1)" name="I1" />
            <blockpin signalname="point(2)" name="I2" />
            <blockpin signalname="point(3)" name="I3" />
            <blockpin signalname="P" name="O" />
        </block>
        <block symbolname="MUX4to1" name="XLXI_4">
            <blockpin signalname="SCAN(1:0)" name="S(1:0)" />
            <blockpin signalname="LES(0)" name="I0" />
            <blockpin signalname="LES(1)" name="I1" />
            <blockpin signalname="LES(2)" name="I2" />
            <blockpin signalname="LES(3)" name="I3" />
            <blockpin signalname="LE" name="O" />
        </block>
        <block symbolname="vcc" name="XLXI_5">
            <blockpin signalname="V1" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_6">
            <blockpin signalname="V0" name="G" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1312" y="640" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1344" y="1984" name="XLXI_2" orien="R0">
        </instance>
        <instance x="1392" y="1088" name="XLXI_3" orien="R0">
        </instance>
        <instance x="1392" y="1488" name="XLXI_4" orien="R0">
        </instance>
        <iomarker fontsize="28" x="592" y="224" name="SCAN(1:0)" orien="R180" />
        <branch name="SCAN(1:0)">
            <wire x2="752" y1="224" y2="224" x1="592" />
            <wire x2="752" y1="224" y2="352" x1="752" />
            <wire x2="1312" y1="352" y2="352" x1="752" />
            <wire x2="752" y1="352" y2="800" x1="752" />
            <wire x2="1392" y1="800" y2="800" x1="752" />
            <wire x2="752" y1="800" y2="1200" x1="752" />
            <wire x2="1392" y1="1200" y2="1200" x1="752" />
            <wire x2="752" y1="1200" y2="1696" x1="752" />
            <wire x2="1344" y1="1696" y2="1696" x1="752" />
        </branch>
        <branch name="HEXS(15:0)">
            <wire x2="256" y1="464" y2="464" x1="192" />
            <wire x2="320" y1="464" y2="464" x1="256" />
            <wire x2="256" y1="464" y2="528" x1="256" />
            <wire x2="256" y1="528" y2="640" x1="256" />
            <wire x2="320" y1="640" y2="640" x1="256" />
            <wire x2="320" y1="528" y2="528" x1="256" />
            <wire x2="304" y1="400" y2="400" x1="256" />
            <wire x2="256" y1="400" y2="464" x1="256" />
            <wire x2="304" y1="384" y2="400" x1="304" />
            <wire x2="320" y1="448" y2="464" x1="320" />
            <wire x2="320" y1="512" y2="528" x1="320" />
            <wire x2="320" y1="624" y2="640" x1="320" />
        </branch>
        <bustap x2="400" y1="400" y2="400" x1="304" />
        <bustap x2="416" y1="464" y2="464" x1="320" />
        <bustap x2="416" y1="528" y2="528" x1="320" />
        <bustap x2="416" y1="640" y2="640" x1="320" />
        <branch name="HEXS(3:0)">
            <wire x2="848" y1="400" y2="400" x1="400" />
            <wire x2="848" y1="400" y2="416" x1="848" />
            <wire x2="1312" y1="416" y2="416" x1="848" />
        </branch>
        <branch name="HEXS(7:4)">
            <wire x2="864" y1="464" y2="464" x1="416" />
            <wire x2="864" y1="464" y2="480" x1="864" />
            <wire x2="1312" y1="480" y2="480" x1="864" />
        </branch>
        <branch name="HEXS(11:8)">
            <wire x2="864" y1="528" y2="528" x1="416" />
            <wire x2="864" y1="528" y2="544" x1="864" />
            <wire x2="1312" y1="544" y2="544" x1="864" />
        </branch>
        <branch name="HEXS(15:12)">
            <wire x2="864" y1="640" y2="640" x1="416" />
            <wire x2="864" y1="608" y2="640" x1="864" />
            <wire x2="1312" y1="608" y2="608" x1="864" />
        </branch>
        <iomarker fontsize="28" x="192" y="464" name="HEXS(15:0)" orien="R180" />
        <branch name="point(3:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="520" y="848" type="branch" />
            <wire x2="528" y1="848" y2="848" x1="496" />
            <wire x2="544" y1="848" y2="848" x1="528" />
            <wire x2="544" y1="848" y2="880" x1="544" />
            <wire x2="544" y1="880" y2="944" x1="544" />
            <wire x2="544" y1="944" y2="976" x1="544" />
            <wire x2="544" y1="976" y2="992" x1="544" />
            <wire x2="544" y1="992" y2="1072" x1="544" />
            <wire x2="544" y1="1072" y2="1120" x1="544" />
        </branch>
        <bustap x2="640" y1="880" y2="880" x1="544" />
        <bustap x2="640" y1="944" y2="944" x1="544" />
        <bustap x2="640" y1="992" y2="992" x1="544" />
        <bustap x2="640" y1="1072" y2="1072" x1="544" />
        <branch name="point(0)">
            <wire x2="1008" y1="880" y2="880" x1="640" />
            <wire x2="1008" y1="864" y2="880" x1="1008" />
            <wire x2="1392" y1="864" y2="864" x1="1008" />
        </branch>
        <branch name="point(1)">
            <wire x2="1008" y1="944" y2="944" x1="640" />
            <wire x2="1008" y1="928" y2="944" x1="1008" />
            <wire x2="1392" y1="928" y2="928" x1="1008" />
        </branch>
        <branch name="point(2)">
            <wire x2="1392" y1="992" y2="992" x1="640" />
        </branch>
        <branch name="point(3)">
            <wire x2="1008" y1="1072" y2="1072" x1="640" />
            <wire x2="1008" y1="1056" y2="1072" x1="1008" />
            <wire x2="1392" y1="1056" y2="1056" x1="1008" />
        </branch>
        <iomarker fontsize="28" x="496" y="848" name="point(3:0)" orien="R180" />
        <branch name="LES(3:0)">
            <wire x2="544" y1="1248" y2="1248" x1="464" />
            <wire x2="544" y1="1248" y2="1280" x1="544" />
            <wire x2="544" y1="1280" y2="1344" x1="544" />
            <wire x2="544" y1="1344" y2="1392" x1="544" />
            <wire x2="544" y1="1392" y2="1456" x1="544" />
            <wire x2="544" y1="1456" y2="1504" x1="544" />
        </branch>
        <bustap x2="640" y1="1280" y2="1280" x1="544" />
        <bustap x2="640" y1="1344" y2="1344" x1="544" />
        <bustap x2="640" y1="1392" y2="1392" x1="544" />
        <bustap x2="640" y1="1456" y2="1456" x1="544" />
        <branch name="LES(0)">
            <wire x2="1008" y1="1280" y2="1280" x1="640" />
            <wire x2="1008" y1="1264" y2="1280" x1="1008" />
            <wire x2="1392" y1="1264" y2="1264" x1="1008" />
        </branch>
        <branch name="LES(1)">
            <wire x2="1008" y1="1344" y2="1344" x1="640" />
            <wire x2="1008" y1="1328" y2="1344" x1="1008" />
            <wire x2="1392" y1="1328" y2="1328" x1="1008" />
        </branch>
        <branch name="LES(2)">
            <wire x2="1392" y1="1392" y2="1392" x1="640" />
        </branch>
        <branch name="LES(3)">
            <wire x2="1392" y1="1456" y2="1456" x1="640" />
        </branch>
        <iomarker fontsize="28" x="464" y="1248" name="LES(3:0)" orien="R180" />
        <instance x="336" y="1840" name="XLXI_5" orien="R0" />
        <branch name="V1">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="336" y="1952" type="branch" />
            <wire x2="400" y1="1952" y2="1952" x1="336" />
            <wire x2="400" y1="1840" y2="1952" x1="400" />
        </branch>
        <branch name="V0">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="592" y="1840" type="branch" />
            <wire x2="512" y1="1840" y2="1904" x1="512" />
            <wire x2="592" y1="1840" y2="1840" x1="512" />
        </branch>
        <branch name="V1,V1,V1,V0">
            <wire x2="1344" y1="1760" y2="1760" x1="1168" />
        </branch>
        <branch name="V1,V1,V0,V1">
            <wire x2="1344" y1="1824" y2="1824" x1="1168" />
        </branch>
        <branch name="V1,V0,V1,V1">
            <wire x2="1344" y1="1888" y2="1888" x1="1168" />
        </branch>
        <branch name="V0,V1,V1,V1">
            <wire x2="1344" y1="1952" y2="1952" x1="1168" />
        </branch>
        <branch name="AN(3:0)">
            <wire x2="1904" y1="1696" y2="1696" x1="1728" />
        </branch>
        <branch name="LE">
            <wire x2="1984" y1="1200" y2="1200" x1="1776" />
        </branch>
        <branch name="P">
            <wire x2="1968" y1="800" y2="800" x1="1776" />
        </branch>
        <branch name="HEX(3:0)">
            <wire x2="1984" y1="352" y2="352" x1="1696" />
        </branch>
        <iomarker fontsize="28" x="1984" y="352" name="HEX(3:0)" orien="R0" />
        <iomarker fontsize="28" x="1968" y="800" name="P" orien="R0" />
        <iomarker fontsize="28" x="1984" y="1200" name="LE" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1696" name="AN(3:0)" orien="R0" />
        <instance x="448" y="2032" name="XLXI_6" orien="R0" />
    </sheet>
</drawing>