<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="LE" />
        <signal name="point" />
        <signal name="Dp" />
        <signal name="XLXN_5" />
        <signal name="XLXN_6" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="XLXN_9" />
        <signal name="XLXN_10" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14" />
        <signal name="XLXN_19" />
        <signal name="XLXN_21" />
        <signal name="XLXN_22" />
        <signal name="XLXN_23" />
        <signal name="XLXN_24" />
        <signal name="XLXN_25" />
        <signal name="XLXN_36" />
        <signal name="XLXN_37" />
        <signal name="XLXN_38" />
        <signal name="XLXN_39" />
        <signal name="XLXN_40" />
        <signal name="XLXN_41" />
        <signal name="XLXN_42" />
        <signal name="XLXN_43" />
        <signal name="XLXN_46" />
        <signal name="XLXN_51" />
        <signal name="XLXN_52" />
        <signal name="D0" />
        <signal name="D1" />
        <signal name="D2" />
        <signal name="D3" />
        <signal name="XLXN_50" />
        <signal name="XLXN_69" />
        <signal name="XLXN_73" />
        <signal name="XLXN_79" />
        <signal name="XLXN_83" />
        <signal name="G" />
        <signal name="F" />
        <signal name="E" />
        <signal name="D" />
        <signal name="C" />
        <signal name="B" />
        <signal name="A" />
        <port polarity="Input" name="LE" />
        <port polarity="Input" name="point" />
        <port polarity="Output" name="Dp" />
        <port polarity="Input" name="D0" />
        <port polarity="Input" name="D1" />
        <port polarity="Input" name="D2" />
        <port polarity="Input" name="D3" />
        <port polarity="Output" name="G" />
        <port polarity="Output" name="F" />
        <port polarity="Output" name="E" />
        <port polarity="Output" name="D" />
        <port polarity="Output" name="C" />
        <port polarity="Output" name="B" />
        <port polarity="Output" name="A" />
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="or3">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="48" y1="-64" y2="-64" x1="0" />
            <line x2="72" y1="-128" y2="-128" x1="0" />
            <line x2="48" y1="-192" y2="-192" x1="0" />
            <line x2="192" y1="-128" y2="-128" x1="256" />
            <arc ex="192" ey="-128" sx="112" sy="-80" r="88" cx="116" cy="-168" />
            <arc ex="48" ey="-176" sx="48" sy="-80" r="56" cx="16" cy="-128" />
            <line x2="48" y1="-64" y2="-80" x1="48" />
            <line x2="48" y1="-192" y2="-176" x1="48" />
            <line x2="48" y1="-80" y2="-80" x1="112" />
            <arc ex="112" ey="-176" sx="192" sy="-128" r="88" cx="116" cy="-88" />
            <line x2="48" y1="-176" y2="-176" x1="112" />
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
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <blockdef name="and4">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-112" y2="-112" x1="144" />
            <arc ex="144" ey="-208" sx="144" sy="-112" r="48" cx="144" cy="-160" />
            <line x2="144" y1="-208" y2="-208" x1="64" />
            <line x2="64" y1="-64" y2="-256" x1="64" />
            <line x2="192" y1="-160" y2="-160" x1="256" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-64" y2="-64" x1="0" />
        </blockdef>
        <blockdef name="and3">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="192" y1="-128" y2="-128" x1="256" />
            <line x2="144" y1="-176" y2="-176" x1="64" />
            <line x2="64" y1="-80" y2="-80" x1="144" />
            <arc ex="144" ey="-176" sx="144" sy="-80" r="48" cx="144" cy="-128" />
            <line x2="64" y1="-64" y2="-192" x1="64" />
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
        <block symbolname="inv" name="XLXI_5">
            <blockpin signalname="point" name="I" />
            <blockpin signalname="Dp" name="O" />
        </block>
        <block symbolname="or3" name="Ag">
            <blockpin signalname="XLXN_13" name="I0" />
            <blockpin signalname="XLXN_12" name="I1" />
            <blockpin signalname="XLXN_14" name="I2" />
            <blockpin signalname="XLXN_5" name="O" />
        </block>
        <block symbolname="or3" name="Ae">
            <blockpin signalname="XLXN_23" name="I0" />
            <blockpin signalname="XLXN_24" name="I1" />
            <blockpin signalname="XLXN_25" name="I2" />
            <blockpin signalname="XLXN_7" name="O" />
        </block>
        <block symbolname="or3" name="Ac">
            <blockpin signalname="XLXN_38" name="I0" />
            <blockpin signalname="XLXN_39" name="I1" />
            <blockpin signalname="XLXN_41" name="I2" />
            <blockpin signalname="XLXN_9" name="O" />
        </block>
        <block symbolname="or4" name="Aa">
            <blockpin signalname="XLXN_46" name="I0" />
            <blockpin signalname="XLXN_50" name="I1" />
            <blockpin signalname="XLXN_51" name="I2" />
            <blockpin signalname="XLXN_52" name="I3" />
            <blockpin signalname="XLXN_11" name="O" />
        </block>
        <block symbolname="or4" name="Ad">
            <blockpin signalname="XLXN_36" name="I0" />
            <blockpin signalname="XLXN_37" name="I1" />
            <blockpin signalname="XLXN_51" name="I2" />
            <blockpin signalname="XLXN_52" name="I3" />
            <blockpin signalname="XLXN_8" name="O" />
        </block>
        <block symbolname="or4" name="Ab">
            <blockpin signalname="XLXN_40" name="I0" />
            <blockpin signalname="XLXN_41" name="I1" />
            <blockpin signalname="XLXN_42" name="I2" />
            <blockpin signalname="XLXN_43" name="I3" />
            <blockpin signalname="XLXN_10" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_15">
            <blockpin signalname="LE" name="I0" />
            <blockpin signalname="XLXN_5" name="I1" />
            <blockpin signalname="G" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_16">
            <blockpin signalname="LE" name="I0" />
            <blockpin signalname="XLXN_6" name="I1" />
            <blockpin signalname="F" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_17">
            <blockpin signalname="LE" name="I0" />
            <blockpin signalname="XLXN_7" name="I1" />
            <blockpin signalname="E" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_18">
            <blockpin signalname="LE" name="I0" />
            <blockpin signalname="XLXN_8" name="I1" />
            <blockpin signalname="D" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_19">
            <blockpin signalname="LE" name="I0" />
            <blockpin signalname="XLXN_9" name="I1" />
            <blockpin signalname="C" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_20">
            <blockpin signalname="LE" name="I0" />
            <blockpin signalname="XLXN_10" name="I1" />
            <blockpin signalname="B" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_21">
            <blockpin signalname="LE" name="I0" />
            <blockpin signalname="XLXN_11" name="I1" />
            <blockpin signalname="A" name="O" />
        </block>
        <block symbolname="or4" name="Af">
            <blockpin signalname="XLXN_22" name="I0" />
            <blockpin signalname="XLXN_19" name="I1" />
            <blockpin signalname="XLXN_21" name="I2" />
            <blockpin signalname="XLXN_50" name="I3" />
            <blockpin signalname="XLXN_6" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_23">
            <blockpin signalname="XLXN_69" name="I0" />
            <blockpin signalname="XLXN_73" name="I1" />
            <blockpin signalname="D2" name="I2" />
            <blockpin signalname="D3" name="I3" />
            <blockpin signalname="XLXN_13" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_24">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="D1" name="I1" />
            <blockpin signalname="D2" name="I2" />
            <blockpin signalname="XLXN_83" name="I3" />
            <blockpin signalname="XLXN_12" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_25">
            <blockpin signalname="XLXN_83" name="I0" />
            <blockpin signalname="XLXN_73" name="I1" />
            <blockpin signalname="XLXN_79" name="I2" />
            <blockpin signalname="XLXN_14" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_26">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="D1" name="I1" />
            <blockpin signalname="XLXN_83" name="I2" />
            <blockpin signalname="XLXN_22" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_27">
            <blockpin signalname="XLXN_79" name="I0" />
            <blockpin signalname="D1" name="I1" />
            <blockpin signalname="XLXN_83" name="I2" />
            <blockpin signalname="XLXN_19" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_28">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="XLXN_79" name="I1" />
            <blockpin signalname="XLXN_83" name="I2" />
            <blockpin signalname="XLXN_21" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_29">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="XLXN_73" name="I1" />
            <blockpin signalname="XLXN_79" name="I2" />
            <blockpin signalname="XLXN_23" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_30">
            <blockpin signalname="D2" name="I0" />
            <blockpin signalname="XLXN_73" name="I1" />
            <blockpin signalname="XLXN_83" name="I2" />
            <blockpin signalname="XLXN_24" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_33">
            <blockpin signalname="D1" name="I0" />
            <blockpin signalname="D2" name="I1" />
            <blockpin signalname="D0" name="I2" />
            <blockpin signalname="XLXN_37" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_34">
            <blockpin signalname="D1" name="I0" />
            <blockpin signalname="D3" name="I1" />
            <blockpin signalname="D2" name="I2" />
            <blockpin signalname="XLXN_38" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_36">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="D1" name="I1" />
            <blockpin signalname="D3" name="I2" />
            <blockpin signalname="XLXN_40" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_37">
            <blockpin signalname="XLXN_69" name="I0" />
            <blockpin signalname="D3" name="I1" />
            <blockpin signalname="D2" name="I2" />
            <blockpin signalname="XLXN_41" name="O" />
        </block>
        <block symbolname="and3" name="XLXI_38">
            <blockpin signalname="XLXN_69" name="I0" />
            <blockpin signalname="D1" name="I1" />
            <blockpin signalname="D2" name="I2" />
            <blockpin signalname="XLXN_42" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_44">
            <blockpin signalname="D1" name="I" />
            <blockpin signalname="XLXN_73" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_45">
            <blockpin signalname="D2" name="I" />
            <blockpin signalname="XLXN_79" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_46">
            <blockpin signalname="D3" name="I" />
            <blockpin signalname="XLXN_83" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_47">
            <blockpin signalname="D0" name="I" />
            <blockpin signalname="XLXN_69" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_48">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="XLXN_83" name="I1" />
            <blockpin signalname="XLXN_25" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_49">
            <blockpin signalname="XLXN_69" name="I0" />
            <blockpin signalname="XLXN_79" name="I1" />
            <blockpin signalname="D3" name="I2" />
            <blockpin signalname="D1" name="I3" />
            <blockpin signalname="XLXN_36" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_50">
            <blockpin signalname="XLXN_83" name="I0" />
            <blockpin signalname="XLXN_69" name="I1" />
            <blockpin signalname="D1" name="I2" />
            <blockpin signalname="XLXN_79" name="I3" />
            <blockpin signalname="XLXN_39" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_51">
            <blockpin signalname="XLXN_73" name="I0" />
            <blockpin signalname="D0" name="I1" />
            <blockpin signalname="D2" name="I2" />
            <blockpin signalname="XLXN_83" name="I3" />
            <blockpin signalname="XLXN_43" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_52">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="D1" name="I1" />
            <blockpin signalname="XLXN_79" name="I2" />
            <blockpin signalname="D3" name="I3" />
            <blockpin signalname="XLXN_46" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_54">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="D2" name="I1" />
            <blockpin signalname="XLXN_73" name="I2" />
            <blockpin signalname="D3" name="I3" />
            <blockpin signalname="XLXN_50" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_55">
            <blockpin signalname="D2" name="I0" />
            <blockpin signalname="XLXN_69" name="I1" />
            <blockpin signalname="XLXN_73" name="I2" />
            <blockpin signalname="XLXN_83" name="I3" />
            <blockpin signalname="XLXN_51" name="O" />
        </block>
        <block symbolname="and4" name="XLXI_56">
            <blockpin signalname="D0" name="I0" />
            <blockpin signalname="XLXN_83" name="I1" />
            <blockpin signalname="XLXN_79" name="I2" />
            <blockpin signalname="XLXN_73" name="I3" />
            <blockpin signalname="XLXN_52" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5440" height="3520">
        <branch name="point">
            <wire x2="224" y1="192" y2="1008" x1="224" />
        </branch>
        <iomarker fontsize="28" x="144" y="192" name="LE" orien="R270" />
        <iomarker fontsize="28" x="224" y="192" name="point" orien="R270" />
        <instance x="192" y="1008" name="XLXI_5" orien="R90" />
        <branch name="Dp">
            <wire x2="224" y1="1232" y2="2544" x1="224" />
        </branch>
        <iomarker fontsize="28" x="224" y="2544" name="Dp" orien="R90" />
        <instance x="544" y="2352" name="XLXI_15" orien="R90" />
        <instance x="1568" y="2352" name="XLXI_17" orien="R90" />
        <branch name="XLXN_5">
            <wire x2="672" y1="2144" y2="2352" x1="672" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="1696" y1="2144" y2="2352" x1="1696" />
        </branch>
        <instance x="544" y="1888" name="Ag" orien="R90">
            <attrtext style="alignment:VLEFT;fontsize:28;fontname:Arial" attrname="InstName" x="256" y="-8" type="instance" />
        </instance>
        <branch name="XLXN_12">
            <wire x2="672" y1="1856" y2="1888" x1="672" />
        </branch>
        <instance x="512" y="1600" name="XLXI_24" orien="R90" />
        <instance x="752" y="1600" name="XLXI_25" orien="R90" />
        <instance x="272" y="1600" name="XLXI_23" orien="R90" />
        <branch name="XLXN_13">
            <wire x2="432" y1="1856" y2="1888" x1="432" />
            <wire x2="608" y1="1888" y2="1888" x1="432" />
        </branch>
        <branch name="XLXN_14">
            <wire x2="880" y1="1888" y2="1888" x1="736" />
            <wire x2="880" y1="1856" y2="1888" x1="880" />
        </branch>
        <instance x="1184" y="2352" name="XLXI_16" orien="R90" />
        <branch name="LE">
            <wire x2="144" y1="192" y2="2176" x1="144" />
            <wire x2="608" y1="2176" y2="2176" x1="144" />
            <wire x2="608" y1="2176" y2="2352" x1="608" />
            <wire x2="1248" y1="2176" y2="2176" x1="608" />
            <wire x2="1632" y1="2176" y2="2176" x1="1248" />
            <wire x2="1632" y1="2176" y2="2352" x1="1632" />
            <wire x2="2304" y1="2176" y2="2176" x1="1632" />
            <wire x2="2304" y1="2176" y2="2368" x1="2304" />
            <wire x2="2800" y1="2176" y2="2176" x1="2304" />
            <wire x2="2800" y1="2176" y2="2352" x1="2800" />
            <wire x2="3376" y1="2176" y2="2176" x1="2800" />
            <wire x2="3376" y1="2176" y2="2352" x1="3376" />
            <wire x2="4208" y1="2176" y2="2176" x1="3376" />
            <wire x2="4208" y1="2176" y2="2336" x1="4208" />
            <wire x2="1248" y1="2176" y2="2352" x1="1248" />
        </branch>
        <instance x="928" y="1600" name="XLXI_26" orien="R90" />
        <instance x="1104" y="1600" name="XLXI_27" orien="R90" />
        <instance x="1280" y="1600" name="XLXI_28" orien="R90" />
        <branch name="XLXN_6">
            <wire x2="1312" y1="2160" y2="2352" x1="1312" />
        </branch>
        <instance x="1152" y="1904" name="Af" orien="R90">
            <attrtext style="alignment:VLEFT;fontsize:28;fontname:Arial" attrname="InstName" x="256" y="-8" type="instance" />
        </instance>
        <branch name="XLXN_19">
            <wire x2="1232" y1="1856" y2="1872" x1="1232" />
            <wire x2="1280" y1="1872" y2="1872" x1="1232" />
            <wire x2="1280" y1="1872" y2="1904" x1="1280" />
        </branch>
        <branch name="XLXN_21">
            <wire x2="1344" y1="1872" y2="1904" x1="1344" />
            <wire x2="1408" y1="1872" y2="1872" x1="1344" />
            <wire x2="1408" y1="1856" y2="1872" x1="1408" />
        </branch>
        <branch name="XLXN_22">
            <wire x2="1056" y1="1856" y2="1904" x1="1056" />
            <wire x2="1216" y1="1904" y2="1904" x1="1056" />
        </branch>
        <branch name="XLXN_23">
            <wire x2="1632" y1="1808" y2="1888" x1="1632" />
        </branch>
        <instance x="1568" y="1888" name="Ae" orien="R90">
            <attrtext style="alignment:VLEFT;fontsize:28;fontname:Arial" attrname="InstName" x="256" y="-8" type="instance" />
        </instance>
        <instance x="2208" y="1872" name="Ad" orien="R90">
            <attrtext style="alignment:VLEFT;fontsize:28;fontname:Arial" attrname="InstName" x="256" y="-8" type="instance" />
        </instance>
        <branch name="XLXN_8">
            <wire x2="2368" y1="2128" y2="2368" x1="2368" />
        </branch>
        <instance x="2240" y="2368" name="XLXI_18" orien="R90" />
        <instance x="2736" y="1856" name="Ac" orien="R90">
            <attrtext style="alignment:VLEFT;fontsize:28;fontname:Arial" attrname="InstName" x="256" y="-8" type="instance" />
        </instance>
        <branch name="XLXN_9">
            <wire x2="2864" y1="2112" y2="2352" x1="2864" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="3440" y1="2128" y2="2352" x1="3440" />
        </branch>
        <instance x="3312" y="2352" name="XLXI_20" orien="R90" />
        <instance x="2736" y="2352" name="XLXI_19" orien="R90" />
        <instance x="1504" y="1552" name="XLXI_29" orien="R90" />
        <instance x="1680" y="1552" name="XLXI_30" orien="R90" />
        <branch name="XLXN_24">
            <wire x2="1808" y1="1840" y2="1840" x1="1696" />
            <wire x2="1696" y1="1840" y2="1888" x1="1696" />
            <wire x2="1808" y1="1808" y2="1840" x1="1808" />
        </branch>
        <instance x="2208" y="1552" name="XLXI_33" orien="R90" />
        <branch name="XLXN_36">
            <wire x2="2160" y1="1776" y2="1872" x1="2160" />
            <wire x2="2272" y1="1872" y2="1872" x1="2160" />
        </branch>
        <branch name="XLXN_37">
            <wire x2="2336" y1="1808" y2="1872" x1="2336" />
        </branch>
        <instance x="2544" y="1552" name="XLXI_34" orien="R90" />
        <branch name="XLXN_38">
            <wire x2="2672" y1="1808" y2="1856" x1="2672" />
            <wire x2="2800" y1="1856" y2="1856" x1="2672" />
        </branch>
        <branch name="XLXN_39">
            <wire x2="2864" y1="1792" y2="1856" x1="2864" />
        </branch>
        <instance x="3056" y="1536" name="XLXI_36" orien="R90" />
        <instance x="3232" y="1536" name="XLXI_37" orien="R90" />
        <instance x="3408" y="1536" name="XLXI_38" orien="R90" />
        <branch name="XLXN_43">
            <wire x2="3712" y1="1872" y2="1872" x1="3536" />
            <wire x2="3712" y1="1792" y2="1872" x1="3712" />
        </branch>
        <instance x="4112" y="1856" name="Aa" orien="R90">
            <attrtext style="alignment:VLEFT;fontsize:28;fontname:Arial" attrname="InstName" x="256" y="-8" type="instance" />
        </instance>
        <branch name="XLXN_11">
            <wire x2="4272" y1="2112" y2="2336" x1="4272" />
        </branch>
        <instance x="4144" y="2336" name="XLXI_21" orien="R90" />
        <branch name="XLXN_46">
            <wire x2="3952" y1="1792" y2="1856" x1="3952" />
            <wire x2="4176" y1="1856" y2="1856" x1="3952" />
        </branch>
        <branch name="XLXN_41">
            <wire x2="3408" y1="1856" y2="1856" x1="2928" />
            <wire x2="3408" y1="1856" y2="1872" x1="3408" />
            <wire x2="3408" y1="1792" y2="1792" x1="3360" />
            <wire x2="3408" y1="1792" y2="1856" x1="3408" />
        </branch>
        <branch name="XLXN_51">
            <wire x2="2400" y1="1824" y2="1872" x1="2400" />
            <wire x2="4304" y1="1824" y2="1824" x1="2400" />
            <wire x2="4304" y1="1824" y2="1856" x1="4304" />
            <wire x2="4432" y1="1824" y2="1824" x1="4304" />
            <wire x2="4432" y1="1792" y2="1824" x1="4432" />
        </branch>
        <branch name="XLXN_52">
            <wire x2="4368" y1="1840" y2="1840" x1="2464" />
            <wire x2="4368" y1="1840" y2="1856" x1="4368" />
            <wire x2="4672" y1="1840" y2="1840" x1="4368" />
            <wire x2="2464" y1="1840" y2="1872" x1="2464" />
            <wire x2="4672" y1="1792" y2="1840" x1="4672" />
        </branch>
        <instance x="3280" y="1872" name="Ab" orien="R90">
            <attrtext style="alignment:VLEFT;fontsize:28;fontname:Arial" attrname="InstName" x="256" y="-8" type="instance" />
        </instance>
        <branch name="XLXN_40">
            <wire x2="3200" y1="1792" y2="1792" x1="3184" />
            <wire x2="3200" y1="1792" y2="1872" x1="3200" />
            <wire x2="3344" y1="1872" y2="1872" x1="3200" />
        </branch>
        <branch name="XLXN_42">
            <wire x2="3472" y1="1792" y2="1872" x1="3472" />
            <wire x2="3536" y1="1792" y2="1792" x1="3472" />
        </branch>
        <instance x="3024" y="400" name="XLXI_47" orien="R90" />
        <instance x="4080" y="432" name="XLXI_45" orien="R90" />
        <instance x="4528" y="432" name="XLXI_46" orien="R90" />
        <iomarker fontsize="28" x="3056" y="256" name="D0" orien="R270" />
        <iomarker fontsize="28" x="4112" y="240" name="D2" orien="R270" />
        <iomarker fontsize="28" x="4560" y="240" name="D3" orien="R270" />
        <branch name="XLXN_50">
            <wire x2="1520" y1="1904" y2="1904" x1="1408" />
            <wire x2="1520" y1="1808" y2="1904" x1="1520" />
            <wire x2="4192" y1="1808" y2="1808" x1="1520" />
            <wire x2="4240" y1="1808" y2="1808" x1="4192" />
            <wire x2="4240" y1="1808" y2="1856" x1="4240" />
            <wire x2="4192" y1="1792" y2="1808" x1="4192" />
        </branch>
        <branch name="XLXN_25">
            <wire x2="1760" y1="1872" y2="1888" x1="1760" />
            <wire x2="1984" y1="1872" y2="1872" x1="1760" />
            <wire x2="1984" y1="1776" y2="1872" x1="1984" />
        </branch>
        <instance x="1888" y="1520" name="XLXI_48" orien="R90" />
        <branch name="D0">
            <wire x2="576" y1="864" y2="1600" x1="576" />
            <wire x2="992" y1="864" y2="864" x1="576" />
            <wire x2="992" y1="864" y2="1600" x1="992" />
            <wire x2="1344" y1="864" y2="864" x1="992" />
            <wire x2="1344" y1="864" y2="1600" x1="1344" />
            <wire x2="1568" y1="864" y2="864" x1="1344" />
            <wire x2="1568" y1="864" y2="1552" x1="1568" />
            <wire x2="1952" y1="864" y2="864" x1="1568" />
            <wire x2="1952" y1="864" y2="1520" x1="1952" />
            <wire x2="2400" y1="864" y2="864" x1="1952" />
            <wire x2="2400" y1="864" y2="1552" x1="2400" />
            <wire x2="2784" y1="864" y2="864" x1="2400" />
            <wire x2="3120" y1="864" y2="864" x1="2784" />
            <wire x2="3120" y1="864" y2="1536" x1="3120" />
            <wire x2="3680" y1="864" y2="864" x1="3120" />
            <wire x2="3680" y1="864" y2="1536" x1="3680" />
            <wire x2="3856" y1="864" y2="864" x1="3680" />
            <wire x2="3856" y1="864" y2="1536" x1="3856" />
            <wire x2="4096" y1="864" y2="864" x1="3856" />
            <wire x2="4096" y1="864" y2="1536" x1="4096" />
            <wire x2="4576" y1="864" y2="864" x1="4096" />
            <wire x2="4576" y1="864" y2="1536" x1="4576" />
            <wire x2="3056" y1="336" y2="336" x1="2784" />
            <wire x2="3056" y1="336" y2="400" x1="3056" />
            <wire x2="2784" y1="336" y2="864" x1="2784" />
            <wire x2="3056" y1="256" y2="336" x1="3056" />
        </branch>
        <instance x="2000" y="1520" name="XLXI_49" orien="R90" />
        <instance x="2704" y="1536" name="XLXI_50" orien="R90" />
        <instance x="3552" y="1536" name="XLXI_51" orien="R90" />
        <instance x="3792" y="1536" name="XLXI_52" orien="R90" />
        <instance x="4032" y="1536" name="XLXI_54" orien="R90" />
        <instance x="4272" y="1536" name="XLXI_55" orien="R90" />
        <instance x="4512" y="1536" name="XLXI_56" orien="R90" />
        <branch name="XLXN_69">
            <wire x2="2064" y1="896" y2="896" x1="336" />
            <wire x2="2832" y1="896" y2="896" x1="2064" />
            <wire x2="2832" y1="896" y2="1536" x1="2832" />
            <wire x2="3056" y1="896" y2="896" x1="2832" />
            <wire x2="3296" y1="896" y2="896" x1="3056" />
            <wire x2="3472" y1="896" y2="896" x1="3296" />
            <wire x2="4400" y1="896" y2="896" x1="3472" />
            <wire x2="4400" y1="896" y2="1536" x1="4400" />
            <wire x2="3472" y1="896" y2="1536" x1="3472" />
            <wire x2="3296" y1="896" y2="1536" x1="3296" />
            <wire x2="2064" y1="896" y2="1520" x1="2064" />
            <wire x2="336" y1="896" y2="1600" x1="336" />
            <wire x2="3056" y1="624" y2="896" x1="3056" />
        </branch>
        <branch name="D1">
            <wire x2="640" y1="960" y2="1600" x1="640" />
            <wire x2="1056" y1="960" y2="960" x1="640" />
            <wire x2="1056" y1="960" y2="1600" x1="1056" />
            <wire x2="1232" y1="960" y2="960" x1="1056" />
            <wire x2="1232" y1="960" y2="1600" x1="1232" />
            <wire x2="2256" y1="960" y2="960" x1="1232" />
            <wire x2="2256" y1="960" y2="1520" x1="2256" />
            <wire x2="2272" y1="960" y2="960" x1="2256" />
            <wire x2="2608" y1="960" y2="960" x1="2272" />
            <wire x2="2896" y1="960" y2="960" x1="2608" />
            <wire x2="3184" y1="960" y2="960" x1="2896" />
            <wire x2="3504" y1="960" y2="960" x1="3184" />
            <wire x2="3536" y1="960" y2="960" x1="3504" />
            <wire x2="3920" y1="960" y2="960" x1="3536" />
            <wire x2="3920" y1="960" y2="1536" x1="3920" />
            <wire x2="3536" y1="960" y2="1536" x1="3536" />
            <wire x2="3184" y1="960" y2="1536" x1="3184" />
            <wire x2="2896" y1="960" y2="1536" x1="2896" />
            <wire x2="2608" y1="960" y2="1552" x1="2608" />
            <wire x2="2272" y1="960" y2="1552" x1="2272" />
            <wire x2="3504" y1="352" y2="960" x1="3504" />
            <wire x2="3696" y1="352" y2="352" x1="3504" />
            <wire x2="3696" y1="352" y2="416" x1="3696" />
            <wire x2="3696" y1="224" y2="352" x1="3696" />
        </branch>
        <instance x="3664" y="416" name="XLXI_44" orien="R90" />
        <branch name="XLXN_73">
            <wire x2="400" y1="1040" y2="1600" x1="400" />
            <wire x2="880" y1="1040" y2="1040" x1="400" />
            <wire x2="1632" y1="1040" y2="1040" x1="880" />
            <wire x2="1632" y1="1040" y2="1552" x1="1632" />
            <wire x2="1808" y1="1040" y2="1040" x1="1632" />
            <wire x2="3616" y1="1040" y2="1040" x1="1808" />
            <wire x2="3696" y1="1040" y2="1040" x1="3616" />
            <wire x2="4224" y1="1040" y2="1040" x1="3696" />
            <wire x2="4464" y1="1040" y2="1040" x1="4224" />
            <wire x2="4464" y1="1040" y2="1536" x1="4464" />
            <wire x2="4768" y1="1040" y2="1040" x1="4464" />
            <wire x2="4768" y1="1040" y2="1536" x1="4768" />
            <wire x2="4224" y1="1040" y2="1536" x1="4224" />
            <wire x2="3616" y1="1040" y2="1536" x1="3616" />
            <wire x2="1808" y1="1040" y2="1552" x1="1808" />
            <wire x2="880" y1="1040" y2="1600" x1="880" />
            <wire x2="3696" y1="640" y2="1040" x1="3696" />
        </branch>
        <iomarker fontsize="28" x="3696" y="224" name="D1" orien="R270" />
        <branch name="D2">
            <wire x2="464" y1="1136" y2="1600" x1="464" />
            <wire x2="704" y1="1136" y2="1136" x1="464" />
            <wire x2="1744" y1="1136" y2="1136" x1="704" />
            <wire x2="2336" y1="1136" y2="1136" x1="1744" />
            <wire x2="2736" y1="1136" y2="1136" x1="2336" />
            <wire x2="3424" y1="1136" y2="1136" x1="2736" />
            <wire x2="3424" y1="1136" y2="1536" x1="3424" />
            <wire x2="3600" y1="1136" y2="1136" x1="3424" />
            <wire x2="3600" y1="1136" y2="1536" x1="3600" />
            <wire x2="3744" y1="1136" y2="1136" x1="3600" />
            <wire x2="3952" y1="1136" y2="1136" x1="3744" />
            <wire x2="4160" y1="1136" y2="1136" x1="3952" />
            <wire x2="4160" y1="1136" y2="1536" x1="4160" />
            <wire x2="4336" y1="1136" y2="1136" x1="4160" />
            <wire x2="4336" y1="1136" y2="1536" x1="4336" />
            <wire x2="3744" y1="1136" y2="1536" x1="3744" />
            <wire x2="2736" y1="1136" y2="1552" x1="2736" />
            <wire x2="2336" y1="1136" y2="1552" x1="2336" />
            <wire x2="1744" y1="1136" y2="1552" x1="1744" />
            <wire x2="704" y1="1136" y2="1600" x1="704" />
            <wire x2="4112" y1="352" y2="352" x1="3952" />
            <wire x2="4112" y1="352" y2="432" x1="4112" />
            <wire x2="3952" y1="352" y2="1136" x1="3952" />
            <wire x2="4112" y1="240" y2="352" x1="4112" />
        </branch>
        <branch name="XLXN_79">
            <wire x2="1168" y1="1216" y2="1216" x1="944" />
            <wire x2="1168" y1="1216" y2="1600" x1="1168" />
            <wire x2="1408" y1="1216" y2="1216" x1="1168" />
            <wire x2="1696" y1="1216" y2="1216" x1="1408" />
            <wire x2="2128" y1="1216" y2="1216" x1="1696" />
            <wire x2="2960" y1="1216" y2="1216" x1="2128" />
            <wire x2="3984" y1="1216" y2="1216" x1="2960" />
            <wire x2="4112" y1="1216" y2="1216" x1="3984" />
            <wire x2="4704" y1="1216" y2="1216" x1="4112" />
            <wire x2="4704" y1="1216" y2="1536" x1="4704" />
            <wire x2="3984" y1="1216" y2="1536" x1="3984" />
            <wire x2="2960" y1="1216" y2="1536" x1="2960" />
            <wire x2="2128" y1="1216" y2="1520" x1="2128" />
            <wire x2="1696" y1="1216" y2="1552" x1="1696" />
            <wire x2="1408" y1="1216" y2="1600" x1="1408" />
            <wire x2="944" y1="1216" y2="1600" x1="944" />
            <wire x2="4112" y1="656" y2="1216" x1="4112" />
        </branch>
        <branch name="D3">
            <wire x2="2192" y1="1328" y2="1328" x1="528" />
            <wire x2="2672" y1="1328" y2="1328" x1="2192" />
            <wire x2="3248" y1="1328" y2="1328" x1="2672" />
            <wire x2="3248" y1="1328" y2="1536" x1="3248" />
            <wire x2="3360" y1="1328" y2="1328" x1="3248" />
            <wire x2="4048" y1="1328" y2="1328" x1="3360" />
            <wire x2="4048" y1="1328" y2="1536" x1="4048" />
            <wire x2="4288" y1="1328" y2="1328" x1="4048" />
            <wire x2="4288" y1="1328" y2="1536" x1="4288" />
            <wire x2="3360" y1="1328" y2="1536" x1="3360" />
            <wire x2="2672" y1="1328" y2="1552" x1="2672" />
            <wire x2="2192" y1="1328" y2="1520" x1="2192" />
            <wire x2="528" y1="1328" y2="1600" x1="528" />
            <wire x2="4288" y1="352" y2="1328" x1="4288" />
            <wire x2="4560" y1="352" y2="352" x1="4288" />
            <wire x2="4560" y1="352" y2="432" x1="4560" />
            <wire x2="4560" y1="240" y2="352" x1="4560" />
        </branch>
        <branch name="XLXN_83">
            <wire x2="768" y1="1424" y2="1600" x1="768" />
            <wire x2="816" y1="1424" y2="1424" x1="768" />
            <wire x2="1120" y1="1424" y2="1424" x1="816" />
            <wire x2="1120" y1="1424" y2="1600" x1="1120" />
            <wire x2="1296" y1="1424" y2="1424" x1="1120" />
            <wire x2="1296" y1="1424" y2="1600" x1="1296" />
            <wire x2="1472" y1="1424" y2="1424" x1="1296" />
            <wire x2="1872" y1="1424" y2="1424" x1="1472" />
            <wire x2="1872" y1="1424" y2="1552" x1="1872" />
            <wire x2="2016" y1="1424" y2="1424" x1="1872" />
            <wire x2="2768" y1="1424" y2="1424" x1="2016" />
            <wire x2="3808" y1="1424" y2="1424" x1="2768" />
            <wire x2="4528" y1="1424" y2="1424" x1="3808" />
            <wire x2="4560" y1="1424" y2="1424" x1="4528" />
            <wire x2="4640" y1="1424" y2="1424" x1="4560" />
            <wire x2="4640" y1="1424" y2="1536" x1="4640" />
            <wire x2="4528" y1="1424" y2="1536" x1="4528" />
            <wire x2="3808" y1="1424" y2="1536" x1="3808" />
            <wire x2="2768" y1="1424" y2="1536" x1="2768" />
            <wire x2="2016" y1="1424" y2="1520" x1="2016" />
            <wire x2="1472" y1="1424" y2="1600" x1="1472" />
            <wire x2="816" y1="1424" y2="1600" x1="816" />
            <wire x2="4560" y1="656" y2="1424" x1="4560" />
        </branch>
        <branch name="G">
            <wire x2="640" y1="2608" y2="2640" x1="640" />
        </branch>
        <iomarker fontsize="28" x="640" y="2640" name="G" orien="R90" />
        <branch name="F">
            <wire x2="1280" y1="2608" y2="2640" x1="1280" />
        </branch>
        <iomarker fontsize="28" x="1280" y="2640" name="F" orien="R90" />
        <branch name="E">
            <wire x2="1664" y1="2608" y2="2640" x1="1664" />
        </branch>
        <iomarker fontsize="28" x="1664" y="2640" name="E" orien="R90" />
        <branch name="D">
            <wire x2="2336" y1="2624" y2="2656" x1="2336" />
        </branch>
        <iomarker fontsize="28" x="2336" y="2656" name="D" orien="R90" />
        <branch name="C">
            <wire x2="2832" y1="2608" y2="2640" x1="2832" />
        </branch>
        <iomarker fontsize="28" x="2832" y="2640" name="C" orien="R90" />
        <branch name="B">
            <wire x2="3408" y1="2608" y2="2640" x1="3408" />
        </branch>
        <iomarker fontsize="28" x="3408" y="2640" name="B" orien="R90" />
        <branch name="A">
            <wire x2="4240" y1="2592" y2="2624" x1="4240" />
        </branch>
        <iomarker fontsize="28" x="4240" y="2624" name="A" orien="R90" />
    </sheet>
</drawing>