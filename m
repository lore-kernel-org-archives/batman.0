Return-Path: <a@unstable.cc>
Date: Tue, 14 Jun 2016 00:02:02 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160613160202.GW10666@prodigo>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-2-a@unstable.cc>
 <3526113.DGLM0pS6Vy@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ng9nCnWcMXS7n1y7"
Content-Disposition: inline
In-Reply-To: <3526113.DGLM0pS6Vy@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 1/4] batman-adv: make the GW selection
 class algorithm specific
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


--Ng9nCnWcMXS7n1y7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 12:45:17PM +0200, Sven Eckelmann wrote:
> On Sunday 12 June 2016 12:14:23 Antonio Quartulli wrote:
> [...]
> > +	if (bat_priv->algo_ops->gw.show_sel_class)
> > +		return bat_priv->algo_ops->gw.show_sel_class(bat_priv, buff);
> [...]
> > +	if (bat_priv->algo_ops->gw.store_sel_class)
> > +		return bat_priv->algo_ops->gw.store_sel_class(bat_priv, buff,
> > +							      count);
> [...]
> >  /**
> > + * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
> > + * @store_sel_class: parse and stores a new GW selection class
> > + * @show_sel_class: prints the current GW selection class
> > + */
> > +struct batadv_algo_gw_ops {
> > +	ssize_t (*store_sel_class)(struct batadv_priv *bat_priv, char *buff,
> > +				   size_t count);
> > +	ssize_t (*show_sel_class)(struct batadv_priv *bat_priv, char *buff);
> > +};
>=20
> Looks like these two are also optional. Can someone please add the "(opti=
onal)"
> string to the kernel-doc like it was done in the initial batadv_algo_ops
> patches? Thanks
>=20
> Same for get_best_gw_node, is_eligible and print in patch 2

Sure!

Thanks!



--=20
Antonio Quartulli

--Ng9nCnWcMXS7n1y7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXXtj6AAoJEJ4aZjxxc6bKMXgQAIoFIFTSaM6QX2JOsi37tq3t
WiAAL5TQmHgM4QOD0D/kv/wdkxf1RMueYBpmT0NjAMvoBvUBGIOEv8/RGVJJ7PoG
ZLHJHemtXP46JFIyu35EguYm/bci8eybBJTk7u66ot3JpaRO75jMTCIxC+2Ax08Y
+mcEhjgHS9q274myv6IqEi+G3vIVacUBXIoIDAeqt77K0VDH1P/FXxMA9W/1/ONG
KUKeZgmEwUqFttbq27AKRmrT8Ex9iQVWuB5LQEhBWPdQFmdW7fk3ZN3NBdS1cjRj
pAIU2d5pmLbMETgP+TR8JHVBNTCCbNEff15jBJy7tZYHY9OyPSze5pHX+MbcDKbF
KoWAQvOFFzSflT0M4tzdL4GvpjrPE2rAtYhgrILufQZInfeaeGpXexhQsbjr+79G
6wCazGL3FkhuahdqYybvQniUxZZ1T+4lSRNaEjSRVKZ3pwWA5olRgg159Q3KP2Bd
YDwtYGMxF3IsVrqjD0AbqsTnBAFQBGu8ooyRk3473kInCsqhP25VEU867l6OwBml
brXecB6YIElotdB1BuX7z9T7lZPtcy25y32t6Nf1dJ27Ykcs9f6Xfvo0QrdMtRpF
UXJNYxQUGppzN+A56TInApYXs/PU4ZMa/pXNiwgoyAh0CMG9/WcIWbDFn+iXjaE7
XmhWCmdUn74beZBM8Jho
=FKLO
-----END PGP SIGNATURE-----

--Ng9nCnWcMXS7n1y7--
