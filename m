Return-Path: <gibsonsg91921@yahoo.com>
Message-ID: <1344367914.21784.YahooMailClassic@web162702.mail.bf1.yahoo.com>
Date: Tue, 7 Aug 2012 12:31:54 -0700 (PDT)
From: adam wiz <gibsonsg91921@yahoo.com>
In-Reply-To: <1625636.DQU7MN2I4b@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] trouble setting up my mesh
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
To: b.a.t.m.a.n@lists.open-mesh.org

Thanks for the quick reply. I didn't mention my bridge setup because it did=
n't work, but what I was doing was essentially following the quick-start-gu=
ide. In this case I did not assign IP to bat0, but created a bridge called =
mesh-bridge and added wlan0 and bat0 to it. I also used udhcp to configure =
the addresses assigned to clients of the access points.=0A=0AI will try thi=
s, and I appreciate the help. =0A=0AAdam=0A=0A--- On Tue, 8/7/12, Sven Ecke=
lmann <sven@narfation.org> wrote:=0A=0A> From: Sven Eckelmann <sven@narfati=
on.org>=0A> Subject: Re: [B.A.T.M.A.N.] trouble setting up my mesh=0A> To: =
b.a.t.m.a.n@lists.open-mesh.org=0A> Cc: "adam wiz" <gibsonsg91921@yahoo.com=
>=0A> Date: Tuesday, August 7, 2012, 1:33 PM=0A> On Tuesday 07 August 2012 =
10:18:13=0A> adam wiz wrote:=0A> > I am having some trouble setting up batm=
an-adv for my=0A> mesh. I can get each=0A> > access point to see the other =
using "batctl o" but I am=0A> not able to route=0A> > messages between my c=
lient devices. I think there is=0A> something wrong with=0A> > my bridging.=
=0A> [...]=0A> > In setting up batman-adv, I run these commands:=0A> > =0A>=
 > sudo modprobe batman-adv=0A> > sudo batctl if add eth0=0A> > sudo batctl=
 if add wlan1=0A> > sudo ifconfig eth0 0.0.0.0 mtu 1528=0A> > sudo ifconfig=
 wlan1 0.0.0.0 mtu 1528=0A> > sudo ifconfig bat0 10.50.0.x (x being a uniqu=
e number=0A> for each access point)=0A> > netmask 255.255.0.0 up=0A> =0A> W=
hat brigde? I don't see a single bridge here. Only an=0A> ethernet device, =
wlan =0A> device and a batman device that contains both. The bat0=0A> devic=
e has an ip... so =0A> I would doubt that you added it to a bridge.=0A> =0A=
> I would guess that you wanted to do something like this (I=0A> just assum=
e that =0A> br0 is already created through hostapd and includes wlan0...=0A=
> you have to =0A> ensure that this is done):=0A> =0A> sudo modprobe batman=
-adv=0A> sudo batctl if add eth0=0A> sudo batctl if add wlan1=0A> sudo ip a=
ddr flush dev eth0=0A> sudo ip addr flush dev wlan1=0A> sudo ip link set de=
v eth0 mtu 1528=0A> sudo ip link set dev wlan1 mtu 1528=0A> sudo brctl addi=
f br0 bat0=0A> sudo ip link set dev bat0 up=0A> sudo ip addr add 10.50.0.x/=
24 dev br0=0A> sudo ip link set dev br0 up=0A> =0A> Kind regards,=0A> =A0=
=A0=A0 Sven
