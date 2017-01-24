Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Jan 2017 13:46:49 +0100
Message-ID: <4093841.YFahW3B88D@bentobox>
In-Reply-To: <20170124000030.29160-1-linus.luessing@c0d3.blue>
References: <20170124000030.29160-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4449103.YAIthYbshD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: restructure cfg80211 compat
	code
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

--nextPart4449103.YAIthYbshD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 24. Januar 2017 01:00:30 CET Linus L=FCssing wrote:
> This commit restructures the compat code regarding cfg80211 to achieve
> the following:
>=20
> a) Allows to compile kernels < 3.16 with -Werror by replacing the
> "#warning" with a runtime warning through pr_warn_once().
> b) Allows to run < 3.16 kernels without warnings if no cfg80211 based
> interface is used.
> c) Migrates cfg80211 compat code from compat.h to compat cfg80211.h to
> keep compat.h slim.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  compat-include/net/cfg80211.h | 21 ++++++++++++++++++++-
>  compat.h                      | 21 ---------------------
>  2 files changed, 20 insertions(+), 22 deletions(-)

Applied in 3da7de5d6aa8f69d6d7daa62f3e6d3f7ebed5772 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/3da7de5d6aa8f69d6d7daa6=
2f3e6d3f7ebed5772


--nextPart4449103.YAIthYbshD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliHTLkACgkQXYcKB8Em
e0aZXA//cXbqSaKYVbEwNRNOXx4PPUkRuEfs7TxKicVYBZy9yWbtrVoglk3FXvir
gbixnjHhvnxbIh6F73lzPvd0so6+bniaS77Sfej24ehQuDYmJ3+DIN9u6Ii67BcW
xSKupSowGhG5J7gGyNd5h8Q6TfQR13qBHI7enYNLLZQF3RLVHsQNk75ksyUr1u0K
2Fb6aqxH0hA127bMc0P6JfgtYAdH7ASxcKXNCrgcRXHteZX1q7Muf6AmnWitXZAe
6a7MEhC4h04CsnNm3vFX58ldHrg4v6DTXvdV8QZmSneA7polt9a85xcB49DXvipI
Qwkk4XxCtvIW9jcewN3bP4dfrlHRNLZ4dOT0B5JoqjmwhDbwqwallSr7ihwzcHVT
p8WZqjll+xC3DvPl0LtBevAdnBRE/M41WqjHp7MmNqp+uP49SVUn8bhdx54TiGnX
9FO7byO5JXEYG1JagN2OfVBEH+R/wOZ4iGwrPhRR0fEWNfFceaxZfx4m9G4lzhtz
9qHJRk7fpXWTz6e7OWgecuUNXGUOim1V7PXk9WKDXY8M4mxZ7hyTi7epWrJKm0Z5
eyvH4CNzUS7zLkQcX+5Qhopsh3SeoxvJ3thbMmhEeXS9iSXnQq3p3RZim2zFWEiV
JRTETIkIHmnv2AcDzAWBH1zVKYhUeDy0jSnG4yiWQppfMuRSn9I=
=bXWV
-----END PGP SIGNATURE-----

--nextPart4449103.YAIthYbshD--

