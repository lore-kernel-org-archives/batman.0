Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <2059800.IKvSZ5WLNp@prime>
References: <1463034697-8867-1-git-send-email-apape@phoenixcontact.com>
 <1463034697-8867-2-git-send-email-apape@phoenixcontact.com>
 <2059800.IKvSZ5WLNp@prime>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF742EC1C0.076B6112-ONC1257FB9.0037A638-C1257FB9.00380EA4@phoenixcontact.com>
Date: Fri, 20 May 2016 12:12:17 +0200
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCH v4 1/6] batman-adv: prevent
 multiple ARP replies sent by gateways if dat enbled
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Simon,

Simon Wunderlich <sw@simonwunderlich.de> schrieb am 18.05.2016 14:32:09:

> Von: Simon Wunderlich <sw@simonwunderlich.de>
> An: Andreas Pape <APape@phoenixcontact.com>
> Datum: 18.05.2016 14:32
> Betreff: Re: Antwort: Re: [B.A.T.M.A.N.] [PATCH v4 1/6] batman-adv:
> prevent multiple ARP replies sent by gateways if dat enbled
>
> Hi Andreas,
>
> On Wednesday 18 May 2016 09:50:21 Andreas Pape wrote:
> > > Von: Simon Wunderlich <sw@simonwunderlich.de>
> > > An: b.a.t.m.a.n@lists.open-mesh.org
> > > Kopie: Andreas Pape <apape@phoenixcontact.com>
> > > Datum: 13.05.2016 19:37
> > > Betreff: Re: [B.A.T.M.A.N.] [PATCH v4 1/6] batman-adv: prevent
> > > multiple ARP replies sent by gateways if dat enbled
> > >
> > > On Thursday 12 May 2016 08:31:32 Andreas Pape wrote:
> > > > @@ -1003,6 +1004,20 @@ bool
> >
> > batadv_dat_snoop_outgoing_arp_request(struct
> >
> > > > batadv_priv *bat_priv, goto out;
> > > >
> > > >        }
> > > >
> > > > +      /* If BLA is enabled, only send ARP replies if we have
claimed
> > > > +       * the destination for the ARP request or if no one else of
> > > > +       * the backbone gws belonging to our backbone has claimed
the
> > > > +       * destination.
> > > > +       */
> > > > +      if (!batadv_bla_handle_local_claim(bat_priv,
> > > > +                     dat_entry->mac_addr, vid)) {
> > > > +         batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > > > +               "Device %pM claimed by another backbone gw. Don't
send
> >
> > ARP
> >
> > > reply!",
> > >
> > > > +               dat_entry->mac_addr);
> > > > +         ret =3D true;
> > > > +         goto out;
> > > > +      }
> > > > +
> > >
> > > There is still my question/comment pending for this from your
PATCHv2.
> >
> > I'll
> >
> > > quote:
> > >
> > > I  would agree to Antonio that sending a claim is not necessary, and
> >
> > might
> >
> > > actually lead to bad choices of the outgoing backbone gateway. After
> >
> > all, at
> >
> > > this point any "random" backbone gateway may answer to this request,
> >
> > just
> >
> > > because it has the DAT entry, but maybe may actually not be able to
> >
> > reach the
> >
> > > client via the mesh.
>
>
> looks like your reply didn't go to the mailing list, not sure if
> this was your
> intention. Anyway ...
>

That wasn't my intention. It was just my fault;-). Sorry, if you receive
this
twice. I once again forgot to disable html support in my e-mail client...

> >
> > I removed the automatic claim in function
batadv_bla_handle_local_claim
> > but
> > obviously missed to change the comment here accordingly:-( I haven't
had
> > much
> > time recently to work on this and did not spent enough time to work
> > through
> > the new version of the patchset in a way I should have done....
>
> Ah right, I missed that point, and was merely checking my old comments
...
> sorry, I should have checked better too.
>
> >
> > Perhaps it might be a also a good idea to rename the function to
something
> > which cannot be mixed easily with the function batadv_handle_claim.
What
> > about
> > the name batadv_bla_check_claim?
>
> Yes, definitely! We should rename it. check_claim sounds good to me.
>
If there are no other objections I will change the name as discussed in my

next attempt.

> Thanks a lot,
>       Simon

Best regards,
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
