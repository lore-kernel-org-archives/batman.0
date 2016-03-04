Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <20160302213601.GI7704@prodigo.lan>
References: <1456492666-29672-1-git-send-email-apape@phoenixcontact.com>
 <20160302213601.GI7704@prodigo.lan>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFBA326B67.8120621F-ONC1257F6C.00248B79-C1257F6C.002777B2@phoenixcontact.com>
Date: Fri, 4 Mar 2016 08:11:05 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCHv2 1/7] batman-adv: prevent
 multiple ARP replies sent by gateways if dat enabled
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

Hi Antonio,

>
> > +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv,
> > +               u8 *addr, unsigned short vid)
> > +{
> > +   struct batadv_bla_claim search_claim;
> > +   struct batadv_bla_claim *claim =3D NULL;
> > +   struct batadv_hard_iface *primary_if =3D NULL;
> > +   bool ret =3D true;
> > +
> > +   if (!atomic_read(&bat_priv->bridge_loop_avoidance))
> > +      return ret;
> > +
> > +   primary_if =3D batadv_primary_if_get_selected(bat_priv);
> > +   if (!primary_if)
> > +      goto out;
>
> do you really need this goto here ? I think you can just return ret.
>
> This way you can avoid the blind initialization of claim and
> primary_if and you
> can also remove the 'out' label at all.
>
I tried to "copy" the coding style of other functions. But in this case
you are right that this is senseless here.

> > +
> > +   /* First look if the mac address is claimed */
> > +   ether_addr_copy(search_claim.addr, addr);
> > +   search_claim.vid =3D vid;
> > +
> > +   claim =3D batadv_claim_hash_find(bat_priv, &search_claim);
> > +
> > +   /* If there is a claim and we are not owner of the claim,
> > +    * return false;
>
> no need for the ';' here :)
>
> > +    */
> > +   if (claim) {
> > +      if (!batadv_compare_eth(claim->backbone_gw->orig,
> > +               primary_if->net_dev->dev_addr))
> > +         ret =3D false;
> > +   } else {
> > +      /* If there is no claim, claim the device */
> > +      batadv_dbg(BATADV_DBG_BLA, bat_priv,
> > +            "Handle claim locally for currently not claimed mac
%pM.\n",
> > +            search_claim.addr);
> > +
> > +      batadv_handle_claim(bat_priv, primary_if,
> > +                primary_if->net_dev->dev_addr, addr, vid);
> > +   }
> > +
>
> ...
>
> > @@ -1000,6 +1001,20 @@ bool batadv_dat_snoop_outgoing_arp_request
> (struct batadv_priv *bat_priv,
> >           goto out;
> >        }
> >
> > +      /* If BLA is enabled, only send ARP replies if we have claimed
> > +       * the destination for the ARP request or if no one else of
> > +       * the backbone gws belonging to our backbone has claimed the
> > +       * destination.
> > +       */
> > +      if (!batadv_bla_handle_local_claim(bat_priv,
> > +                     dat_entry->mac_addr, vid)) {
>
> I like the approach you take to fix this issue, however I don't
understand why
> you want to "manually" claim a client.
>

This was meant to be something like a safety measure. DAT and BLA tables
are not
synchronized and can timeout separately, right? What, if a client address
is still
available in DAT but the client is not claimed anymore. In this case I
think that
claiming the client might be a good idea. I misused DAT here to make sure
that the
claim table is up to date. In my test setup running DAT and BLA on a
number of
backbone gateways I still have problems with looping packets (although
having all
of my patches applied). The problems have become significantly less often
but
from=20time to time there are still some occurring.
In all of these cases clients from the mesh have been
unclaimed somehow or they have been considered as having roamed to the
backbone
(for an unknown reason the workaround in patch 7/7 did not work in that
case).

> If I recall correctly, a backbone node
> will try to claim a client only if the latter tries to use such node to
enter
> the LAN.
> In this situation the client may never use this backbone to enter
> the LAN (i.e. bad
> metric towards this node) and therefore we are forcing a claim that is
not
> correct.
>
> Simon, what do you think ?
>
> Imho it is ok to *not* reply to the ARP request is the client is not
claimed,
> but I don't understand why claiming it now.
>
>
> > Sitz der Gesellschaft / registered office of the company: 31812 Bad
Pyrmont
> > USt-Id-Nr.: DE811742156
> > Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> > Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
> > ___________________________________________________________________
> > Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte
> Informationen. Wenn Sie nicht der richtige Adressat sind oder diese
> E-Mail irrt=FCmlich erhalten haben, informieren Sie bitte sofort den
> Absender und vernichten Sie diese Mail. Das unerlaubte Kopieren,
> jegliche anderweitige Verwendung sowie die unbefugte Weitergabe
> dieser Mail ist nicht gestattet.
> >
>
---------------------------------------------------------------------------=
-------------------------
> > This e-mail may contain confidential and/or privileged
> information. If you are not the intended recipient (or have received
> this e-mail in error) please notify the sender immediately and
> destroy this e-mail. Any unauthorized copying, disclosure,
> distribution or other use of the material or parts thereof is
> strictly forbidden.
>
> Are you sure this footer does not conflict with the GPL ? Not sure
> how important
> this is, but I'd rather not send it along with patches.
> However, if you use git-send-email this footer should not appear at all.
>

That's a good point. Indeed, I used git send-email. The footer is
automatically
applied by our e-mail server if e-mails leave our company network.
Therefore
my current problem is that I cannot prevent it. But it says "may contain"
and
"if you are not the intended recipient". In this case it's clear that it
does not
contain any confidential or proprietary information by the gpl nature of
your project
and you (i.e. the mailing list) are the intended recipient.

Thanks for the feedback and kind regards,
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
