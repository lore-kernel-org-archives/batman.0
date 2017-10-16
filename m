Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Mon, 16 Oct 2017 19:11:02 +0200
Message-ID: <3698882.cXEurrRWIr@sven-edge>
In-Reply-To: <20171016074803.17947-1-sven.eckelmann@openmesh.com>
References: <20171016074803.17947-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8475264.J4oTvNEsHq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid spurious warnings from
 bat_v neigh_cmp implementation
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
Cc: Joseph Stefek <joseph.stefek@openmesh.com>, Antonio Quartulli <a@unstable.cc>, Steffen =?ISO-8859-1?Q?F=F6rster?= <steffen@chemnitz.freifunk.net>

--nextPart8475264.J4oTvNEsHq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 16. Oktober 2017 09:48:03 CEST Sven Eckelmann wrote:
> The neighbor compare API implementation for B.A.T.M.A.N. V checks whether
> the neigh_ifinfo for this neighbor on a specific interface exists. A
> warning is printed when it isn't found.
> 
> But it is not called inside a lock which would prevent that this
> information is lost right before batadv_neigh_ifinfo_get. It must therefore
> be expected that batadv_v_neigh_(cmp|is_sob) might not be able to get the
> requested neigh_ifinfo.
> 
> A WARN_ON for such a situation seems not to be appropriate because this
> will only flood the kernel logs. The warnings must therefore be removed.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> ---
> Cc: Antonio Quartulli <a@unstable.cc>
> 
> This patch is for https://www.open-mesh.org/issues/343

Patch was applied in 0dee8aba [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/0dee8aba4702f82197ed3428ede6b3884fdff5ca

--nextPart8475264.J4oTvNEsHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlnk6CYACgkQXYcKB8Em
e0as3hAAxn5d+GtaZUN5fy7XGIw6BfHmh3N30uQh9s9aYrIYUMnTD0v/ZN9GolX2
baB5U5xNueLtnLjTqqQBUguOUJ55epZVMS97ycCu0hd2ir9oDytBlLL6o9o2giZJ
IaCsf+WgDNVwTxS9aTkXGL/Edo6rz3joAjNKUkw+F0EMrKRdtiyWNpNU/6kbGr6P
syI/W7PYdteJ0rkXusuaKPsNOTusOmduiARnHehdVvvT0hA4oiUXucIXfw1KcJRG
pUNs2N3kdSrgJAVW6PaFgKa8GyRoOiTz1mlieNTnYsAdO8AiTLHvYmLGxJOpAA+P
toOCfndJpfyP6UtFqUm0JChSPdpFnBc6PcUk5FXCIlStlIcABngnfLcqreVLxopS
2E0RVvx+F3XsgqA+aING3WMfJe4ZA0rkQJFXCqo/+Qd7l5n+jaiD3Xe9BS5Z8wgw
QXo6iReuSaLdqmGAEOBAzUP2PABKXTcdqtdiA3mbePBdtiSCH7BzXdmGX0a7QoB5
179g7W4qh+eQV6XhrOehTJBlnsKEPNPqKu0TTQJGaX9jPAnGu9H9OJ9h/zOVf56E
PjskYq9Etz6GUHllGp3j+Ove0XNpfe1N8fSAxhay/KZET6T/DuF46bmdqYPTxUht
BlQW6qtUcxQY5PC6WgDQFOvalCIBlH74ajRvDIVF8hrGxd/Bt6o=
=eyXx
-----END PGP SIGNATURE-----

--nextPart8475264.J4oTvNEsHq--

