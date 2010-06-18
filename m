Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4C1B4F52.2020002@rsm-freilassing.de>
Date: Fri, 18 Jun 2010 12:49:54 +0200
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
References: <201006171018.47209.clemens-john@gmx.de>
In-Reply-To: <201006171018.47209.clemens-john@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] MTU/connection problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

  I've read the complete topic, but dont't know if your problem is solved.

You're right. The MTU is your Problem. And when i read your post, it was=20
clear for me, that your problems results on your VPN Connection.

You need to do some MSS stuff on your OpenWRT Router.

/sbin/iptables -t mangle -A forward -i tap0 -p tcp -m tcp --tcp-flags=20
SYN,RST SYN -m tcpmss --mss 1381:65535 -j TCPMSS --set-mss 1460
/sbin/iptables -t mangle -A forward -o tap0 -p tcp -m tcp --tcp-flags=20
SYN,RST SYN -m tcpmss --mss 1381:65535 -j TCPMSS --set-mss 1460

And all your problems are gone :-D

Liebe Gr=FC=DFe aus Freilassing,

Michael Rack
RSM Freilassing
--=20
RSM Freilassing                 Tel.: +49 8654 607110
Nocksteinstr. 13                Fax.: +49 8654 670438
D-83395 Freilassing            www.rsm-freilassing.de


Am 17.06.2010 10:18, schrieb Clemens John:
> Hi,
>
> I have a problem to connect to the Internet. We are using Batman advanced
> 0.2.1 and IPv4 here in oldenburg. Our setup looks like this:
>
> Laptop-[wifi]->Fonera-[wifi]->Dir300-->OpenVPN-->
> virtual OpenWrt machine-->internet.
>
> The default route of the laptop goes to the virtual OpenWrt machine wich
> provides an Internet connection.
>
> I can acces google (wget google.de) but not heise.de or golem.de. I=B4m n=
ot
> verry familar with network configurations but I heared that this might be=
 an
> mtu problem.
>
> All devices in the network (tap0, ath0, ath1, wifi0) have an mtu of 1524 =
except
> bat0 and br-mesh which have an mtu of 1500.
>
> Our routers are configured to bridge connections from non batman devices =
(like
> the laptop) to bat0. This is done in the device "br-mesh".
>
> Everythink works fine, except I can=B4t connect to internet websites that=
 are not
> google.de.
>
> When I decrease the mtu of the wireless device of the laptop to 1476
> everything works fine.
> But I have to do this by hand and on a client this is bad.
>
> Does anybody know what I=B4m doing wrong?
>
> Greetings
> Clemens
