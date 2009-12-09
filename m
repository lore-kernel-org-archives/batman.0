Return-Path: <aaron@lo-res.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <771195.22552.qm@web111610.mail.gq1.yahoo.com>
Date: Thu, 10 Dec 2009 00:40:53 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <15EDF7F5-2A4A-4A77-87F4-193AFAA1B7CD@lo-res.org>
References: <771195.22552.qm@web111610.mail.gq1.yahoo.com>
Subject: Re: [B.A.T.M.A.N.] point me to some OSI layer diagrams if possible ?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>
Cc: olsr list users mailing <olsr-users@lists.olsr.org>


(CCing the OLSR list, since George also asked the same question there =
but got no answer yet)

On Dec 9, 2009, at 9:42 PM, George Sanders wrote:

> I am researching meshes/MANETs, and the accompanying =
802.11s/HWMP/olsr/etc.
>=20
> Before asking any specific questions, I wonder if someone could point =
me to some proper OSI
> diagrams that I cannot find - specifically:
>=20
>=20

ok, here is my attempt.....

+--------------+
| Application  |  7
+--------------+
| presentation |  6    E_DOES_NOT_REALLY_EXIST=20
+--------------+
| session      |  5    E_DOES_NOT_REALLY_EXIST
+--------------+
| transport    |  4
+--------------+-----------------------------+
| IP, OLSR.org, B.A.T.M.A.N layer 3 version  |  3    OLSR.org's OLSR =
implemenation is located here
+-------------------------------------------------------------+
| link, 802.11s, B.A.T.M.A.N  layer 2 version, OLPC's  802.11s|  2    =
the HWMP and all the 80.211s stuff resides here. 802.11a/b/g/n resides =
here. Madwifi, ath5k and ath9k reside here. There is massive room for =
improvement on the Wi-Fi level!
+--------------------------------------------+----------------+
| phy                                        |  1    this part of the =
stack is definitely a problem for any routing protocol [*]
+--------------------------------------------+



[*] Much of the discussion focuses on "protocol $bla is better than =
$foo" but actually the Wi-Fi layer 2 and 1 could need massive =
improvements!  It is not the routing protocol on higher levels which =
matters. Wi-Fi per se was not intended to scale so high as we use it in =
community Wi-Fi networks :)
In case layer 1 and 2 were very good and stable, we would be able to run =
almost any protocol on top .





>=20
> - can someone draw, or direct me to, an OSI diagram showing an =
802.11a/b/g/n network using=20
> plain old vanilla 802.11s + HWMP (no OLSR) to support an IP network ?
>=20
>=20
>=20
> Then, for comparison:
>=20
>=20
>=20
> - can someone draw, or direct me to, an OSI diagram showing an =
802.11a/b/g/n network using
> ONLY BATMAN (no 802.11s) ... ?
>=20
>=20
Have to ask back: which version do you mean?=20

Please see: http://www.open-mesh.net/wiki/BranchesExplained


>=20
> Finally, in my research I came across this very interesting =
conversation from 2006:
>=20
> http://www.ietf.org/mail-archive/web/manet/current/msg08218.html
>=20
> and I wonder, has that question:
>=20
> "I agree, but we may still be able to pull it off without having to =
messup the stack."
>=20
> been answered yet ?  Or is there still argument over whether or not =
some implementations require "discussion"
> between components on different OSI layers ?
>=20

In my personal opinion, the more we can get *standardized* "hints" from =
the lower layers (especially Wi-Fi), the better any routing metric can =
become.
In OLSR.org the metric calculations were offloaded to a plugin =
architecture so you are quite free in this respect. I guess there is =
something similar in some versions of B.A.T.M.A.N. and I am sure people =
on the BATMAN list can actually answer this question better than me.


> Thank you.
>=20

I hope it helped somewhat.

a.


PS: typing B.A.T.M.A.N. with all the "." dots all the time is... tiring. =
How about renaming it to "Span"? What came out of that discussion?

