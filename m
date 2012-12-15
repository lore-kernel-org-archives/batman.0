Return-Path: <ordex@autistici.org>
Date: Sat, 15 Dec 2012 13:39:35 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121215123935.GA10690@ritirata.org>
References: <cover.1355466678.git.martin@hundeboll.net>
 <e283ab952a3393aa0128d377436bc127cedd244a.1355466678.git.martin@hundeboll.net>
 <201212151610.17929.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <201212151610.17929.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/7] batman-adv: Return reason for
 failure in batadv_check_unicast_packet()
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 15, 2012 at 04:10:17PM +0800, Marek Lindner wrote:
> On Friday, December 14, 2012 14:32:46 Martin Hundeb=C3=B8ll wrote:
> >  static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_si=
ze)
> >  {
> >  	struct ethhdr *ethhdr;
> > @@ -564,15 +574,15 @@ static int batadv_check_unicast_packet(struct sk_=
buff
> > *skb, int hdr_size)
> >=20
> >  	/* packet with unicast indication but broadcast recipient */
> >  	if (is_broadcast_ether_addr(ethhdr->h_dest))
> > -		return -1;
> > +		return -2;
> >=20
> >  	/* packet with broadcast sender address */
> >  	if (is_broadcast_ether_addr(ethhdr->h_source))
> > -		return -1;
> > +		return -3;
> >=20
> >  	/* not for me */
> >  	if (!batadv_is_my_mac(ethhdr->h_dest))
> > -		return -1;
> > +		return -4;
> >=20
> >  	return 0;
> >  }
>=20
> Returning meaningless numbers isn't the way to go. Either we make our own=
=20
> defines or we re-use our E***** friends.

If I am not mistaken you only use "-4" in your network coding code. Maybe y=
ou
want to reduce this distinction to two cases only?

e.g.
* -EINVAL : incorrect header or bad fields (-1, -2, -3)..the packet is not =
valid
  in the end
* something else for your case..what about -EREMOTE ?


>=20
> By the way, I suggest to send this patch separately. It increases the cha=
nce=20
> of getting merged faster and reduces your patchset.

I agree on this. It would simplify your daily rebasing task. And when/if yo=
u do
so, remember to change the commit message: networking does not exist yet.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQzG+HAAoJEADl0hg6qKeOneQQAMZzd6b/0+9KS5DVqhtuFzD/
TjiILg4S8xqA3aMw8UqmXifuJsXDRG8vx4fknkcXGdw1heCxdYMUzK30/5xpePrk
YMfGEl0naTWYsuyvPE2zQUiCEG2EI+qw88aU6EpC1uEIrFMd36/y2IapeW68pEr4
X35iJhxsriyxwZX1HTxTpQhutxJD2csS0sUBChc6Bt/H39fYe3fKBrUuI+JkjlJQ
liqvPDXtnaAekjpYjdZ8C3gu3GNlaeWBaW939z+hK5VFpFuADF2ER/ixh6DuUeM4
t7gXCKZrGGvpHd0GfpGNX8eNxjDFHzaWZQG5DnWqTRjC4gkIolx742RHiBS6J9rV
4NAmFdbqthOx8BqF7KukiMSRNwWcYtiiGdyMuaDn6QAdqPqONPUdmMmAc/PzhD6J
Ugck4gATjEueSH1GEAxYY8toev38Kw31VsU3tiALWC6JJt6OFuWnW1mGbcepNb3R
C3NyX/HtMVQvFFdxXFO19NLnYIMwxaoJlf8M7fDFRQrl5pzq99JD7xg6kWTDFh1/
GW5rzgJTh3e+UgzieIdKRXL7/1nuz8LkphLCJ8mdMUBvq4g9XQ4wf3H9yB6cWszF
BY024eeNGWo6nwChnqqnRoK9RySUKUymW9N23gUTESPrpLwHXmMFTLD1osK8pmXV
xJ4Oo+w46+FmTLSHbvqa
=jDXP
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
