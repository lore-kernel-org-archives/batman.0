Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Fri, 01 Dec 2017 12:32:03 +0100
Message-ID: <1769003.2RLLWacTU4@bentobox>
In-Reply-To: <20171129095042.12587-1-sven.eckelmann@openmesh.com>
References: <20171129095042.12587-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3172578.JQIqqbaoUP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix check of retrieved
 orig_gw in batadv_v_gw_is_eligible
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart3172578.JQIqqbaoUP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 29. November 2017 10:50:42 CET Sven Eckelmann wrote:
> The batadv_v_gw_is_eligible function already assumes that orig_node is not
> NULL. But batadv_gw_node_get may have failed to find the originator. It
> must therefore be checked whether the batadv_gw_node_get failed and not
> whether orig_node is NULL to detect this error.
> 
> Fixes: 80b2d47be2c7 ("batman-adv: B.A.T.M.A.N. V - implement GW selection logic")
> Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> ---
> Cc: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/bat_v.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied in c7380677d616 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/c7380677d6167f3798d3ea7a4f1a93663f3c7915
--nextPart3172578.JQIqqbaoUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlohPbMACgkQXYcKB8Em
e0bEpA/9HXASpeYnfWB1ssxxAxWggpW3g3jyioN4liWoOH0lQkgN6uSPsN7wojZ3
gUaf19d6NaxFe0X4/2ehlapVMkBjQOm8nGqT0vaIQMvku5/pg2eW+mYfOMaKuUGV
0mqPjID4HRGjwXxAayOItVq9fRKVuNmEHFlEzYQuNKa8dWhzdxFMAxk4hqRyyXsc
seWSGKF8YkEPB/MeSm4oU9SrDOu2ycfC0WITvF4YlpqEdWtiWtc1QAgHhoBnQxGf
MQ9XvMcbZ6TS6cvD9xoBKlwKWb95fyHXKHzTjWF6ZL9KwWo1O+Cy0tAi9I5MsgoX
jxs6igwe/my8wwWd2s10nKA3w9x5w2lL9lu+b2rT59ohE4uMtZ3lgLv07Gj4wOxs
gs8FwJJkYUCJekRJJxilQVuZJ9t6EltOVVg7EaffJLVXIdc7MimBY+xlAaO7iJVl
6Kehsi6NUJNXidRpaLufpxSygV3NS8ntazN8XbvBABhNCMfrsc5UHQC4k19RL0xU
kvKm1v+YR39tPtKoLkZt8gS9Rtoo/cAItDqRZxLZlLJisSNRPGsFTsMEFFjbzgqb
tXl3uzGthimB9PNbpTgW5Z39YKeef74eTB3IxeSkAiAUZ85SQFRSQqM+vYZNQkiG
pt8xssFPYIV0I7RdsgAZ0UR2orTVuh4OgLDjRBn9PS9ZcAz25CA=
=nw5Q
-----END PGP SIGNATURE-----

--nextPart3172578.JQIqqbaoUP--

