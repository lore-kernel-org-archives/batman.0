Return-Path: <ordex@autistici.org>
Date: Tue, 14 Feb 2012 11:43:31 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120214104330.GA7762@ritirata.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-5-git-send-email-ordex@autistici.org>
	<201202112209.30987.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <201202112209.30987.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 4/9] batman-adv: Distributed ARP Table
 - add ARP parsing functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2012 at 10:09:30PM +0800, Marek Lindner wrote:
> On Friday, February 10, 2012 07:41:37 Antonio Quartulli wrote:
> > +static inline void bat_dbg_arp(struct bat_priv *bat_priv,
> > +                              struct sk_buff *skb, uint16_t type) {
> > +       char buf[30];
> > +       const char *type_str[] =3D { "REQUEST", "REPLY", "RREQUEST",
> > "RREPLY", +                                     "InREQUEST", "InREPLY",
> > "NAK" }; +
> > +       if (type >=3D 1 && type <=3D ARRAY_SIZE(type_str))
> > +               scnprintf(buf, sizeof(buf), "%s", type_str[type - 1]);
> > +       else
> > +               scnprintf(buf, sizeof(buf), "UNKNOWN (%hu)", type);
> > +
> > +       bat_dbg(DBG_ARP, bat_priv, "ARP message of type %s recognised "
> > +               "[src: %pM-%pI4 dst: %pM-%pI4]\n", buf, ARP_HW_SRC(skb),
> > +               &ARP_IP_SRC(skb), ARP_HW_DST(skb), &ARP_IP_DST(skb));
> > +}
>=20
> Every time this fucntion is called an additional bat_dgb() call is made=
=20
> directly before that (as far as I can tell). Wouldn't it make sense to in=
clude=20
> this extra message as parameter to bat_dbg_arp() ?

I'd say it's a good idea. Despite of the current usage, I thought this func=
tion
to be responsible to print the content of the message only. The fact that a
bat_dbg() invocation always precedes its is just a coincident.

But adding a another argument (which can eventually be NULL) makes much sen=
se :)
Thanks!

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPOjrSAAoJEFMQTLzJFOZFOVcH/2pc1DsuwjuarooZ4AbxIgSh
dIUoRZg6xcWth3PqHHjzojS3k+34AOE+nJI9R7DICXYdvaQ9vDhbO1C4wvKbfa1L
UfKcdexUBN8up+2HDgtUTfUjg8/B+lZrhUxC7BVbE4M0FKz9/VQgMUCf5cx6zpZr
kFyUVPHCf/hj+TiCZ+sIuX2SzYt2Lq3MiqvcnwcjaWNMX7p7bwCgoh3pn3iGuv0B
eZazX5JXgL9FfbBLhMyGH73KcD3sHAt/lE+2g1Bfs4SIFCEZEsauKNsjNEaBBxfT
e1/J60Dxl1T66H/dLZFCftu2jlzzFgYir2w7MPFZBqLddf+dfcuZSnN7H0YHYTg=
=0Yji
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
