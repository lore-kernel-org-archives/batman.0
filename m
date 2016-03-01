Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <2502138.exi8rd1dt9@bentobox>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
 <2502138.exi8rd1dt9@bentobox>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF3D785311.F814DD90-ONC1257F69.0056D58F-C1257F69.00573B0A@phoenixcontact.com>
Date: Tue, 1 Mar 2016 16:52:47 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCHv2 2/7] batman-adv: speed up dat
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

Hello Sven,


Sven Eckelmann <sven@narfation.org> schrieb am 26.02.2016 17:00:49:

> Von: Sven Eckelmann <sven@narfation.org>
> An: b.a.t.m.a.n@lists.open-mesh.org
> Kopie: Andreas Pape <apape@phoenixcontact.com>, Marek Lindner
> <lindner_marek@yahoo.de>
> Datum: 26.02.2016 17:00
> Betreff: Re: [B.A.T.M.A.N.] [PATCHv2 2/7] batman-adv: speed up dat
> by snooping received ip traffic
>
> On Friday 26 February 2016 14:18:17 Andreas Pape wrote:
> > Speeding up dat address lookup is achieved by snooping all incoming ip
> > traffic. This especially increases the propability in bla setups that
> > a gateway into a common backbone network already has a fitting dat
entry
> > to answer incoming ARP requests directly coming from the backbone
> > network thus further reducing ARP traffic in the mesh.
> >
> > Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> > ---
> [...]
> >     switch (ntohs(ethhdr->h_proto)) {
> > +   case ETH_P_IP:
> > +      iphdr =3D (struct iphdr *)(skb->data + ETH_HLEN);
> > +      /* snoop incoming traffic for dat update using the source mac
> > +       * and source ip to speed up dat.
> > +       */
> > +      batadv_dat_entry_check(bat_priv, iphdr->saddr,
> > +                   ethhdr->h_source, vid);
> > +      break;
> >     case ETH_P_8021Q:
> >        vhdr =3D (struct vlan_ethhdr *)skb->data;
> >
> > -      if (vhdr->h_vlan_encapsulated_proto !=3D ethertype)
> > +      if (vhdr->h_vlan_encapsulated_proto !=3D ethertype) {
> > +         /* snoop incoming traffic for dat update also for vlan
> > +          * tagged frames.
> > +          */
> > +         if (vhdr->h_vlan_encapsulated_proto =3D=3D ETH_P_IP) {
> > +            iphdr =3D (struct iphdr *)(vhdr +
> > +                  sizeof(struct vlan_ethhdr));
> > +            batadv_dat_entry_check(bat_priv, iphdr->saddr,
> > +                         vhdr->h_source, vid);
> > +         }
>
> Where is the code to check that there is enough data for the iphdr
> (pskb_may_pull)? Same question goes to Marek for his initial change in
> 48628bb9419f ("batman-adv: softif bridge loop avoidance") that
introduced the
> vhdr->vlan_ethhdr check
>

I will leave this to the result of the discussion in [1] which you started
and will not handle this in the next version of my patchset. Correct?

Kind regards,
Andreas

[1]
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-February/014506.html


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
