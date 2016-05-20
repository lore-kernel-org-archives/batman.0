Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <20160519194553.GD12565@otheros>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
 <20160519194553.GD12565@otheros>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF496B57CC.AA9E34DD-ONC1257FB9.003EB7CF-C1257FB9.003F68A4@phoenixcontact.com>
Date: Fri, 20 May 2016 13:32:35 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCHv3 2/6] batman-adv: speed up dat
 by snooping received ip traffic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

"B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb am
19.05.2016 21:45:53:

> Von: Linus L=FCssing <linus.luessing@c0d3.blue>
> An: The list for a Better Approach To Mobile Ad-hoc Networking
> <b.a.t.m.a.n@lists.open-mesh.org>
> Datum: 19.05.2016 21:47
> Betreff: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat
> by snooping received ip traffic
> Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>
> On Fri, May 06, 2016 at 10:58:23AM +0200, Andreas Pape wrote:
> > +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct
> sk_buff *skb,
> > +             unsigned short vid)
> > +{
> [...]
> > +   if (iphdr) {
> > +      batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > +            "Snooped IP address: %pI4 %pM (vid: %d)\n",
> > +            &iphdr->saddr, ethhdr->h_source,
> > +            BATADV_PRINT_VID(vid));
> > +      batadv_dat_entry_add(bat_priv, iphdr->saddr,
> > +                 ethhdr->h_source, vid);
> > +   }
>
> Not sure whether it is necessary, or whether there is a check
> somewhere later within DAT. But should we exclude some
> iphdr->saddr or ethhdr->h_source addresses? For instance a
> DHCPDISCOVER usually has a zero-ip address.

I think you have a good point here. Excluding especially
ip addresses like zero-ip address seems reasonable. Although
I think that this isn't a problem as long as no one is sending
arp requests for such ip addresses, filling the dat table with
unreasonable entries isn't a smart idea either. I will add some
additional tests here for reasonable ip addresses for the next
version of the patchset.

Thanks and regards,
Andreas



..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte Informa=
tionen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=FC=
mlich erhalten haben, informieren Sie bitte sofort den Absender und vernich=
ten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige Verwendu=
ng sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
