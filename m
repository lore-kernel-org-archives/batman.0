Return-Path: <ordex@autistici.org>
Date: Fri, 19 Apr 2013 16:27:48 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130419142748.GC13226@ritirata.org>
References: <1366292627-6417-1-git-send-email-ordex@autistici.org>
 <1366292627-6417-2-git-send-email-ordex@autistici.org>
 <20130419131246.GA30263@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <20130419131246.GA30263@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: print the VID properly
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


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2013 at 03:12:47PM +0200, Simon Wunderlich wrote:
> On Thu, Apr 18, 2013 at 03:43:47PM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Since the MSB bits of any vid variable are now used for
> > storing flags, print the vid properly by taking the flags
> > away and printing -1 in case of VID representing no real
> > VLAN.
> >=20
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > ---
> >  bridge_loop_avoidance.c | 57 ++++++++++++++++++++++++++---------------=
--------
> >  main.h                  |  2 ++
> >  2 files changed, 32 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> > index 16f9239..24a62ac 100644
> > --- a/bridge_loop_avoidance.c
> > +++ b/bridge_loop_avoidance.c
> > @@ -307,7 +307,8 @@ static void batadv_bla_send_claim(struct batadv_pri=
v *bat_priv, uint8_t *mac,
> >  		 */
> >  		memcpy(ethhdr->h_source, mac, ETH_ALEN);
> >  		batadv_dbg(BATADV_DBG_BLA, bat_priv,
> > -			   "bla_send_claim(): CLAIM %pM on vid %hu\n", mac, vid);
> > +			   "bla_send_claim(): CLAIM %pM on vid %hd\n", mac,
> > +			   BATADV_PRINT_VID(vid));
>=20
> You've changed all these strings from %d into %hu and now back to %hd? Wh=
y not just leave everything
> at %d and reduce the bloat of these patches? It should not hurt anyone - =
yes, printing -1 is not pretty
> but this is developer debug info anyway. And keeping %d instead of %hd sh=
ould not be a problem as far
> as I understand.
>=20
> Apart from that, using the BATADV_PRINT_VID macro is a good idea IMHO.

Ok, I'll remove all the format changes and keep the %d :)

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRcVRkAAoJEADl0hg6qKeOHq8P/jwZQKFoEe8S43Bi0KblYMQF
hKMueni+OS+nSheC4Ahg+PqfAC7vhuQAFV2BlWeg0Wxvx1H698fWiKe2vgNk8XnC
MGzri95DkFAYFbDe30fqXuu99himWYhg5FXFO8gTzN63MWLeuNgsSBt37JOJ443S
yFusAy3Eh/K1h740mNBWy5GKAi8eoO+Zm3EklW8vTX85umFoE1lVnp6oapOlCVVj
QN+wln+uWtyuB3Nq5Yaq01W2eGLWNF6lgswWNu8WqoqHFCz1JKWC1a0MJiGbGHO2
qUiUH/NmmNyYvoebn40XDe8sSE78Miv6IrQUyDj3wtuQkWct9wV6tryzb1Ak5MJD
tp8rm5qPbTmEnDGxm464BhYk5TYb3l5YEctoK/VCOcoWvnoxlN87UhhiSsSm3r3+
6EdfhgQYhFIlaJ3+k1XSWUiBzh8Cz9bwhOGl36FVJS02c/iCw9QHv3raoWB5ihlw
IIJVf5vd2xnhyz0lK++c8FoLAHuvIrmVfy2NR73kXAxmh7pMwUxJ11cjw8Se/SXS
4UoCA1K9Au6CzhnUeQchAowLly4l4qcuMsZ0dXL0iaGlBEcykMG3JYnBE8/oWDoE
otV5ZPmkF6vrSRnCKmq+IHNvT/chf/rB/Jad9a2CESD5ohD8bQgLtNaY+X7FSf8C
/OXm9m7HM34ZEs+pbzz2
=44df
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
