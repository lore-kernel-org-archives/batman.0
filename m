Return-Path: <ordex@autistici.org>
Date: Fri, 15 Jun 2012 13:50:06 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120615115005.GA15715@ritirata.org>
References: <1339705288-4175-1-git-send-email-ordex@autistici.org>
	<7712868.YW3oqMkdaP@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <7712868.YW3oqMkdaP@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2012 at 01:45:11PM +0200, Sven Eckelmann wrote:
> On Thursday 14 June 2012 22:21:28 Antonio Quartulli wrote:
> > skb_linearize(skb) possibly rearranges the skb internal data and then
> > changes the skb->data pointer value. For this reason any other pointer =
in
> > the code that was assigned skb->data before invoking skb_linearise(skb)
> > must be re-assigned.
> >=20
> > In the current tt_query message handling code this is not done and
> > therefore, in case of skb linearization, the pointer used to handle the
> > packet header ends up in pointing to poisoned memory. The packet is then
> > dropped but the translation-table mechanism is corrupted.
> >=20
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> >=20
> > *** this patch is an important fix and it is for maint ***
>=20
> Don't forget to add=20
>=20
> Cc: stable <stable@vger.kernel.org>
>=20
> to the patch and a small explanation since when the bug is there (I guess=
=20
> v3.1) and that it may lead to crashes and not only poisened memory (that =
is=20
> the best case.. but maybe the page was removed and we end up in hell when=
=20
> accessing the memory region).

Hi Sven,

Thank you for your suggestions. Sure, I will.

Regards,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/bIW0ACgkQpGgxIkP9cwe6mQCghFo1w0KW3Dy6KvFFsejC2H7+
gWQAni1jaM9wo//kCcX0ITFFjItRLh9D
=DHwT
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
