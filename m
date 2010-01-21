Return-Path: <gwirth79@gmail.com>
Message-ID: <4B588C35.2020409@gmail.com>
Date: Thu, 21 Jan 2010 09:17:41 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <20100119145806.275330@gmx.net>	<201001201015.59477.lindner_marek@yahoo.de>	<20100120131234.4760@gmx.net>	<201001210632.19709.lindner_marek@yahoo.de>
	<20100121141227.319490@gmx.net>
In-Reply-To: <20100121141227.319490@gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 01/21/2010 06:12 AM, "Juha Yl=F6nen" wrote:
[snip]
> ---IN ARM DEVICE---
> ##> route
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use I=
face
> 10.0.1.0        *               255.255.255.0   U     0      0        0 e=
th1
> 10.0.0.0        *               255.0.0.0       U     0      0        0 b=
at0
> 224.0.0.0       *               240.0.0.0       U     0      0        0 e=
th1
[snip]


In the laptop you have:

> ylo@ylo-laptop:~$ route
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use I=
face
> 10.0.1.0        *               255.255.255.0   U     0      0        0 w=
lan0
> 10.10.10.0      *               255.255.255.0   U     0      0        0 e=
th0
> link-local      *               255.255.0.0     U     1000   0        0 e=
th0
> 10.0.0.0        *               255.0.0.0       U     0      0        0 b=
at0
> default         10.10.10.1      0.0.0.0         UG    100    0        0 e=
th0

Your routes are all messed up. You have class C addresses subsumed
inside class A address space, which causes undefined behavior.

Give your routes different address spaces, something like one in the
192.168.xx.xx, another 172.16.xx.xx, and the 10.xx.xx.xx so the routes
can be sorted out properly.

Also, why does the laptop wlan0 have an IP address? If it is part of the
mesh through bat0 it should not have an IP address, only add it as an
interface to bat0.

Gus
