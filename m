Return-Path: <ordex@autistici.org>
Date: Wed, 27 Jun 2012 08:31:36 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120627063136.GD3290@ritirata.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
	<1340740822-4516-4-git-send-email-ordex@autistici.org>
	<4495078.i4mdBapCR8@sven-laptop.home.narfation.org>
	<4FEA2D81.5030407@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <4FEA2D81.5030407@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: enable roaming packets
 to carry flags
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


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 11:45:37PM +0200, Matthias Schiffer wrote:
> On 06/26/2012 11:22 PM, Sven Eckelmann wrote:
> > On Tuesday 26 June 2012 22:00:20 Antonio Quartulli wrote:
> >> In case of client-roaming it would be useful to carry TT flags along w=
ith
> >> the client entry. Information contained in the flags could be used on =
the
> >> new mesh node for several reasons (e.g. particular roaming treatment).
> >>
> >> This patch modifies the ROAMING_ADV packet according to this idea so t=
hat it
> >> can also carry the flags together with the MAC address of the moving
> >> client.
> >>
> >> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> >> ---
> >>  packet.h            |    2 +-
> >>  routing.c           |    7 ++++---
> >>  translation-table.c |   17 ++++++++++-------
> >>  3 files changed, 15 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/packet.h b/packet.h
> >> index 65d66e4..e0b94a3 100644
> >> --- a/packet.h
> >> +++ b/packet.h
> >> @@ -214,7 +214,7 @@ struct batadv_tt_query_packet {
> >>
> >>  struct batadv_roam_adv_packet {
> >>  	struct batadv_header header;
> >> -	uint8_t  reserved;
> >> +	uint8_t  flags;
> >>  	uint8_t  dst[ETH_ALEN];
> >>  	uint8_t  src[ETH_ALEN];
> >>  	uint8_t  client[ETH_ALEN];
> >=20
> > I am not 100% sure because I haven't checked the code, but couldn't it =
be the=20
> > case that we send random bits inside reserved at the moment? At least I=
 cannot=20
> > remember the part of the code that initialized reserver to any specific=
 value.=20
> > That would make the change incompatible with older batman-adv version.
>=20
> As stated in an earlier mail, the `reserved' field in the vis packets
> isn't initialized either, leading to the same problem, being unable to
> ever use this field for anything when you want to stay compatible with
> older versions.
>=20
> IMO this should be fixed in all packets, it's a really bad idea to send
> uninitialized memory over the network...

Yes, I agree. we have to remember this fix the next time we decide to break
compatibility. I don't think we are going to do it now.

Cheers,




--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/qqMgACgkQpGgxIkP9cweI8wCgiv85Kl2AQfr3VAiVBBTl8rmO
0VMAn0Gy0t0jJbHbfjIW4n5QUa53jgzK
=jjqV
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
