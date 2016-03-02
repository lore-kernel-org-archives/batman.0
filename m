Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 02 Mar 2016 11:23:21 +0100
Message-ID: <3062893.KrzNl4aDFE@bentobox>
In-Reply-To: <OF00FD46E1.005CC1A4-ONC1257F6A.0026960F-C1257F6A.00280700@phoenixcontact.com>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
 <1694240.jq4xBCUVhK@bentobox>
 <OF00FD46E1.005CC1A4-ONC1257F6A.0026960F-C1257F6A.00280700@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3183184.aRoWTSmAOF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Antwort: Re: [PATCHv2 2/7]
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
To: Andreas Pape <APape@phoenixcontact.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3183184.aRoWTSmAOF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 02 March 2016 08:17:12 Andreas Pape wrote:
> Hello Sven,
> 
> Sven Eckelmann <sven@narfation.org> schrieb am 01.03.2016 17:02:57:
> 
> > You definitely have to check the size for the IP header. The vlan
> ethernet
> > header check is a different playground and mostly unrelated to your
> problem.
> >
> 
> If I understood you correctly I am supposed to implement something like
> this:
> 
>         switch (ntohs(ethhdr->h_proto)) {
>         case ETH_P_IP:
>                 if (unlikely(!pskb_may_pull(skb, sizeof(struct iphdr))))
>                         goto dropped;
>                 iphdr = (struct iphdr *)(skb->data + ETH_HLEN);
>                 /* snoop incoming traffic for dat update using the source
> mac
>                  * and source ip to speed up dat.
>                  */
>                 batadv_dat_entry_check(bat_priv, iphdr->saddr,
>                                        ethhdr->h_source, vid);

I doubt that you should drop the data. You new feature is just a nice
enhancement but should not decide whether packet is valid or not. This is why
I told you about skb_header_pointer. Maybe it would also be better to move
your stuff in an extra function and avoid to add extra stuff in the softif
loop check. Maybe I will even move the softif loop check in an extra function
which would be named in a way that doesn't sound like you should add your
stuff there :)

>                 break;
>         case ETH_P_8021Q:
>                 if (unlikely(!pskb_may_pull(skb, sizeof(struct
> vlan_ethhdr))))
>                         goto dropped;
>                 vhdr = (struct vlan_ethhdr *)(skb->data + ETH_HLEN);
> 
>                 if (vhdr->h_vlan_encapsulated_proto != ethertype) {
>                         /* snoop incoming traffic for dat update also for
> vlan
>                          * tagged frames.
>                          */
>                         if (ntohs(vhdr->h_vlan_encapsulated_proto) ==
>                                         ETH_P_IP) {
>                                 iphdr = (struct iphdr *)(vhdr + 1);
>                                 batadv_dat_entry_check(bat_priv,
> iphdr->saddr,
>                                                        vhdr->h_source,
> vid);

Dont forget to check the size here too.

>                         }
>                         break;
>                 }
> Correctly understood?
> 
> Looking through the code of this function batadv_interface_rx leads me to
> another
> question: Am I right that skb->data is pointing to the beginning of the
> mac
> layer 2 header of the packet at that point in time as it isn't advanced to
> the beginning of the layer 3 header by calling eth_type_trans yet(which is
> called
> a few lines later)?

I think this should be correct.

Kind regards,
	Sven
--nextPart3183184.aRoWTSmAOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW1r8ZAAoJEF2HCgfBJntGZ0QP/jlTl1NbsgWuoJmXszeZv6ak
oBhFCm+3xZIgV26nhiUEXQtjxjVmNaBHrtOC03N8G//ah9EpKIltDnJzN2vGgV0X
TH1OQRgidT6vy+D9VcdEEscOajO4+oVoPMOrQo0GeYZNtIHkIVvI90dB74s4jsDk
fTFPikp/GJ76/AnTe4pAAOK8WT9f30soaADGwz9ZLtDjVXCNW37Vc43Nq8RVVvVX
3dEIULQYGLIN9WcQCnaAUXONyTTPJKakZYBmBjPwWaP6f8BiJrmWF5B7YcMjXTZ3
R/tZvNPirh12Kfkf3pH2NAkyrMD4yhJNRbD69qIX7pQt7YhrnVX/e+P44OnUffcW
9WVHsobfX84XbJXjuk6wJfHYhoSyfGMOj+d8/fk1jwD5y9x1vb764HEC1FW4JWxl
+YxBOT6e1FHxt+oe6+Vv7PuNrRL/YPwfbGdKw2UHqT1uhVnC28BGREehL+XGXNmH
dP6pp99c5U0Ik33L0yJYc4oNPOu6JZcIqZQSZufOHNvf9EwTE/FCOK2SvxGIwuv3
JgXhIN5rJKpWPyBE13BtfV1q9iAb/VPYmfGUr2GhjXv9NQpzl4oP1Sx2nc4xNX//
kDTLyGepoBit79CCb+rBkOo9ac6brjEcljP2Gfy3VSiEE4ICrox0z8rWxJmLGiin
gElYNqOnzFHo1b0isRJD
=7ZtK
-----END PGP SIGNATURE-----

--nextPart3183184.aRoWTSmAOF--

