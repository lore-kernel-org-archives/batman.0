Return-Path: <nickthefarrow@hotmail.com>
Message-ID: <SNT107-W219839251043EFC1460468A60C0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_f1ad30b9-27b9-450a-ae72-099f62ed92c3_"
From: nick farrow <nickthefarrow@hotmail.com>
Date: Tue, 4 Aug 2009 15:59:24 +0000
In-Reply-To: <200908031821.22497.lindner_marek@yahoo.de>
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200907280020.06026.lindner_marek@yahoo.de>
	<OF82FBEF87.4CF60579-ONC1257603.002FC1DB-C1257603.004FD789@CHASCOM.INT>
	<200908031821.22497.lindner_marek@yahoo.de>
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Routing help?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

--_f1ad30b9-27b9-450a-ae72-099f62ed92c3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=2C

I have 3 linksys wrt54 flashed with openwrt 7.09=2C webif'ed and installed =
BATMAN 0.2-rv478.1=2C all OK I think.

I have arranged the 3 nodes such that node 1 can only see 2 =2C and  2 only=
  3=2C so no direct contact is available from 1 to 3 (except via the mesh)

I have not broken the br-lan configuration of these devices and assigned 17=
2.16.1.1/24 to node 1 172.16.1.2/24 to node 2 172.16.1.3/24 to node 3=2C so=
 I think that means all packets recvd on wl0 or eh0 are bridged.

I have a pc hooked into the lan port of node 3 From here I can ssh into nod=
e3 (via the ethernet) and into node2 via the wifi (but not .1)  Netstat -rn=
 on node  3 indicates that 172.16.1.1 (node1) is via 172.16.1.2 and this is=
 confirmed by the batman web if that shows .1 is reached via .2 - all great=
.

From the ssh prompt on .3 I can ping .2 with no loss and ping .1 with  ~ 6%=
 loss. However=2C if I try to ping .1 from the pc connected on the ethernet=
 port of .3 I get no route to host. Putting wireshark on the ethernet ifc s=
hows the arp going out but nothing coming back. Interestingly enough if I s=
sh into .3 and ping .1=2C with wireshark running on the ethernet of .3 Is s=
ee the outgoing ICMP but not the reply (which is there because the ping suc=
ceeds) . It seems as if the local host traffic is not truly bridged.

This is the first attempt so I might have some incorrect/missing config or =
done something stupid=2C any ideas would be welcome!

Thanks very much

nick

_________________________________________________________________
Windows Live Messenger: Celebrate 10 amazing years with free winks and emot=
icons.
http://clk.atdmt.com/UKM/go/157562755/direct/01/=

--_f1ad30b9-27b9-450a-ae72-099f62ed92c3_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Hi=2C<br><br>I have 3 linksys wrt54 flashed with openwrt 7.09=2C webif'ed a=
nd installed BATMAN 0.2-rv478.1=2C all OK I think.<br><br>I have arranged t=
he 3 nodes such that node 1 can only see 2 =2C and&nbsp=3B 2 only&nbsp=3B 3=
=2C so no direct contact is available from 1 to 3 (except via the mesh)<br>=
<br>I have not broken the br-lan configuration of these devices and assigne=
d 172.16.1.1/24 to node 1 172.16.1.2/24 to node 2 172.16.1.3/24 to node 3=
=2C so I think that means all packets recvd on wl0 or eh0 are bridged.<br><=
br>I have a pc hooked into the lan port of node 3 From here I can ssh into =
node3 (via the ethernet) and into node2 via the wifi (but not .1)&nbsp=3B N=
etstat -rn on node&nbsp=3B 3 indicates that 172.16.1.1 (node1) is via 172.1=
6.1.2 and this is confirmed by the batman web if that shows .1 is reached v=
ia .2 - all great.<br><br>From the ssh prompt on .3 I can ping .2 with no l=
oss and ping .1 with&nbsp=3B ~ 6% loss. However=2C if I try to ping .1 from=
 the pc connected on the ethernet port of .3 I get no route to host. Puttin=
g wireshark on the ethernet ifc shows the arp going out but nothing coming =
back. Interestingly enough if I ssh into .3 and ping .1=2C with wireshark r=
unning on the ethernet of .3 Is see the outgoing ICMP but not the reply (wh=
ich is there because the ping succeeds) . It seems as if the local host tra=
ffic is not truly bridged.<br><br>This is the first attempt so I might have=
 some incorrect/missing config or done something stupid=2C any ideas would =
be welcome!<br><br>Thanks very much<br><br>nick<br><br /><hr />Windows Live=
 Messenger: Thanks for 10 great years-enjoy free winks and emoticons. <a hr=
ef=3D'http://clk.atdmt.com/UKM/go/157562755/direct/01/' target=3D'_new'>Get=
 Them Now</a></body>
</html>=

--_f1ad30b9-27b9-450a-ae72-099f62ed92c3_--
