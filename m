Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 6 Dec 2011 20:20:01 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111206192001.GA18458@pandem0nium>
References: <201111290028.01655.lindner_marek@yahoo.de>
	<1322497717-21268-2-git-send-email-lindner_marek@yahoo.de>
	<20111129152318.GA8417@pandem0nium>
	<201112050400.48933.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <201112050400.48933.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: convert batman iv
 algorithm to use dynamic infrastructure
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


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2011 at 04:00:48AM +0800, Marek Lindner wrote:
> > > +	void (*bat_ogm_init)(struct hard_iface *hard_iface);
> > > +	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
> > > +	void (*bat_ogm_update_mac)(struct hard_iface *hard_iface);
> > > +	void (*bat_ogm_schedule)(struct hard_iface *hard_iface,
> > > +				 int tt_num_changes);
> >=20
> > can't we put tt_num_changes somewhere bat_priv?
>=20
> tt_num_changes holds the number of changed TT entries since the last OGM.=
=20
> Obviously that changes all the time. Are you suggesting we store this val=
ue in=20
> bat_priv instead of a local variable ?=20
>=20
Yup. I know that it is changed all the time, just as tt_buff and tt_len cha=
nges
- it is updated when the packet is generated.

There is not really a technical advantage (or disadvantage), it would just =
be
more clean if information like this is stored in bat_priv IMHO - we fetch o=
ther
stuff like the tt buffer or the ogm from structs like bat_priv or hard inte=
rfaces.
And maybe we want to change something in this mechanism in the future.

Just my personal opinion ;)
	Simon

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7eauEACgkQrzg/fFk7axZVSACgzgpCJ1+c+OTi4y+iyvfv8ckp
VLAAoM9EXsDIuQIZ4DMFRaSl7n9GcEdM
=EVg9
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
