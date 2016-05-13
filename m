Return-Path: <a@unstable.cc>
Date: Fri, 13 May 2016 21:26:14 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160513132614.GK21549@prodigo.lan>
References: <1462874769-5077-1-git-send-email-a@unstable.cc>
 <1462874769-5077-5-git-send-email-a@unstable.cc>
 <2772485.VzmroEUk53@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EVcIhgQsEzAXu06J"
Content-Disposition: inline
In-Reply-To: <2772485.VzmroEUk53@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 5/5] batman-adv: B.A.T.M.A.N. V -
 implement GW selection logic
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


--EVcIhgQsEzAXu06J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 07:31:01PM +0800, Marek Lindner wrote:
> On Tuesday, May 10, 2016 18:06:09 Antonio Quartulli wrote:
> > +static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, =
u32
> > *bw)
>=20
> > +static struct batadv_gw_node *
> > +batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
>=20
> Kernel doc ?

ok :)

>=20
>=20
> > +	struct batadv_gw_node *gw_node, *curr_gw =3D NULL;
> > +	u32 max_bw =3D 0, bw, threshold;
> > +
> > +	threshold =3D atomic_read(&bat_priv->gw.sel_class);
> > +
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
> > +		if (!kref_get_unless_zero(&gw_node->refcount))
> > +			continue;
> > +
> > +		if (batadv_v_gw_throughput_get(gw_node, &bw) < 0)
> > +			goto next;
> > +
> > +		if (curr_gw && (bw <=3D (max_bw + threshold)))
> > +			goto next;
> > +
> > +		if (curr_gw)
> > +			batadv_gw_node_put(curr_gw);
> > +
> > +		curr_gw =3D gw_node;
> > +		kref_get(&curr_gw->refcount);
> > +		max_bw =3D bw;
> > +
> > +next:
> > +		batadv_gw_node_put(gw_node);
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return curr_gw;
> > +}
>=20
> I don't quite follow the use of 'threshold' in this function. The thresho=
ld is=20
> meant to decide whether the switch to another gateway is worth breaking t=
he=20
> existing stateful connections. Here, the code is retrieving the best gate=
way=20
> of all - no need for the threshold ? Moreover, the threshold might lead t=
o=20
> unpredictable results. If the threshold is 5 MBit/s and the first gateway=
 in=20
> the list offers 1 MBit/s while the second offers 5 MBit/s the better gate=
way=20
> is never chosen.=20

You are right. I will re-work this part.

>=20
>=20
> > +static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
> > +				    struct batadv_orig_node *curr_gw_orig,
> > +				    struct batadv_orig_node *orig_node)
>=20
> > +/* fails if orig_node has no router */
> > +static int batadv_v_gw_write_buffer_text(struct batadv_priv *bat_priv,
> > +					 struct seq_file *seq,
> > +					 const struct batadv_gw_node *gw_node)
>=20
> > +static void batadv_v_gw_print(struct batadv_priv *bat_priv,
> > +			      struct seq_file *seq)
>=20
> More room for kernel doc ..

there is always room for kerneldoc..

>=20
>=20
> > @@ -387,7 +569,16 @@ static struct batadv_algo_ops batadv_batman_v
> > __read_mostly =3D { */
> >  int batadv_v_mesh_init(struct batadv_priv *bat_priv)
> >  {
> > -	return batadv_v_ogm_init(bat_priv);
> > +	int ret =3D 0;
> > +
> > +	ret =3D batadv_v_ogm_init(bat_priv);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* set default throughput difference threshold to 5Mbps */
> > +	atomic_set(&bat_priv->gw.sel_class, 50);
> > +
> > +	return 0;
> >  }
>=20
> There is no need to initial 'ret' if the next line is setting a proper va=
lue.
> If you moved the atomic_set() above the batadv_v_ogm_init() call most of =
the=20
> chachacha would go away.
>=20

mhhh ok!

> In batadv_softif_init_late() bat_priv->gw.sel_class is initialized for=20
> B.A.T.M.A.N. IV. Do you intend to keep it there ? If not, a per-routing=
=20
> algorithm init might be cleaner ..  :)
>=20

I do agree :)

I'll rework this part too.

Thanks !

Cheers,




--=20
Antonio Quartulli

--EVcIhgQsEzAXu06J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNdX2AAoJEJ4aZjxxc6bK9nAP/jOJEvl9J+l3vGrm0TNcLyBJ
7YZCkSLAqOQy+nDkq2N2/g/5F+Re91CjEMWQTl+MIw6phxEWZmR4Aoz9LdSiweB1
nsTae5W+DdODh6V12gN28LpBE0ZNXcoDEQEcwKSsO1w0RR88QnZs1GJ4ZlNqRN1S
BSkXgJESf6ySS9wU9yNbEdszWEmI4arVRNF80kOMkL0oDi3SsFrb81SGmqK59FMo
sEq6HY/VJr+qQBV9HVrysC8SfgsiHbXonQ5a7pTsvPMKcsoLSKU/LgaCYKQPFYhG
PyiAOa7aRyLFS34HRxj53prAV4tiw/iLxi/j28XJ4fK8aOqlWp1d5TyVr0zzcS/o
FqBs0lup3AxZCHMzUqfo+xO8bErH4WKck5bioDgrLM+lsssFnP7+y3dmWBqmVAqr
KPrYBsrBaZvIR40Hc2vmR1raym83OXZGYGScsL4Ma8smF1rDbDblbrFWGXX2a5iv
5Vh4sKBhgHM00dOf0iLuiqx3/AgBsBa2o7DUbzHgPGZ0YLBCT+y4DzNb2o8tNbNd
vUSsrD1CRRFSFufwPQz2DGhPdQsqiK4Fme032sBeNpAW0pEv5GHlDOL1aqip1jyi
TvTkusW4YLKuRTxPsOzIy9URzqh5f8m/BAjLkCCHXanOBVyhSOIiVFu5LSwpx8oL
uS5lqXSUOaMIICq83vW1
=/0S0
-----END PGP SIGNATURE-----

--EVcIhgQsEzAXu06J--
