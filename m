Return-Path: <trizonelabs@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120514184254.f79056e44db765d4f85b4f75@gmx.net>
References: <1337010808.2814.70.camel@E-PC-JJ>
	<20120514184254.f79056e44db765d4f85b4f75@gmx.net>
Date: Tue, 15 May 2012 18:23:35 +0300
Message-ID: <CAJuY50ycsfyTGfKHJ0RR8T8z-wA4cqRnhJn_DB1v+MvbWCPv6Q@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Some problems with batman-adv
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

TP-Link TL-WN321G ( RT73/RT2xx)  works well in adhoc mode with Openwrt
& Linux driver since 3 years.
We do use them for mulit-radio tests on VM and native  Openwrt x86 envirome=
nt.
Working on SLITAZ & Debian *nix versions too
Cell-split wasnt observed, but til today there was no vwif driver
found,i.e. no adhoc + AP possible
regards
3zl
.

2012/5/14 Elektra <onelektra@gmx.net>:
> Hello Jochen -
>
> welcome to driver & firmware hell. This is very likely a problem related =
to stability issues with your WiFi interfaces. I would expect this behavior=
 since you are using USB WiFi dongles. All USB WiFi devices depend on firmw=
are, which is loaded when you initialize the devices. Ad-hoc mode has been =
neglected far and wide by the industry. Since you have to load a proprietar=
y binary blob, which is more likely broken in ad-hoc mode rather than not, =
I am afraid you are out of luck. I'd love to get a USB WiFi solution in my =
hands that actually works in a reliable and stable manner. Unfortunately I =
know of none.
>
> If anybody has something that actually works, I'd love to know.
>
> Cheers,
> Elektra
