Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 May 2018 20:20:58 +0200
Message-ID: <1896302.CpHabpdRIs@sven-edge>
In-Reply-To: <2915136.3Ycz4JW85f@sven-edge>
References: <20180506195559.32602-1-me@irrelefant.net>
 <20180509160605.23223-1-mareklindner@neomailbox.ch>
 <2915136.3Ycz4JW85f@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2034950.ht3XCl9NDz";
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

--nextPart2034950.ht3XCl9NDz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 9. Mai 2018 19:21:32 CEST Sven Eckelmann wrote:
[...]
> [...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 0225616d..def8d109 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -855,7 +855,8 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
> 
> What about batadv_tt_prepare_tvlv_local_data?

Let me rephrase that: Are we sure that this is from intermediate nodes or is 
there still the possibility that it is from the actual originator? Regarding 
the latter: Should batadv_tt_prepare_tvlv_local_data be modified or will you 
wait for Leonardo to debug why it happens in the first place?

Kind regards,
	Sven
--nextPart2034950.ht3XCl9NDz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrzPAoACgkQXYcKB8Em
e0avQxAAyKxet5AkoqIuR4Up33/V7UtZSZw5y/TrjpQvoWi0Ou1JE3kqT4e9XpqE
vWwLXEmCQ/7gq7sfffLU4TwzbU+SihwUsRCH2GLt8EDRxcaClrS0O/EtJ59WsLtj
CQk+V+tlNYBzTQOhTtFfDCWMD598ySxRbwtarsYJ2BYwRFo7pzMz0DA+OW+D4B2F
fCZyMW8m0b1NnJWtBIMJYOGqkbJQBClBttsP21ueg9V9vla4YCHQb0Zs4+dZvXTP
zEYEHRfSlyk8253uYNZtQ85Lr7sXmUyL3ACkecNOkyU83a7k6giS8HueCZJur/gg
T78rSh4vJcprv74sYcqQlqywIP9/UopBZqtwD24YyFhX2jP4ANpYy2RH5y6taPn0
AbxIoWrMFn5y0yXmav94bS+tRL48150/OXCM91Fe8RgOiPjTIk7NSaCVLhIrOjmi
15gnVt2zjBQJ6ASxz9c0ckXESZn1686Jw8oaDA9Z/9ToMwqI8M0Cfldy1jcMQt7l
3S0gvhdflUG1g+13fRNGrmWJ3Z5wcFmHikvCmmz6kiElagLF4lM2XTJqlQWaDs4j
J8xpwE/fuROBacoB+79nhP9mIPQ1zZqPAir9ChfsNfFwOtZw2oIRC7n/DHq66JPt
4Zh6rrfuSka38VrHNqBEzxCQ4/+wy4SjFF6bt9oDSELHWhYhR8s=
=/axY
-----END PGP SIGNATURE-----

--nextPart2034950.ht3XCl9NDz--



