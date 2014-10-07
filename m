Return-Path: <devil_eddie01@hotmail.com>
Message-ID: <BLU182-W6143FFCB0F3DF09663246A8AA20@phx.gbl>
From: MingAnn Ng <devil_eddie01@hotmail.com>
Date: Tue, 7 Oct 2014 17:10:26 +0800
In-Reply-To: <BLU182-W8782C810EEA0F5B35A10F08AA20@phx.gbl>
References: <BLU182-W625D2EA8376C93F5232A848AA20@phx.gbl>,
 <BLU182-W8782C810EEA0F5B35A10F08AA20@phx.gbl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Inquiry on interface alternating
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hello=2C=0A=
=0A=
I am currently running some powerpc machines with buildroot environment. Th=
e Linux kernel version I am using is 3.8.13 and BATMAN-adv within the kerne=
l without any modification. I am running interface alternating test with th=
e topology below:=0A=
=0A=
A=3D=3D=3D=3D=3D=3D=3D=3DB=3D=3D=3D=3D=3D=3D=3D=3D=3DC=0A=
=0A=
There are two wireless links between A and B and two wireless links between=
 B and C. The two wireless link is using two different channel and ESSID. T=
Q of the 4 links are vary from 250-255 at the initial state. I run udp iper=
f from A to C and observe tcpdump on node B for the two wireless interfaces=
 (wlan0 and wlan1).=0A=
=0A=
I observed that interface alternation is not happening always. Sometime the=
 route will be using wlan0 or wlan1 all the way from A to C=2C as we observ=
ed at node B=2C only 1 interface has traffic on tcpdump. Sometime when inte=
rface alternation happened=2C tcpdump for wlan0 and wlan1 will show traffic=
.=0A=
=0A=
I changed the topology to the below to test further:=0A=
=0A=
A---------------B=3D=3D=3D=3D=3D=3D=3D=3D=3DC=0A=
=0A=
There is only 1 wireless link from A to B while there are two link from B t=
o C. In this case=2C I observed that interface alternation will always happ=
ened=2C as I observed both wlan0 and wlan1 has traffic on tcpdump.=0A=
=0A=
Could you please explain to me what has caused interface alternation not ha=
ppening in the 1st topology and why the interface alternation will always h=
appen in the second topology.=0A=
=0A=
Thank you in advance=2C=0A=
Ming Ann 		 	   		  =
