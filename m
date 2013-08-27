Return-Path: <ordex@autistici.org>
Date: Tue, 27 Aug 2013 18:33:24 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130827163324.GG2896@ritirata.org>
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-7-git-send-email-ordex@autistici.org>
 <201308261111.37380.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <201308261111.37380.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 6/9] batman-adv: adapt bonding to use
 the new API functions
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


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2013 at 11:11:37AM +0800, Marek Lindner wrote:
> On Tuesday, August 13, 2013 14:43:49 Antonio Quartulli wrote:
> >  	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
> > @@ -502,8 +509,8 @@ batadv_find_ifalter_router(struct batadv_orig_node
> > *primary_orig, if (tmp_neigh_node->if_incoming =3D=3D recv_if)
> >  			continue;
> >=20
> > -		if (router &&
> > -		    tmp_neigh_node->bat_iv.tq_avg <=3D router->bat_iv.tq_avg)
> > +		tmp_metric =3D bao->bat_metric_get(tmp_neigh_node);
> > +		if (router && (tmp_metric <=3D router_metric))
> >  			continue;
>=20
> This last comparison looks horribly wrong. Isn't that what we have the AP=
I=20
> for?

we don't have an API for this.
In this case we should use the "bat_metric_compare" but we removed
that API in this version since it was going to be implemented as a "<=3D" f=
or all
the algorithms we have on the plate now (bat_iv and bat_v).
This is the reason why here we use the compare operation directly.

>=20
> Besides, it seems to me the bat_metric_is_equiv_or_better() call has been=
=20
> misdesigned. Instead of passing the metric and having each function store=
 +=20
> process the metric this call should accept 2 neighbor nodes as argument. =
This=20
> should save 2 out of 3 API calls (2 * bao->bat_metric_get()) and some cod=
e in=20
> all the functions needing the bat_metric_is_equiv_or_better() API. Moreov=
er,=20
> it should reduce the impact on performance because each callback will cos=
t us=20
> a little bit ..
>=20

we could do that, yeah, even if the tests[1] shown that there is not much to
gain at the moment.
What do you suggest?


Cheers,

[1] http://codepad.org/ZEtQASF3 - test performed using iperf between two cl=
ients
connected via Ethernet to 2 OM2P-HS.


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSHNTUAAoJEADl0hg6qKeOolYQAJdh6oE7+P0M4IYDb7wogk+D
xtDCuwhBrkxc3VgbQMf1onaNr7jFa5EH/ndmjtbjHW39pm16zyzcTZQtbIi1CHMU
BXQbc6+evqg04NLca9upGPx00aKo8V0ZI89lwwqcc0Nymi1P1rAEKbV2Y8vtEfNe
J+u6wwfgItYPI0IdY5CIlQoOxw7VegnES3YzJe3InZi1sDL1qQwcAOxsw2jFo1Fs
a2RoQ4bFODCROu4N+g6yFNMFVAcTWBi8dxzkpP8w8uPDFDS0aqN25GJTugufAAgt
ifefTNvOeqPkGKiw7td6ujU+nzjh1pqPidO9au9+tnCWzfudaZCwZ17/o9gaSjhv
xv24SXCeFz2yk4IfcOwr0ddeTaerOw0Yn+lFhbl7QpKgnYBpHeAj244oVlruZNeq
Oqts0b0vCcm31eibF9Q/LJEBnJoGC0fCtNdJAdDaRx5yqxpvgZdiqtFgqCMBg8Zj
LQgICqWSwg62Fg2IbOiCso02w72niG2GjB6aHPBt18Fb10LW9lDxxZiChh2vq4Co
lajQhDcpbjRJSjDsqYGDbuxDDi8s5GQLKBbeWu7sBqsrGQWTBAH5wMUzW48s9N4P
7C+1TsOeckqrZuH7nDCJBiK4KXi39q0AoIHc2zYrF6SOYe6VzAQIsqx4nHOYYWkF
r+8S1zQdDBMzMO8mXl3t
=YrYX
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
