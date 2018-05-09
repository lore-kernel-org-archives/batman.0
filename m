Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 May 2018 19:21:32 +0200
Message-ID: <2915136.3Ycz4JW85f@sven-edge>
In-Reply-To: <20180509160605.23223-1-mareklindner@neomailbox.ch>
References: <20180506195559.32602-1-me@irrelefant.net>
 <20180509160605.23223-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3875947.iQJUTyLI2G";
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

--nextPart3875947.iQJUTyLI2G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 9. Mai 2018 18:06:05 CEST Marek Lindner wrote:
[...]
> Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")

I know, my fault but please use 21a57f6e7a3b instead of 7ea7b4a14275. The 
latter is in the official Linux repository and not batman-adv.git.

[...]
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 0225616d..def8d109 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -855,7 +855,8 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,

What about batadv_tt_prepare_tvlv_local_data?

Kind regards,
	Sven


--nextPart3875947.iQJUTyLI2G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrzLhwACgkQXYcKB8Em
e0ZUtxAAppZ6fST7LoFFccUXAclDpQxDlfeiUuPCAO9+PrbMIcf+ymaq/ZKBd++g
gxihVxruf48YATwIDTUo5WWTS96eKyc/Fu3qkhx8BG0uNMvniAYg1iMYPrrOUnrQ
8OytolYPv9rLq9xxdt6YDJ0qAjcibIBToCOTOvfH6CyV0xG6DZqSTNV0X3lGnas1
GK3AsyCQ26yKb4ryxX/vvdBFIjDO8TVFhRsGJr2Vc8YxylWRLmjCXu/RiZ0QTa/X
4Mc4lhkMNXBe4gS3bPH3F478XjjzlAuW7hpyCpPPaDGPloZx/Emk6ZRvucI730yl
sSpWtlKZOoWu79f8OBy2lddtYHgRPVpij8CWv0HernrXqPKsOYk/98mPBRA4KzeZ
k7fc8mOH2c7zlQ9rwqYQ8HJJKvH7amXfKlEEl9LkHvpNgi/KsaP9zPM6iJxR6EU5
4h6T6xiKJmb4DjAIPf91erD4xKSPomh57/I4Dy5kU3SDF3cW88s6PDOUkjTlIgls
af6emTaSIy8YJI51YtpAgxvXUOX0rPzNPmDdrJK2A3ToKZ/TcdWlZHmP1qBBWTlv
HXZawZalyMITt3nyfW3X0nqUIAJBw+Gk3eov5wfb6usGuOfvg/WszqXuhdEYGqdn
ihMUjgUdgG4ewPkvR0sUNvCIq3K7dJD/F1TvxdM1RUqg0nrCmD4=
=E0Vp
-----END PGP SIGNATURE-----

--nextPart3875947.iQJUTyLI2G--



