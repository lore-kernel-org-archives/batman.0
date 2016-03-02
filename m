Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <3062893.KrzNl4aDFE@bentobox>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
 <1694240.jq4xBCUVhK@bentobox>
 <OF00FD46E1.005CC1A4-ONC1257F6A.0026960F-C1257F6A.00280700@phoenixcontact.com>
 <3062893.KrzNl4aDFE@bentobox>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF7BD791C2.035E89CC-ONC1257F6A.0040F9FB-C1257F6A.0041ADDD@phoenixcontact.com>
Date: Wed, 2 Mar 2016 12:57:23 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Antwort: Re: Antwort: Re: Antwort: Re: [PATCHv2 2/7]
 batman-adv: speed up dat by snooping received ip traffic
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Sven Eckelmann <sven@narfation.org> schrieb am 02.03.2016 11:23:21:


> >         switch (ntohs(ethhdr->h_proto)) {
> >         case ETH_P_IP:
> >                 if (unlikely(!pskb_may_pull(skb, sizeof(struct
iphdr))))
> >                         goto dropped;
> >                 iphdr =3D (struct iphdr *)(skb->data + ETH_HLEN);
> >                 /* snoop incoming traffic for dat update using the
source
> > mac
> >                  * and source ip to speed up dat.
> >                  */
> >                 batadv_dat_entry_check(bat_priv, iphdr->saddr,
> >                                        ethhdr->h_source, vid);
>
> I doubt that you should drop the data. You new feature is just a nice
> enhancement but should not decide whether packet is valid or not. This
is why
> I told you about skb_header_pointer. Maybe it would also be better to
move
> your stuff in an extra function and avoid to add extra stuff in the
softif
> loop check. Maybe I will even move the softif loop check in an extra
function
> which would be named in a way that doesn't sound like you should add
your
> stuff there :)

Ooops.. Of course you are right about not dropping the packet here!
Further more
I will follow your suggestion to move this into a separate function to not
mix two different things.

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
