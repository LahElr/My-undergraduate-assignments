<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="clk" />
        <signal name="RST" />
        <signal name="clkd(31:0)" />
        <signal name="XLXN_8" />
        <signal name="HEX(1)" />
        <signal name="HEX(0)" />
        <signal name="HEX(2)" />
        <signal name="HEX(3)" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14" />
        <signal name="AN(3:0)" />
        <signal name="HEX(3:0)" />
        <signal name="Segment(7:0)" />
        <signal name="Segment(7)" />
        <signal name="Segment(6)" />
        <signal name="Segment(5)" />
        <signal name="Segment(4)" />
        <signal name="Segment(3)" />
        <signal name="Segment(2)" />
        <signal name="Segment(1)" />
        <signal name="Segment(0)" />
        <signal name="clkd(18:17)" />
        <signal name="HEXS(15:0)" />
        <signal name="point(3:0)" />
        <signal name="LES(3:0)" />
        <port polarity="Input" name="clk" />
        <port polarity="Input" name="RST" />
        <port polarity="Output" name="AN(3:0)" />
        <port polarity="Output" name="Segment(7:0)" />
        <port polarity="Input" name="HEXS(15:0)" />
        <port polarity="Input" name="point(3:0)" />
        <port polarity="Input" name="LES(3:0)" />
        <blockdef name="MyMc14495">
            <timestamp>2019-10-23T12:29:14</timestamp>
            <rect width="256" x="64" y="-512" height="512" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-400" y2="-400" x1="64" />
            <line x2="0" y1="-320" y2="-320" x1="64" />
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-80" y2="-80" x1="64" />
            <line x2="384" y1="-480" y2="-480" x1="320" />
            <line x2="384" y1="-416" y2="-416" x1="320" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="DisplaySync">
            <timestamp>2019-10-30T12:0:56</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="clkdiv">
            <timestamp>2019-10-30T12:14:17</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <block symbolname="MyMc14495" name="XLXI_2">
            <blockpin signalname="XLXN_14" name="LE" />
            <blockpin signalname="XLXN_13" name="point" />
            <blockpin signalname="HEX(0)" name="D0" />
            <blockpin signalname="HEX(1)" name="D1" />
            <blockpin signalname="HEX(2)" name="D2" />
            <blockpin signalname="HEX(3)" name="D3" />
            <blockpin signalname="Segment(7)" name="Dp" />
            <blockpin signalname="Segment(6)" name="G" />
            <blockpin signalname="Segment(5)" name="F" />
            <blockpin signalname="Segment(4)" name="E" />
            <blockpin signalname="Segment(3)" name="D" />
            <blockpin signalname="Segment(2)" name="C" />
            <blockpin signalname="Segment(1)" name="B" />
            <blockpin signalname="Segment(0)" name="A" />
        </block>
        <block symbolname="DisplaySync" name="XLXI_3">
            <blockpin signalname="clkd(18:17)" name="SCAN(1:0)" />
            <blockpin signalname="HEXS(15:0)" name="HEXS(15:0)" />
            <blockpin signalname="point(3:0)" name="point(3:0)" />
            <blockpin signalname="LES(3:0)" name="LES(3:0)" />
            <blockpin signalname="AN(3:0)" name="AN(3:0)" />
            <blockpin signalname="XLXN_14" name="LE" />
            <blockpin signalname="XLXN_13" name="P" />
            <blockpin signalname="HEX(3:0)" name="HEX(3:0)" />
        </block>
        <block symbolname="clkdiv" name="XLXI_4">
            <blockpin signalname="clk" name="clk" />
            <blockpin signalname="RST" name="rst" />
            <blockpin signalname="clkd(31:0)" name="clkdiv(31:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2080" y="1104" name="XLXI_2" orien="R0">
        </instance>
        <instance x="1104" y="1760" name="XLXI_3" orien="R0">
        </instance>
        <branch name="clk">
            <wire x2="832" y1="640" y2="640" x1="640" />
        </branch>
        <branch name="RST">
            <wire x2="832" y1="704" y2="704" x1="640" />
        </branch>
        <iomarker fontsize="28" x="640" y="640" name="clk" orien="R180" />
        <iomarker fontsize="28" x="640" y="704" name="RST" orien="R180" />
        <instance x="832" y="736" name="XLXI_4" orien="R0">
        </instance>
        <bustap x2="1872" y1="784" y2="784" x1="1776" />
        <bustap x2="1872" y1="864" y2="864" x1="1776" />
        <branch name="HEX(1)">
            <wire x2="2080" y1="864" y2="864" x1="1872" />
        </branch>
        <bustap x2="1872" y1="944" y2="944" x1="1776" />
        <bustap x2="1872" y1="1024" y2="1024" x1="1776" />
        <branch name="HEX(0)">
            <wire x2="2080" y1="784" y2="784" x1="1872" />
        </branch>
        <branch name="HEX(2)">
            <wire x2="2080" y1="944" y2="944" x1="1872" />
        </branch>
        <branch name="HEX(3)">
            <wire x2="2080" y1="1024" y2="1024" x1="1872" />
        </branch>
        <branch name="XLXN_13">
            <wire x2="1760" y1="1664" y2="1664" x1="1488" />
            <wire x2="1760" y1="704" y2="1664" x1="1760" />
            <wire x2="2080" y1="704" y2="704" x1="1760" />
        </branch>
        <branch name="XLXN_14">
            <wire x2="1744" y1="1600" y2="1600" x1="1488" />
            <wire x2="1744" y1="624" y2="1600" x1="1744" />
            <wire x2="2080" y1="624" y2="624" x1="1744" />
        </branch>
        <branch name="AN(3:0)">
            <wire x2="1552" y1="1536" y2="1536" x1="1488" />
            <wire x2="1552" y1="1472" y2="1536" x1="1552" />
            <wire x2="1840" y1="1472" y2="1472" x1="1552" />
            <wire x2="1840" y1="1472" y2="1536" x1="1840" />
            <wire x2="2736" y1="1536" y2="1536" x1="1840" />
        </branch>
        <branch name="HEX(3:0)">
            <wire x2="1776" y1="1728" y2="1728" x1="1488" />
            <wire x2="1776" y1="784" y2="864" x1="1776" />
            <wire x2="1776" y1="864" y2="944" x1="1776" />
            <wire x2="1776" y1="944" y2="1024" x1="1776" />
            <wire x2="1776" y1="1024" y2="1728" x1="1776" />
        </branch>
        <iomarker fontsize="28" x="2736" y="1536" name="AN(3:0)" orien="R0" />
        <branch name="Segment(7:0)">
            <wire x2="2816" y1="592" y2="624" x1="2816" />
            <wire x2="2816" y1="624" y2="688" x1="2816" />
            <wire x2="2816" y1="688" y2="752" x1="2816" />
            <wire x2="2816" y1="752" y2="816" x1="2816" />
            <wire x2="2816" y1="816" y2="880" x1="2816" />
            <wire x2="2816" y1="880" y2="944" x1="2816" />
            <wire x2="2816" y1="944" y2="1008" x1="2816" />
            <wire x2="2816" y1="1008" y2="1072" x1="2816" />
            <wire x2="2816" y1="1072" y2="1152" x1="2816" />
            <wire x2="3232" y1="1152" y2="1152" x1="2816" />
        </branch>
        <bustap x2="2720" y1="624" y2="624" x1="2816" />
        <bustap x2="2720" y1="688" y2="688" x1="2816" />
        <bustap x2="2720" y1="752" y2="752" x1="2816" />
        <bustap x2="2720" y1="816" y2="816" x1="2816" />
        <bustap x2="2720" y1="880" y2="880" x1="2816" />
        <bustap x2="2720" y1="944" y2="944" x1="2816" />
        <bustap x2="2720" y1="1008" y2="1008" x1="2816" />
        <bustap x2="2720" y1="1072" y2="1072" x1="2816" />
        <branch name="Segment(7)">
            <wire x2="2720" y1="624" y2="624" x1="2464" />
        </branch>
        <branch name="Segment(6)">
            <wire x2="2720" y1="688" y2="688" x1="2464" />
        </branch>
        <branch name="Segment(5)">
            <wire x2="2720" y1="752" y2="752" x1="2464" />
        </branch>
        <branch name="Segment(4)">
            <wire x2="2720" y1="816" y2="816" x1="2464" />
        </branch>
        <branch name="Segment(3)">
            <wire x2="2720" y1="880" y2="880" x1="2464" />
        </branch>
        <branch name="Segment(2)">
            <wire x2="2720" y1="944" y2="944" x1="2464" />
        </branch>
        <branch name="Segment(1)">
            <wire x2="2720" y1="1008" y2="1008" x1="2464" />
        </branch>
        <branch name="Segment(0)">
            <wire x2="2720" y1="1072" y2="1072" x1="2464" />
        </branch>
        <iomarker fontsize="28" x="3232" y="1152" name="Segment(7:0)" orien="R0" />
        <bustap x2="848" y1="1536" y2="1536" x1="752" />
        <branch name="clkd(18:17)">
            <wire x2="1104" y1="1536" y2="1536" x1="848" />
        </branch>
        <branch name="HEXS(15:0)">
            <wire x2="1104" y1="1600" y2="1600" x1="624" />
        </branch>
        <branch name="point(3:0)">
            <wire x2="1104" y1="1664" y2="1664" x1="624" />
        </branch>
        <branch name="clkd(31:0)">
            <wire x2="1392" y1="1232" y2="1232" x1="752" />
            <wire x2="752" y1="1232" y2="1536" x1="752" />
            <wire x2="1392" y1="640" y2="640" x1="1216" />
            <wire x2="1392" y1="640" y2="1232" x1="1392" />
        </branch>
        <branch name="LES(3:0)">
            <wire x2="1104" y1="1728" y2="1728" x1="624" />
        </branch>
        <iomarker fontsize="28" x="624" y="1600" name="HEXS(15:0)" orien="R180" />
        <iomarker fontsize="28" x="624" y="1664" name="point(3:0)" orien="R180" />
        <iomarker fontsize="28" x="624" y="1728" name="LES(3:0)" orien="R180" />
    </sheet>
</drawing>