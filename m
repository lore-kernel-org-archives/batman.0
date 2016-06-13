Return-Path: <a@unstable.cc>
Date: Tue, 14 Jun 2016 00:02:47 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160613160247.GX10666@prodigo>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-4-a@unstable.cc>
 <3127928.zeFBqT8Kuq@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vDpQvD79HZx/5O2q"
Content-Disposition: inline
In-Reply-To: <3127928.zeFBqT8Kuq@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: B.A.T.M.A.N. V -
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--vDpQvD79HZx/5O2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 01:12:52PM +0200, Sven Eckelmann wrote:
> On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> > --- a/net/batman-adv/gateway_client.c
> > +++ b/net/batman-adv/gateway_client.c
> > @@ -215,6 +215,10 @@ void batadv_gw_election(struct batadv_priv *bat_pr=
iv)
> >         if (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr=
_gw)
> >                 goto out;
> > =20
> > +       /* if gw.reselect is set to 1 it means that a previous call to
> > +        * gw.is_eligible() said that we have a new best GW, therefore =
it can
> > +        * now be picked from the list and selected
> > +        */
> >         next_gw =3D bat_priv->algo_ops->gw.get_best_gw_node(bat_priv);
>=20
> I would guess that this should be either in patch 2/4 on in an extra patc=
h. At
> least it is about nothing which is touched otherwise in this patch

mh...you are right.

will fix this

--=20
Antonio Quartulli

--vDpQvD79HZx/5O2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXXtknAAoJEJ4aZjxxc6bKrIQP/26TZXLbdVdLoOc5Hifij8Ic
R9xZO6zI7fE6tCFceDn/I1nzUifXU9vsD640RtezMyqTf106SUhADhNJwTjjY7h5
HrcnIdeoIrjWZRO0SXGVoaC2R9ZCvM0X3cIfK6FfnYUuOtBbMoIUSDuz4Lir1FHW
lEvePblcNNLdGje8REGER69k16nw2Orf0EiUMtAfPrvBDivumXT1/iNqLTRz2iFJ
eNjuoErgTTN/17UpuYVg8zZFjA90zSeaEKAGdjIabrRE7niM6FhEPgkUtF6xWM7U
iKD0srqx8fRXlZMNZ8cXKI2rP0UXg/3RwmguFpWCXHoZ93Pl72qpK041716N+rOs
09rpwSo/+pQqm8AjOCFjT98jdaZbeRANTOyJfVvmWGTZyPKOJMTCd1c7vf/5DKyj
UW0Yv/9zHKCbRFrJRG0aiDlrBE0aXzrDq6ccLVsWtxO/JTxkvL95BgYBI+W0zW/N
GR4hsYGPBazZ7yXIjw8kwGJOcNGsaQhQ5oEUq2t32Elg7Aj9PP92u9N7BvLkgWSB
oDqsKg5NkokWHiv6tqBTPtfGYWHeYGI2vOpVGegBufe19ocGKFTzJwNcOKwZXIfJ
YX07dPrwnV+1tJLEqX1Al+Mq0rinHBuTAydGy8VkgWvPDhaAKYSk9TDLcn77zuCK
0273shfNuHJ2BqO96rTU
=/fZx
-----END PGP SIGNATURE-----

--vDpQvD79HZx/5O2q--
