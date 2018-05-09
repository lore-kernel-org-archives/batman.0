Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 May 2018 22:38:46 +0200
Message-ID: <2913969.huEjgAY5Wz@sven-edge>
In-Reply-To: <1896302.CpHabpdRIs@sven-edge>
References: <20180506195559.32602-1-me@irrelefant.net>
 <2915136.3Ycz4JW85f@sven-edge> <1896302.CpHabpdRIs@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4611914.FMcMCvFUNO";
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart4611914.FMcMCvFUNO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 9. Mai 2018 20:20:58 CEST Sven Eckelmann wrote:
> On Mittwoch, 9. Mai 2018 19:21:32 CEST Sven Eckelmann wrote:
> [...]
> > [...]
> > > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > > index 0225616d..def8d109 100644
> > > --- a/net/batman-adv/translation-table.c
> > > +++ b/net/batman-adv/translation-table.c
> > > @@ -855,7 +855,8 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
> > 
> > What about batadv_tt_prepare_tvlv_local_data?
> 
> Let me rephrase that: Are we sure that this is from intermediate nodes or is 
> there still the possibility that it is from the actual originator? Regarding 
> the latter: Should batadv_tt_prepare_tvlv_local_data be modified or will you 
> wait for Leonardo to debug why it happens in the first place?

Wait. When it is a problem of an intermediate node that doesn't have (for 
whatever reason) not a valid copy of the entries, shouldn't the intermediate
node just ignore the request and not answer it? Otherwise the next OGM with 
the data from batadv_tt_prepare_tvlv_local_data from the actual node will 
just trigger the next request by the receiver.

And the next thing is that your commit message is talking about OGMs all the 
time. But the OGM TVLV are not filled by the 
batadv_tt_prepare_tvlv_global_data but by the 
batadv_tt_prepare_tvlv_local_data. I am unable to find out what you actually
doing here and why you do it.

Kind regards,
	Sven
--nextPart4611914.FMcMCvFUNO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrzXFYACgkQXYcKB8Em
e0bE3hAA0v3tq/5uUZj9Y5f18DI7q4sPBlG78pC9QOhPSUxKLbPpjUwL6v2y76OR
IVle7zlzPrSNmlrKFU1juv1zziq5hYR9xNWLQLkGhsBtsr2g7d3nmlT5i3aQcx+/
dpdSEDFkRa88NsE/x6h8TV+rnXKdYTOKvqljAWhNLlm3wHPXrlTgLXdDW62gXb2L
wklUsQh0IEx2BTcJKGySzvq3sDAeK7f8eNaM5mqkftARyRgsSNlpO8T8n5/SvRTU
QSFg+KKKQ2XUjStf8YT6DEYqAQnbcgCMv369/uwfgdUIbxWu2sluppzs21XY9f9G
tyBWIgR5t13/gXvhCKKUqCR2SHDzmKJGPFWmThbEQyU5TlCsMOXW6fwW1ws44K21
ABtF7KpNdf1BQ6/BspO/7niDtbHA3Nl99INDEu4MPI+fc7peK92DcSa3t29gnx0p
XLGEZ2M4hHFNFK+w1KSJE7uASHyecIltyH4Tn838NKM15PrXM5OkXgbAwne7zFFS
LVBbUuYLVXRduuCYZueV2RG7IaHqeiHjSoBdVtAt3O7Utvz7P7juihDnKQFl/WFP
SIaupBFwUE2+iwAuIjDYK2Cks2K8l+FhlkHAJm8a66J35tqAxzg9UKgTk2NJG+0N
ucBvB7Kw5DoXXEjydp8OTAi6m1VJ3VTn1SqtKrSobq69yAbkOtY=
=hqXO
-----END PGP SIGNATURE-----

--nextPart4611914.FMcMCvFUNO--



