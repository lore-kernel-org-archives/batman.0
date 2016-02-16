Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <10278318.qWhkaFWykG@prime>
References: <OFB1894E97.63E32850-ONC1257F57.004C41B6-C1257F57.004C4F9E@phoenixcontact.com>
 <10278318.qWhkaFWykG@prime>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF7120F97D.F4DD2637-ONC1257F5B.002EA998-C1257F5B.00302C8B@phoenixcontact.com>
Date: Tue, 16 Feb 2016 09:46:10 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCH 3/4] batman-adv: prevent
 duplication of ARP replies in BLA setups when DAT does address resolution
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

Simon Wunderlich <sw@simonwunderlich.de> schrieb am 15.02.2016 09:27:02:

> Von: Simon Wunderlich <sw@simonwunderlich.de>
> An: b.a.t.m.a.n@lists.open-mesh.org
> Kopie: Andreas Pape <APape@phoenixcontact.com>, Antonio Quartulli
> <a@unstable.cc>
> Datum: 15.02.2016 09:27
> Betreff: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: prevent
> duplication of ARP replies in BLA setups when DAT does address
resolution
>
> On Friday 12 February 2016 14:53:31 Andreas Pape wrote:
> > From 2cc1e9eb153d0c2d64cb0fb0747063ba63472925 Mon Sep 17 00:00:00 2001
> > From: Andreas Pape <apape@phoenixcontact.com>
> > Date: Fri, 12 Feb 2016 13:19:25 +0100
> > Subject: [PATCH 3/4] batman-adv: prevent duplication of ARP replies in
BLA
> > setups when DAT does address resolution
> >
> > This patch covers the case of a bla setup with enabled dat if none of
the
> > common gateways of the
> > same backbone has already knowledge of the searched ip address and
> > therefore has to ask via DAT some
> > of the other mesh nodes. A broadcast arp request is coming
> > from the backbone and each backbone gateway starts an address
resolution
> > via other DAT mesh nodes.
> > In this case it should be prevented, that multiple answers from DAT
> > enabled mesh nodes reach the
> > backbone gateways leading to multiple replies in a common backbone
again.
>
> I think this approach and its methods as implented are good. However I
think
> we should generalize this case and forbid UNICAST/UNICAST4ADDR between
> backbone gateways, as discussed in the other thread.
>
> What do you think, or does anyone else have opinions?

From=20my limited experience with batman-adv I would welcome to forbid
UNICAST/UNICAST4ADDR traffic between backbone gateways as this fixes a
problem
I see temporarily in my setup which is not covered by my proposed patches
so far.

However this patch tried to address also a possible multiplication of ARP
replies, if
several backbone gateways forward ARP requests to nodes deep in the mesh
for dat
address resolution. As far as I understand this process, these nodes
answer the
requests independently and more important, the replies then don't come
from=20other
backbone gateways but from the nodes in the mesh. Therefore blocking the
unicast
traffic between backbone gateways doesn't necessarily solve the ARP reply
multiplication
completely.

Kind regards,
Andreas


..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BCtzte I=
nformationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail i=
rrt=C3=BCmlich erhalten haben, informieren Sie bitte sofort den Absender un=
d vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige=
 Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
