Return-Path: <ordex@autistici.org>
Date: Sat, 24 Mar 2012 09:14:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120324081407.GA30000@ritirata.org>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
	<1332453075-27999-2-git-send-email-lindner_marek@yahoo.de>
	<20120323212233.GG5662@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20120323212233.GG5662@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: ELP - creating neighbor
 structures, updating LQs
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2012 at 10:22:33 +0100, Andrew Lunn wrote:
> > +static int bat_v_elp_packet_recv(struct sk_buff *skb,
> > +				 struct hard_iface *if_incoming)
> > +{
> > +	struct bat_priv *bat_priv =3D netdev_priv(if_incoming->soft_iface);
> > +	struct batman_elp_packet *elp_packet;
> > +	struct hard_iface *primary_if;
> > +	struct ethhdr *ethhdr;
> > +	bool ret;
> > +
> > +	ret =3D check_management_packet(skb, if_incoming, BATMAN_ELP_HLEN);
> > +	if (!ret)
> > +		return NET_RX_DROP;
> > +
> > +	/* did we receive a B.A.T.M.A.N. V ELP packet on an interface
> > +	 * that does not have B.A.T.M.A.N. V ELP enabled ? */
> > +	if (bat_priv->bat_algo_ops->bat_ogm_emit !=3D bat_v_ogm_emit)
> > +		return NET_RX_DROP;
>=20
> Hi Marek
>=20
> I've not looked at the code, but i assume this can happen because
> there is not a per algorithm receive handler? Maybe it makes sense to
> have a receive handler in algo structure, which can handle per
> algorithm receive functions? The common PDUs can be handled first and
> then a call into the algo receive function made to dispatch algo
> specific PDUs.

Does this mean that you want to support multiple algorithms at the same tim=
e?
I don't think it is a good idea..

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbYJPAAoJEFMQTLzJFOZFEMUH/3+3yWqD64mXD/hhZORPP2vd
Emo8BH3TXoX/75z/HtXzT7ttY7hqcj76I+8CenctKTblwwYEVGfMCutnc29eYRVM
211z5lhGoshvSg+pbrKRo4EiPnwhZeSidnSaPix6lNWRzyd7riQl+30CfZHo8hp9
UHzVAjcIam2t6010vcLKus6WM1to+x734vgi5p9SIyojmqhIaI+JVY61ZP6N4bxu
Z/jWvrabw9TIfMcRQdP2ri3VkS3Ht+xxmVuhjBp8lJZy6lEzmq9zqPx7ux1a0iad
DBD4FRfQcRj5kSaMhs98zBaJwP2SM74iVEkppZgJ4sy1gbVbQ89U7lDK9j7ZkNs=
=RTOd
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
