Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 10 May 2018 18:28:47 +0800
Message-ID: <2268620.23iF8VIPSQ@lafayette>
In-Reply-To: <1896302.CpHabpdRIs@sven-edge>
References: <20180506195559.32602-1-me@irrelefant.net>
 <2915136.3Ycz4JW85f@sven-edge> <1896302.CpHabpdRIs@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1597616.mgob8b9Rja";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: prevent TT request storms by
 not sending inconsistent TT TLVLs
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

--nextPart1597616.mgob8b9Rja
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 10, 2018 2:20:58 AM HKT Sven Eckelmann wrote:
> On Mittwoch, 9. Mai 2018 19:21:32 CEST Sven Eckelmann wrote:
> [...]
> 
> > [...]
> > 
> > > diff --git a/net/batman-adv/translation-table.c
> > > b/net/batman-adv/translation-table.c index 0225616d..def8d109 100644
> > > --- a/net/batman-adv/translation-table.c
> > > +++ b/net/batman-adv/translation-table.c
> > > @@ -855,7 +855,8 @@ batadv_tt_prepare_tvlv_global_data(struct
> > > batadv_orig_node *orig_node,> 
> > What about batadv_tt_prepare_tvlv_local_data?
> 
> Let me rephrase that: Are we sure that this is from intermediate nodes or is
> there still the possibility that it is from the actual originator?
> Regarding the latter: Should batadv_tt_prepare_tvlv_local_data be modified
> or will you wait for Leonardo to debug why it happens in the first place?

We believe to have an idea why this happens in the first place and I have 
another patch in the works which Leonardo should test in his setup.

Cheers,
Marek

--nextPart1597616.mgob8b9Rja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlr0Ht8ACgkQU1VOj+62
HMBPbQf/Sc42q2gadWskQ+v6y7tEc3XvrxlYO8xXkzWuUYV9w5T4SMkfxZ8i2zy5
eXEA44M2C/vIBG5/fAB5C7qZ4Ty7yTie3XbijT+mVGXiK0bvIBpmLDd3AlA6H/f0
fxakrmzjZS9oJP1dA+mJmlJagAkK4vOQrwUvQWIprjJyLGQmDtCtDSoupEEkw8Za
B9eL0NlhH8eH3pQCmh0iEcMzlU+QQs+GLFtqxDyYY8OBRW8eO9cVtpa6q6xHHJac
7H0MrXi3q9s98nUkJdwGgaavF52hK+aUnL3fIWgWYnfU5r3rrWn59S2g550b1bS1
91jlJ3P4434jEFxlYwo+RRtYX8Ympw==
=JsBq
-----END PGP SIGNATURE-----

--nextPart1597616.mgob8b9Rja--



