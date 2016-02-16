Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <5969063.Lf5LH4TAYi@prime>
References: <OF8F259E43.DCC67654-ONC1257F57.004C278A-C1257F57.004C3956@phoenixcontact.com>
 <5969063.Lf5LH4TAYi@prime>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF76D2D1A1.0DC0CE5B-ONC1257F5B.00304864-C1257F5B.0031B32B@phoenixcontact.com>
Date: Tue, 16 Feb 2016 10:02:50 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Speed up dat by snooping
 received ip traffic
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

> > @@ -412,11 +414,28 @@ void batadv_interface_rx(struct net_device
> > *soft_iface,
> >         ethhdr =3D eth_hdr(skb);
> >
> >         switch (ntohs(ethhdr->h_proto)) {
> > +       case ETH_P_IP:
> > +               iphdr =3D (struct iphdr *)(skb->data + ETH_HLEN);
> > +               /* snoop incoming traffic for dat update using the
source
> > mac
> > +                * and source ip to speed up dat.
> > +                * Question: does this break the fundamental idea of
> > dat????
> > +                */
>
> That is a really good question, although it doesn't belong in the code
;)
>

I know, but I was myself unsure if this is a good idea and wanted to
provoke a discussion about this ;-)

> @Antonio, CC'ing you since this is more a design question/proposal
> and you may
> have thought about this yet.
>
> Basically, doing this change means that we will put a lot of IP
addresses in
> our cache which are not in our local network - typically, all Internet
IP
> addresses along with the gateway backbone. Also these addresses
willnever be
> requested by ARP and are therefore practically just littering our cache.
They
> are purged after 5 minutes so the impact may be reasonable, but still
...
>

I agree that performance and especially consumption of RAM is an issue
here
depending on the network size....

> Maybe there is a way to limit the entries to local networks? Also (and
in
> general), should we have an upper limit how many entries we store in
DAT?
> After applying this patch, doing a subnet ping scan can deplete the RAM
in
> small routers I'm afraid. :)
>
> (even now, that would be possible with fake ARP replies I guess)
>
> Also, why don't you check the ip destination as well while at it?
>
I only tried to check the source addresses with the gateways of a bla
setup
in mind. The goal was to increase the possiblity that already the gateway
can
answer the arp request. In this case only the traffic traveling from mesh
to
backbone is relevant. One could also snoop destination addresse for
traffic from
backbone to mesh, but do you think that this adds an extra benefit of
addtional
information except risking another decrease in forwarding performance ?

> Cheers,
>       Simon
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
