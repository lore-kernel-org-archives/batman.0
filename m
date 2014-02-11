Return-Path: <lew.pitcher@digitalfreehold.ca>
From: Lew Pitcher <lew.pitcher@digitalfreehold.ca>
Date: Tue, 11 Feb 2014 11:11:27 -0500
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <20140211153224.GB24633@lunn.ch> <52FA4983.6070901@open-mesh.com>
In-Reply-To: <52FA4983.6070901@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4368086.HdOAmlinx4";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201402111111.32918.lew.pitcher@digitalfreehold.ca>
Subject: Re: [B.A.T.M.A.N.] [RFC 04/23] batman-adv: ELP - creating neighbor
	structures
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

--nextPart4368086.HdOAmlinx4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 11 February 2014 11:02:11 Antonio Quartulli wrote:
> On 11/02/14 16:32, Andrew Lunn wrote:
> > On Tue, Feb 11, 2014 at 01:48:04PM +0100, Antonio Quartulli wrote:
> >> From: Linus Luessing <linus.luessing@web.de>
> >>
> >> Initially developed by Linus during a 6 months trainee study
> >> period in Ascom (Switzerland) AG.
> >>
> >> Signed-off-by: Linus Luessing <linus.luessing@web.de>
> >> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> >> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> >> ---
> >>  bat_v.c     |  18 +++++-
> >>  bat_v_elp.c | 204=20
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  bat_v_elp.h |   6 ++
> >>  main.h      |   2 +
> >>  types.h     |  53 ++++++++++++++++
> >>  5 files changed, 281 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/bat_v.c b/bat_v.c
> >> index 7247d7f..bed5e00 100644
> >> --- a/bat_v.c
> >> +++ b/bat_v.c
> >> @@ -61,5 +61,21 @@ static struct batadv_algo_ops batadv_batman_v=20
__read_mostly =3D {
> >> =20
> >>  int __init batadv_v_init(void)
> >>  {
> >> -	return batadv_algo_register(&batadv_batman_v);
> >> +	int ret;
> >> +
> >> +	/* batman v echo location protocol packet  */
> >> +	ret =3D batadv_recv_handler_register(BATADV_ELP,
> >> +					   batadv_v_elp_packet_recv);
> >> +	if (ret < 0)
> >> +		goto elp_unregister;
> >> +
> >> +	ret =3D batadv_algo_register(&batadv_batman_v);
> >> +
> >> +	return ret;
> >> +
> >> +elp_unregister:
> >> +	if (ret < 0)
> >> +		batadv_recv_handler_unregister(BATADV_ELP);
> >=20
> > No need to check ret here. If we are here, it has to be < 0.
> >=20
> > It also seems odd to me you are unregistering the handler when the
> > registration of the handler fails!
> >=20
> > I suspect the first if (ret < 0) should be followed by a plain return
> > ret; and there should be a second test for the return value of
> > batadv_algo_register() which should goto the label and unregister the
> > handler.
>=20
> I totally agree with what you said.
> We should jump to elp_unregister if batadv_algo_register() fails.

Sorry to break in here, but the (ex) professional programmer in me just /ha=
s/=20
to comment.

Why not just
  int __init batadv_v_init(void)
  {
 -	return batadv_algo_register(&batadv_batman_v);
 +	int ret;
 +
 +	/* batman v echo location protocol packet  */
 +	ret =3D batadv_recv_handler_register(BATADV_ELP,
 +					   batadv_v_elp_packet_recv);
 +
 +	if (ret >=3D 0)
 +	  ret =3D batadv_algo_register(&batadv_batman_v);
 +	else
 +	  batadv_recv_handler_unregister(BATADV_ELP);
 +
 +	return ret;
?
=2D-=20
Lew Pitcher
"In Skills, We Trust"
PGP public key available upon request


--nextPart4368086.HdOAmlinx4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Armoured with GnuPG

iEYEABECAAYFAlL6S68ACgkQagVFX4UWr65/xQCfXhaGo0NYDKLfLtq6+/OYpvjs
iwAAoIcVY8Sgiv2wLMmQyFBccVTuYJ6m
=czFY
-----END PGP SIGNATURE-----

--nextPart4368086.HdOAmlinx4--
