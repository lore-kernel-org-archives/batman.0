Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <1694240.jq4xBCUVhK@bentobox>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
 <2502138.exi8rd1dt9@bentobox>
 <OF3D785311.F814DD90-ONC1257F69.0056D58F-C1257F69.00573B0A@phoenixcontact.com>
 <1694240.jq4xBCUVhK@bentobox>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF00FD46E1.005CC1A4-ONC1257F6A.0026960F-C1257F6A.00280700@phoenixcontact.com>
Date: Wed, 2 Mar 2016 08:17:12 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Antwort: Re: Antwort: Re: [PATCHv2 2/7] batman-adv:
 speed up dat by snooping received ip traffic
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

Hello Sven,

Sven Eckelmann <sven@narfation.org> schrieb am 01.03.2016 17:02:57:

> You definitely have to check the size for the IP header. The vlan
ethernet
> header check is a different playground and mostly unrelated to your
problem.
>

If I understood you correctly I am supposed to implement something like
this:

        switch (ntohs(ethhdr->h_proto)) {
        case ETH_P_IP:
                if (unlikely(!pskb_may_pull(skb, sizeof(struct iphdr))))
                        goto dropped;
                iphdr =3D (struct iphdr *)(skb->data + ETH_HLEN);
                /* snoop incoming traffic for dat update using the source
mac
                 * and source ip to speed up dat.
                 */
                batadv_dat_entry_check(bat_priv, iphdr->saddr,
                                       ethhdr->h_source, vid);
                break;
        case ETH_P_8021Q:
                if (unlikely(!pskb_may_pull(skb, sizeof(struct
vlan_ethhdr))))
                        goto dropped;
                vhdr =3D (struct vlan_ethhdr *)(skb->data + ETH_HLEN);

                if (vhdr->h_vlan_encapsulated_proto !=3D ethertype) {
                        /* snoop incoming traffic for dat update also for
vlan
                         * tagged frames.
                         */
                        if (ntohs(vhdr->h_vlan_encapsulated_proto) =3D=3D
                                        ETH_P_IP) {
                                iphdr =3D (struct iphdr *)(vhdr + 1);
                                batadv_dat_entry_check(bat_priv,
iphdr->saddr,
                                                       vhdr->h_source,
vid);
                        }
                        break;
                }
Correctly understood?

Looking through the code of this function batadv_interface_rx leads me to
another
question: Am I right that skb->data is pointing to the beginning of the
mac
layer 2 header of the packet at that point in time as it isn't advanced to
the beginning of the layer 3 header by calling eth_type_trans yet(which is
called
a few lines later)?

> Btw. you can skip this check when you just use skb_header_pointer to
access
> the IPv4 header. It will return NULL when the data cannot be accessed.
It
> will also take care of copying data out of the fragments in your
temporary
> "buffer" when the bytes are not in the main buffer of the skb. You just
have
> to prepare a large enough buffer on the stack and only use the returned
> pointer.
>
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
