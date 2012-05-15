Return-Path: <Jochen.Jaegers@riedel-at.de>
From: Jochen =?ISO-8859-1?Q?J=E4gers?= <jochen.jaegers@riedel-at.de>
Date: Tue, 15 May 2012 18:24:28 +0200
In-Reply-To: <CAJuY50ycsfyTGfKHJ0RR8T8z-wA4cqRnhJn_DB1v+MvbWCPv6Q@mail.gmail.com>
References: <1337010808.2814.70.camel@E-PC-JJ>
	<20120514184254.f79056e44db765d4f85b4f75@gmx.net>
	<CAJuY50ycsfyTGfKHJ0RR8T8z-wA4cqRnhJn_DB1v+MvbWCPv6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <1337099068.2951.8.camel@E-PC-JJ>
MIME-Version: 1.0
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

Hello 3zl,

which driver/version do you use? Do you have the RT2870STA.dat
in /etc/Wireless/RT2870STA? Can you show me your settings? Maybe i
missed some important settings.

Another strange thing is, that the OGMs come in all the time. Also if i
can't connect to the node. The Originator Table looks fine all the day.
The last-seen value is between 0 and 2 seconds for every node.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen
Jochen J=C3=A4gers

Dr. Riedel Automatisierungstechnik GmbH
Greifswalder Str. 4
10405 Berlin

Tel. 030/428431-48
Fax. 030/428431-99

http://www.riedel-at.de/

Gesch=C3=A4ftsf=C3=BChrer: Dr. Manfred Riedel
Amtsgericht Berlin Charlottenburg, HRB 39094
Umsatzsteuer-Identifikationsnummer DE 137 196 925


Am Dienstag, den 15.05.2012, 17:23 +0200 schrieb 3zl Trizonelabs:
> TP-Link TL-WN321G ( RT73/RT2xx)  works well in adhoc mode with Openwrt
> & Linux driver since 3 years.
> We do use them for mulit-radio tests on VM and native  Openwrt x86 enviro=
ment.
> Working on SLITAZ & Debian *nix versions too
> Cell-split wasnt observed, but til today there was no vwif driver
> found,i.e. no adhoc + AP possible
> regards
> 3zl
> .
>=20
> 2012/5/14 Elektra <onelektra@gmx.net>:
> > Hello Jochen -
> >
> > welcome to driver & firmware hell. This is very likely a problem relate=
d to stability issues with your WiFi interfaces. I would expect this behavi=
or since you are using USB WiFi dongles. All USB WiFi devices depend on fir=
mware, which is loaded when you initialize the devices. Ad-hoc mode has bee=
n neglected far and wide by the industry. Since you have to load a propriet=
ary binary blob, which is more likely broken in ad-hoc mode rather than not=
, I am afraid you are out of luck. I'd love to get a USB WiFi solution in m=
y hands that actually works in a reliable and stable manner. Unfortunately =
I know of none.
> >
> > If anybody has something that actually works, I'd love to know.
> >
> > Cheers,
> > Elektra

