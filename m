Return-Path: <ordex@autistici.org>
Date: Sun, 12 May 2013 10:42:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130512084220.GH901@ritirata.org>
References: <1367927642-3223-1-git-send-email-ordex@autistici.org>
 <201305121525.11172.lindner_marek@yahoo.de>
 <20130512082448.GG901@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20130512082448.GG901@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: access
 h_vlan_encapsulated_proto properly
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2013 at 03:25:10PM +0800, Marek Lindner wrote:
> > On Tuesday, May 07, 2013 19:54:02 Antonio Quartulli wrote:
> > > In the gateway code in case of VLAN tagged frame the ethhdr
> > > pointer is moved forward by 4 bytes so that the offset of
> > > h_proto in struct ethhdr matches the real
> > > h_vlan_encapsulated_proto address in the skb.
> > >=20
> > > This trick is correct but the code is not easy to understand
> > > and may lead to bugs in case of re-use of ethhdr for other
> > > purposes.
> > >=20
> > > Use a standalone protocol variable and assign it accordingly
> > > to the header type
> >=20
> > How about adding the key word "refactoring" somewhere into the subject =
line or=20
> > the commit message ?
>=20


oky


>=20
> >=20
> >=20
> > > @@ -626,23 +626,29 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *s=
kb,
> > > unsigned int *header_len) struct iphdr *iphdr;
> > >  	struct ipv6hdr *ipv6hdr;
> > >  	struct udphdr *udphdr;
> > > +	uint16_t proto;
> > >=20
> > >  	/* check for ethernet header */
> > >  	if (!pskb_may_pull(skb, *header_len + ETH_HLEN))
> > >  		return false;
> > >  	ethhdr =3D (struct ethhdr *)skb->data;
> > > +	proto =3D ntohs(ethhdr->h_proto);
> > >  	*header_len +=3D ETH_HLEN;
> > >=20
> > >  	/* check for initial vlan header */
> > > -	if (ntohs(ethhdr->h_proto) =3D=3D ETH_P_8021Q) {
> > > +	if (proto =3D=3D ETH_P_8021Q) {
> > > +		struct vlan_ethhdr *vhdr;
> > > +
> >=20
> > While we are refactoring I suggest to not ntohs() the protocol every ti=
me but=20
> > the protocol constants. The compiler will replace the constants with th=
e=20
> > appropriate number during the compilation, thus saving us from a runtim=
e=20
> > operation every time we check a packet.
> >=20
>=20

oh right. I did not think about it. I guess I have to use __constant_htons
instead of the plain hntons.

cheers,


 --=20
 Antonio Quartulli

 ..each of us alone is worth nothing..
 Ernesto "Che" Guevara



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRj1XsAAoJEADl0hg6qKeO90MP/0lWBf8XgqjeWVYrCr16uipz
mMEUSO7IjkHUDzI57AZnnXWoqI+IGiMui0csX23v3wbMYNvgTC6PByZh+Aw62lFX
+R2klsRmSJLa5aKQNtNyuqxS8qKYdFg1fJ+HmZ3ovmOIRzX78OYGjsaNwMm94qg8
LHEDKbnfWS0YQTxyrdEcjWsHHuWeBZshkzF/JBHUYdfY77gj2jZQwmO1EmfKm/VL
C9Odayh86g2QOXgx37kYw8NwZsHUc9iRHBHyE8qP2IS5ERQ3ey3b7WjvSKPmmJ7B
fYA8rWKUpPRJOjpwdoFs4WtBRmgGIjecs0fpQaXSbUHyaGBYCciLC6bTHokwBoQR
tQ6j+pheNbq6hx/9si9tHkxY0eBjb5+Roirna89ukM4N/EKSsfWaOc3sxpMaaKgw
vhHRU1FhOLhciYNKhiDjlHjoh2VeleL2l05k+rg2epzbLAAeS7EPykB2ymBGT7eL
WgOYvh5C8OPkeiDjUGcvlEWxMT5QfUQphJ0it8KPHcTTPXJv3YsgsVPDHuBcJD+C
/NarO3xMM+EKQyoGOG7fLM62S2MNGYLORDxwAR53Vj6RjPKKQuK0M355QRvSzdPj
08CMFikaWdD0Cs6FmAVAkl1/3GV29h9XX6JUJg2yHliLKMYSta8a1iIy8taD6H4L
7GRNrypKkTtJXKpqHWtX
=LSXI
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
