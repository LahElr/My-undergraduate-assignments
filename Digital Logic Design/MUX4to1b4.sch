<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="S(1:0)" />
        <signal name="XLXN_4" />
        <signal name="XLXN_6" />
        <signal name="S(0)" />
        <signal name="S(1)" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14" />
        <signal name="XLXN_15" />
        <signal name="I0(3:0)" />
        <signal name="I1(3:0)" />
        <signal name="I2(3:0)" />
        <signal name="I3(3:0)" />
        <signal name="I0(3)" />
        <signal name="I0(2)" />
        <signal name="I0(1)" />
        <signal name="I0(0)" />
        <signal name="I1(1)" />
        <signal name="I1(0)" />
        <signal name="I1(3)" />
        <signal name="I1(2)" />
        <signal name="I2(3)" />
        <signal name="I2(2)" />
        <signal name="I2(1)" />
        <signal name="I2(0)" />
        <signal name="I3(1)" />
        <signal name="I3(0)" />
        <signal name="I3(2)" />
        <signal name="I3(3)" />
        <signal name="XLXN_59" />
        <signal name="XLXN_60" />
        <signal name="XLXN_61" />
        <signal name="XLXN_62" />
        <signal name="XLXN_63" />
        <signal name="XLXN_64" />
        <signal name="XLXN_65" />
        <signal name="XLXN_66" />
        <signal name="XLXN_67" />
        <signal name="XLXN_68" />
        <signal name="XLXN_69" />
        <signal name="XLXN_70" />
        <signal name="XLXN_71" />
        <signal name="XLXN_73" />
        <signal name="XLXN_74" />
        <signal name="XLXN_75" />
        <signal name="O(3:0)" />
        <signal name="O(0)" />
        <signal name="O(1)" />
        <signal name="O(2)" />
        <signal name="O(3)" />
        <port polarity="Input" name="S(1:0)" />
        <port polarity="Input" name="I0(3:0)" />
        <port polarity="Input" name="I1(3:0)" />
        <port polarity="Input" name="I2(3:0)" />
        <port polarity="Input" name="I3(3:0)" />
        <port polarity="Output" name="O(3:0)" />
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
            <blockpin signalname="XLXN_4" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_2">
            <blockpin signalname="S(0)" name="I" />
            <blockpin signalname="XLXN_6" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_3">
            <blockpin signalname="XLXN_6" name="I0" />
            <blockpin signalname="XLXN_4" name="I1" />
            <blockpin signalname="XLXN_12" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_4">
            <blockpin signalname="S(0)" name="I0" />
            <blockpin signalname="XLXN_4" name="I1" />
            <blockpin signalname="XLXN_13" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_5">
            <blockpin signalname="S(1)" name="I0" />
            <blockpin signalname="XLXN_6" name="I1" />
            <blockpin signalname="XLXN_14" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_6">
            <blockpin signalname="S(1)" name="I0" />
            <blockpin signalname="S(0)" name="I1" />
            <blockpin signalname="XLXN_15" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_7">
            <blockpin signalname="I0(0)" name="I0" />
            <blockpin signalname="XLXN_12" name="I1" />
            <blockpin signalname="XLXN_59" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_8">
            <blockpin signalname="I1(0)" name="I0" />
            <blockpin signalname="XLXN_13" name="I1" />
            <blockpin signalname="XLXN_60" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_9">
            <blockpin signalname="I2(0)" name="I0" />
            <blockpin signalname="XLXN_14" name="I1" />
            <blockpin signalname="XLXN_61" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_10">
            <blockpin signalname="I3(0)" name="I0" />
            <blockpin signalname="XLXN_15" name="I1" />
            <blockpin signalname="XLXN_62" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_11">
            <blockpin signalname="I0(1)" name="I0" />
            <blockpin signalname="XLXN_12" name="I1" />
            <blockpin signalname="XLXN_63" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_12">
            <blockpin signalname="I1(1)" name="I0" />
            <blockpin signalname="XLXN_13" name="I1" />
            <blockpin signalname="XLXN_64" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_13">
            <blockpin signalname="I2(1)" name="I0" />
            <blockpin signalname="XLXN_14" name="I1" />
            <blockpin signalname="XLXN_65" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_14">
            <blockpin signalname="I3(1)" name="I0" />
            <blockpin signalname="XLXN_15" name="I1" />
            <blockpin signalname="XLXN_66" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_15">
            <blockpin signalname="I0(2)" name="I0" />
            <blockpin signalname="XLXN_12" name="I1" />
            <blockpin signalname="XLXN_67" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_16">
            <blockpin signalname="I1(2)" name="I0" />
            <blockpin signalname="XLXN_13" name="I1" />
            <blockpin signalname="XLXN_68" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_17">
            <blockpin signalname="I2(2)" name="I0" />
            <blockpin signalname="XLXN_14" name="I1" />
            <blockpin signalname="XLXN_69" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_18">
            <blockpin signalname="I3(2)" name="I0" />
            <blockpin signalname="XLXN_15" name="I1" />
            <blockpin signalname="XLXN_70" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_19">
            <blockpin signalname="I0(3)" name="I0" />
            <blockpin signalname="XLXN_12" name="I1" />
            <blockpin signalname="XLXN_71" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_20">
            <blockpin signalname="I1(3)" name="I0" />
            <blockpin signalname="XLXN_13" name="I1" />
            <blockpin signalname="XLXN_73" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_21">
            <blockpin signalname="I2(3)" name="I0" />
            <blockpin signalname="XLXN_14" name="I1" />
            <blockpin signalname="XLXN_74" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_22">
            <blockpin signalname="I3(3)" name="I0" />
            <blockpin signalname="XLXN_15" name="I1" />
            <blockpin signalname="XLXN_75" name="O" />
        </block>
        <block symbolname="or4" name="XLXI_23">
            <blockpin signalname="XLXN_62" name="I0" />
            <blockpin signalname="XLXN_61" name="I1" />
            <blockpin signalname="XLXN_60" name="I2" />
            <blockpin signalname="XLXN_59" name="I3" />
            <blockpin signalname="O(0)" name="O" />
        </block>
        <block symbolname="or4" name="XLXI_24">
            <blockpin signalname="XLXN_66" name="I0" />
            <blockpin signalname="XLXN_65" name="I1" />
            <blockpin signalname="XLXN_64" name="I2" />
            <blockpin signalname="XLXN_63" name="I3" />
            <blockpin signalname="O(1)" name="O" />
        </block>
        <block symbolname="or4" name="XLXI_25">
            <blockpin signalname="XLXN_75" name="I0" />
            <blockpin signalname="XLXN_74" name="I1" />
            <blockpin signalname="XLXN_73" name="I2" />
            <blockpin signalname="XLXN_71" name="I3" />
            <blockpin signalname="O(3)" name="O" />
        </block>
        <block symbolname="or4" name="XLXI_26">
            <blockpin signalname="XLXN_70" name="I0" />
            <blockpin signalname="XLXN_69" name="I1" />
            <blockpin signalname="XLXN_68" name="I2" />
            <blockpin signalname="XLXN_67" name="I3" />
            <blockpin signalname="O(2)" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="7040" height="5440">
        <bustap x2="1280" y1="656" y2="656" x1="1184" />
        <bustap x2="1280" y1="784" y2="784" x1="1184" />
        <branch name="S(1:0)">
            <wire x2="1184" y1="656" y2="656" x1="512" />
            <wire x2="1184" y1="656" y2="784" x1="1184" />
        </branch>
        <iomarker fontsize="28" x="512" y="656" name="S(1:0)" orien="R180" />
        <instance x="1472" y="688" name="XLXI_1" orien="R0" />
        <instance x="1472" y="816" name="XLXI_2" orien="R0" />
        <instance x="1952" y="816" name="XLXI_3" orien="R0" />
        <instance x="1952" y="976" name="XLXI_4" orien="R0" />
        <instance x="1952" y="1136" name="XLXI_5" orien="R0" />
        <instance x="1952" y="1280" name="XLXI_6" orien="R0" />
        <branch name="XLXN_4">
            <wire x2="1824" y1="656" y2="656" x1="1696" />
            <wire x2="1824" y1="656" y2="688" x1="1824" />
            <wire x2="1952" y1="688" y2="688" x1="1824" />
            <wire x2="1824" y1="688" y2="848" x1="1824" />
            <wire x2="1952" y1="848" y2="848" x1="1824" />
        </branch>
        <branch name="XLXN_6">
            <wire x2="1808" y1="784" y2="784" x1="1696" />
            <wire x2="1808" y1="784" y2="1008" x1="1808" />
            <wire x2="1952" y1="1008" y2="1008" x1="1808" />
            <wire x2="1808" y1="752" y2="784" x1="1808" />
            <wire x2="1952" y1="752" y2="752" x1="1808" />
        </branch>
        <branch name="S(0)">
            <wire x2="1456" y1="784" y2="784" x1="1280" />
            <wire x2="1472" y1="784" y2="784" x1="1456" />
            <wire x2="1456" y1="784" y2="912" x1="1456" />
            <wire x2="1952" y1="912" y2="912" x1="1456" />
            <wire x2="1456" y1="912" y2="1152" x1="1456" />
            <wire x2="1952" y1="1152" y2="1152" x1="1456" />
        </branch>
        <branch name="S(1)">
            <wire x2="1296" y1="656" y2="656" x1="1280" />
            <wire x2="1472" y1="656" y2="656" x1="1296" />
            <wire x2="1296" y1="656" y2="1072" x1="1296" />
            <wire x2="1952" y1="1072" y2="1072" x1="1296" />
            <wire x2="1296" y1="1072" y2="1216" x1="1296" />
            <wire x2="1952" y1="1216" y2="1216" x1="1296" />
        </branch>
        <instance x="2752" y="848" name="XLXI_7" orien="R0" />
        <branch name="XLXN_12">
            <wire x2="2336" y1="720" y2="720" x1="2208" />
            <wire x2="2752" y1="720" y2="720" x1="2336" />
            <wire x2="2336" y1="720" y2="1424" x1="2336" />
            <wire x2="2336" y1="1424" y2="2144" x1="2336" />
            <wire x2="2336" y1="2144" y2="2864" x1="2336" />
            <wire x2="3040" y1="2864" y2="2864" x1="2336" />
            <wire x2="2960" y1="2144" y2="2144" x1="2336" />
            <wire x2="2832" y1="1424" y2="1424" x1="2336" />
        </branch>
        <branch name="XLXN_13">
            <wire x2="2304" y1="880" y2="880" x1="2208" />
            <wire x2="2304" y1="880" y2="1584" x1="2304" />
            <wire x2="2304" y1="1584" y2="2304" x1="2304" />
            <wire x2="2304" y1="2304" y2="3024" x1="2304" />
            <wire x2="3040" y1="3024" y2="3024" x1="2304" />
            <wire x2="2960" y1="2304" y2="2304" x1="2304" />
            <wire x2="2864" y1="1584" y2="1584" x1="2304" />
            <wire x2="2816" y1="880" y2="880" x1="2304" />
        </branch>
        <branch name="XLXN_14">
            <wire x2="2272" y1="1040" y2="1040" x1="2208" />
            <wire x2="2272" y1="1040" y2="1744" x1="2272" />
            <wire x2="2272" y1="1744" y2="2464" x1="2272" />
            <wire x2="2272" y1="2464" y2="3184" x1="2272" />
            <wire x2="3056" y1="3184" y2="3184" x1="2272" />
            <wire x2="3008" y1="2464" y2="2464" x1="2272" />
            <wire x2="2880" y1="1744" y2="1744" x1="2272" />
            <wire x2="2864" y1="1040" y2="1040" x1="2272" />
        </branch>
        <instance x="2832" y="1552" name="XLXI_11" orien="R0" />
        <instance x="2848" y="2016" name="XLXI_14" orien="R0" />
        <instance x="2960" y="2272" name="XLXI_15" orien="R0" />
        <instance x="2960" y="2432" name="XLXI_16" orien="R0" />
        <instance x="2976" y="2736" name="XLXI_18" orien="R0" />
        <instance x="3040" y="2992" name="XLXI_19" orien="R0" />
        <instance x="3040" y="3152" name="XLXI_20" orien="R0" />
        <instance x="3056" y="3312" name="XLXI_21" orien="R0" />
        <instance x="3056" y="3456" name="XLXI_22" orien="R0" />
        <branch name="XLXN_15">
            <wire x2="2240" y1="1184" y2="1184" x1="2208" />
            <wire x2="2240" y1="1184" y2="1888" x1="2240" />
            <wire x2="2848" y1="1888" y2="1888" x1="2240" />
            <wire x2="2240" y1="1888" y2="2608" x1="2240" />
            <wire x2="2240" y1="2608" y2="3328" x1="2240" />
            <wire x2="3056" y1="3328" y2="3328" x1="2240" />
            <wire x2="2976" y1="2608" y2="2608" x1="2240" />
            <wire x2="2880" y1="1184" y2="1184" x1="2240" />
        </branch>
        <branch name="I2(3:0)">
            <wire x2="2560" y1="2528" y2="2528" x1="768" />
            <wire x2="2560" y1="2528" y2="3248" x1="2560" />
            <wire x2="2944" y1="3248" y2="3248" x1="2560" />
            <wire x2="2880" y1="2528" y2="2528" x1="2560" />
            <wire x2="2560" y1="1104" y2="1808" x1="2560" />
            <wire x2="2752" y1="1808" y2="1808" x1="2560" />
            <wire x2="2560" y1="1808" y2="2528" x1="2560" />
            <wire x2="2752" y1="1104" y2="1104" x1="2560" />
            <wire x2="2752" y1="1088" y2="1104" x1="2752" />
            <wire x2="2752" y1="1792" y2="1808" x1="2752" />
            <wire x2="2880" y1="2512" y2="2528" x1="2880" />
            <wire x2="2944" y1="3232" y2="3248" x1="2944" />
        </branch>
        <bustap x2="2544" y1="2928" y2="2928" x1="2448" />
        <branch name="I0(3)">
            <wire x2="3040" y1="2928" y2="2928" x1="2544" />
        </branch>
        <bustap x2="2544" y1="2208" y2="2208" x1="2448" />
        <branch name="I0(2)">
            <wire x2="2960" y1="2208" y2="2208" x1="2544" />
        </branch>
        <bustap x2="2544" y1="1488" y2="1488" x1="2448" />
        <branch name="I0(1)">
            <wire x2="2832" y1="1488" y2="1488" x1="2544" />
        </branch>
        <bustap x2="2544" y1="784" y2="784" x1="2448" />
        <branch name="I0(3:0)">
            <wire x2="2384" y1="2208" y2="2208" x1="768" />
            <wire x2="2384" y1="2208" y2="2928" x1="2384" />
            <wire x2="2448" y1="2928" y2="2928" x1="2384" />
            <wire x2="2448" y1="2208" y2="2208" x1="2384" />
            <wire x2="2384" y1="784" y2="1488" x1="2384" />
            <wire x2="2384" y1="1488" y2="2208" x1="2384" />
            <wire x2="2448" y1="1488" y2="1488" x1="2384" />
            <wire x2="2448" y1="784" y2="784" x1="2384" />
            <wire x2="2448" y1="1472" y2="1488" x1="2448" />
            <wire x2="2448" y1="2192" y2="2208" x1="2448" />
        </branch>
        <branch name="I0(0)">
            <wire x2="2752" y1="784" y2="784" x1="2544" />
        </branch>
        <bustap x2="2848" y1="1648" y2="1648" x1="2752" />
        <instance x="2864" y="1712" name="XLXI_12" orien="R0" />
        <branch name="I1(1)">
            <wire x2="2864" y1="1648" y2="1648" x1="2848" />
        </branch>
        <instance x="2816" y="1008" name="XLXI_8" orien="R0" />
        <bustap x2="2768" y1="944" y2="944" x1="2672" />
        <branch name="I1(0)">
            <wire x2="2816" y1="944" y2="944" x1="2768" />
        </branch>
        <bustap x2="2944" y1="2368" y2="2368" x1="2848" />
        <bustap x2="3008" y1="3088" y2="3088" x1="2912" />
        <branch name="I1(3)">
            <wire x2="3040" y1="3088" y2="3088" x1="3008" />
        </branch>
        <branch name="I1(2)">
            <wire x2="2960" y1="2368" y2="2368" x1="2944" />
        </branch>
        <branch name="I1(3:0)">
            <wire x2="2512" y1="2368" y2="2368" x1="768" />
            <wire x2="2512" y1="2368" y2="3088" x1="2512" />
            <wire x2="2912" y1="3088" y2="3088" x1="2512" />
            <wire x2="2848" y1="2368" y2="2368" x1="2512" />
            <wire x2="2672" y1="944" y2="944" x1="2512" />
            <wire x2="2512" y1="944" y2="1648" x1="2512" />
            <wire x2="2752" y1="1648" y2="1648" x1="2512" />
            <wire x2="2512" y1="1648" y2="2368" x1="2512" />
            <wire x2="2672" y1="928" y2="944" x1="2672" />
            <wire x2="2752" y1="1632" y2="1648" x1="2752" />
            <wire x2="2912" y1="3072" y2="3088" x1="2912" />
        </branch>
        <instance x="2880" y="1872" name="XLXI_13" orien="R0" />
        <bustap x2="2848" y1="1808" y2="1808" x1="2752" />
        <instance x="3008" y="2592" name="XLXI_17" orien="R0" />
        <bustap x2="2976" y1="2528" y2="2528" x1="2880" />
        <bustap x2="3040" y1="3248" y2="3248" x1="2944" />
        <branch name="I2(3)">
            <wire x2="3056" y1="3248" y2="3248" x1="3040" />
        </branch>
        <branch name="I2(2)">
            <wire x2="3008" y1="2528" y2="2528" x1="2976" />
        </branch>
        <branch name="I2(1)">
            <wire x2="2880" y1="1808" y2="1808" x1="2848" />
        </branch>
        <bustap x2="2848" y1="1104" y2="1104" x1="2752" />
        <branch name="I2(0)">
            <wire x2="2864" y1="1104" y2="1104" x1="2848" />
        </branch>
        <instance x="2864" y="1168" name="XLXI_9" orien="R0" />
        <instance x="2880" y="1312" name="XLXI_10" orien="R0" />
        <bustap x2="2768" y1="1248" y2="1248" x1="2672" />
        <bustap x2="2784" y1="1952" y2="1952" x1="2688" />
        <bustap x2="2848" y1="2672" y2="2672" x1="2752" />
        <bustap x2="2992" y1="3392" y2="3392" x1="2896" />
        <branch name="I3(3:0)">
            <wire x2="2608" y1="2672" y2="2672" x1="768" />
            <wire x2="2608" y1="2672" y2="3392" x1="2608" />
            <wire x2="2896" y1="3392" y2="3392" x1="2608" />
            <wire x2="2752" y1="2672" y2="2672" x1="2608" />
            <wire x2="2672" y1="1248" y2="1248" x1="2608" />
            <wire x2="2608" y1="1248" y2="1952" x1="2608" />
            <wire x2="2688" y1="1952" y2="1952" x1="2608" />
            <wire x2="2608" y1="1952" y2="2672" x1="2608" />
            <wire x2="2672" y1="1232" y2="1248" x1="2672" />
            <wire x2="2688" y1="1936" y2="1952" x1="2688" />
        </branch>
        <branch name="I3(1)">
            <wire x2="2848" y1="1952" y2="1952" x1="2784" />
        </branch>
        <branch name="I3(0)">
            <wire x2="2880" y1="1248" y2="1248" x1="2768" />
        </branch>
        <branch name="I3(2)">
            <wire x2="2976" y1="2672" y2="2672" x1="2848" />
        </branch>
        <branch name="I3(3)">
            <wire x2="3056" y1="3392" y2="3392" x1="2992" />
        </branch>
        <iomarker fontsize="28" x="768" y="2208" name="I0(3:0)" orien="R180" />
        <iomarker fontsize="28" x="768" y="2368" name="I1(3:0)" orien="R180" />
        <iomarker fontsize="28" x="768" y="2528" name="I2(3:0)" orien="R180" />
        <iomarker fontsize="28" x="768" y="2672" name="I3(3:0)" orien="R180" />
        <instance x="3504" y="1120" name="XLXI_23" orien="R0" />
        <instance x="3552" y="3280" name="XLXI_25" orien="R0" />
        <instance x="3536" y="2544" name="XLXI_26" orien="R0" />
        <instance x="3520" y="1808" name="XLXI_24" orien="R0" />
        <branch name="XLXN_59">
            <wire x2="3504" y1="752" y2="752" x1="3008" />
            <wire x2="3504" y1="752" y2="864" x1="3504" />
        </branch>
        <branch name="XLXN_60">
            <wire x2="3280" y1="912" y2="912" x1="3072" />
            <wire x2="3280" y1="912" y2="928" x1="3280" />
            <wire x2="3504" y1="928" y2="928" x1="3280" />
        </branch>
        <branch name="XLXN_61">
            <wire x2="3312" y1="1072" y2="1072" x1="3120" />
            <wire x2="3312" y1="992" y2="1072" x1="3312" />
            <wire x2="3504" y1="992" y2="992" x1="3312" />
        </branch>
        <branch name="XLXN_62">
            <wire x2="3504" y1="1216" y2="1216" x1="3136" />
            <wire x2="3504" y1="1056" y2="1216" x1="3504" />
        </branch>
        <branch name="XLXN_63">
            <wire x2="3520" y1="1456" y2="1456" x1="3088" />
            <wire x2="3520" y1="1456" y2="1552" x1="3520" />
        </branch>
        <branch name="XLXN_64">
            <wire x2="3520" y1="1616" y2="1616" x1="3120" />
        </branch>
        <branch name="XLXN_65">
            <wire x2="3328" y1="1776" y2="1776" x1="3136" />
            <wire x2="3328" y1="1680" y2="1776" x1="3328" />
            <wire x2="3520" y1="1680" y2="1680" x1="3328" />
        </branch>
        <branch name="XLXN_66">
            <wire x2="3520" y1="1920" y2="1920" x1="3104" />
            <wire x2="3520" y1="1744" y2="1920" x1="3520" />
        </branch>
        <branch name="XLXN_67">
            <wire x2="3536" y1="2176" y2="2176" x1="3216" />
            <wire x2="3536" y1="2176" y2="2288" x1="3536" />
        </branch>
        <branch name="XLXN_68">
            <wire x2="3376" y1="2336" y2="2336" x1="3216" />
            <wire x2="3376" y1="2336" y2="2352" x1="3376" />
            <wire x2="3536" y1="2352" y2="2352" x1="3376" />
        </branch>
        <branch name="XLXN_69">
            <wire x2="3392" y1="2496" y2="2496" x1="3264" />
            <wire x2="3392" y1="2416" y2="2496" x1="3392" />
            <wire x2="3536" y1="2416" y2="2416" x1="3392" />
        </branch>
        <branch name="XLXN_70">
            <wire x2="3536" y1="2640" y2="2640" x1="3232" />
            <wire x2="3536" y1="2480" y2="2640" x1="3536" />
        </branch>
        <branch name="XLXN_71">
            <wire x2="3552" y1="2896" y2="2896" x1="3296" />
            <wire x2="3552" y1="2896" y2="3024" x1="3552" />
        </branch>
        <branch name="XLXN_73">
            <wire x2="3424" y1="3056" y2="3056" x1="3296" />
            <wire x2="3424" y1="3056" y2="3088" x1="3424" />
            <wire x2="3552" y1="3088" y2="3088" x1="3424" />
        </branch>
        <branch name="XLXN_74">
            <wire x2="3424" y1="3216" y2="3216" x1="3312" />
            <wire x2="3424" y1="3152" y2="3216" x1="3424" />
            <wire x2="3552" y1="3152" y2="3152" x1="3424" />
        </branch>
        <branch name="XLXN_75">
            <wire x2="3552" y1="3360" y2="3360" x1="3312" />
            <wire x2="3552" y1="3216" y2="3360" x1="3552" />
        </branch>
        <branch name="O(3:0)">
            <wire x2="3968" y1="2368" y2="2384" x1="3968" />
            <wire x2="4032" y1="2384" y2="2384" x1="3968" />
            <wire x2="4032" y1="2384" y2="3120" x1="4032" />
            <wire x2="3984" y1="1632" y2="1648" x1="3984" />
            <wire x2="4032" y1="1648" y2="1648" x1="3984" />
            <wire x2="4032" y1="1648" y2="2032" x1="4032" />
            <wire x2="4480" y1="2032" y2="2032" x1="4032" />
            <wire x2="4032" y1="2032" y2="2384" x1="4032" />
            <wire x2="3984" y1="3104" y2="3120" x1="3984" />
            <wire x2="4032" y1="3120" y2="3120" x1="3984" />
            <wire x2="4000" y1="944" y2="960" x1="4000" />
            <wire x2="4032" y1="960" y2="960" x1="4000" />
            <wire x2="4032" y1="960" y2="1648" x1="4032" />
        </branch>
        <iomarker fontsize="28" x="4480" y="2032" name="O(3:0)" orien="R0" />
        <bustap x2="3888" y1="3120" y2="3120" x1="3984" />
        <bustap x2="3872" y1="2384" y2="2384" x1="3968" />
        <bustap x2="3888" y1="1648" y2="1648" x1="3984" />
        <bustap x2="3904" y1="960" y2="960" x1="4000" />
        <branch name="O(0)">
            <wire x2="3904" y1="960" y2="960" x1="3760" />
        </branch>
        <branch name="O(1)">
            <wire x2="3888" y1="1648" y2="1648" x1="3776" />
        </branch>
        <branch name="O(2)">
            <wire x2="3872" y1="2384" y2="2384" x1="3792" />
        </branch>
        <branch name="O(3)">
            <wire x2="3888" y1="3120" y2="3120" x1="3808" />
        </branch>
    </sheet>
</drawing>