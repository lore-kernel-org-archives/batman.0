Return-Path: <a@unstable.cc>
Date: Wed, 2 Mar 2016 22:46:07 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160302144607.GH7704@prodigo.lan>
References: <1456926882-2941809-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline
In-Reply-To: <1456926882-2941809-1-git-send-email-arnd@arndb.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: clarify CFG80211 dependency
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 02:54:35PM +0100, Arnd Bergmann wrote:
> The driver calls cfg80211_get_station, which may be part of a
> module, so we must not enable BATMAN_ADV_BATMAN_V if
> BATMAN_ADV=3Dy and CFG80211=3Dm:
>=20
> net/built-in.o: In function `batadv_v_elp_get_throughput':
> (text+0x5c62c): undefined reference to `cfg80211_get_station'
>=20
> This clarifies the dependency to cover all combinations.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the e=
stimated throughput")

Acked-by: Antonio Quartulli <a@unstable.cc>

Thanks a lot Arnd!

David, could you please merge this change in net-next directly ?

Regards,

--=20
Antonio Quartulli

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1vyvAAoJENpFlCjNi1MReMkP/jDLJtnwAtCUaAI1ev6MBH1e
MMN6A0EYyEhhgxn0IqOKFI7SI9YRvqcrQx2jx8/UlVS/Fw/+ZRC622iaYlLjHq92
jeh/ROgHE1H9DagQXGV9bsr+oGW644GdVd9r39sE/i25x1/Hn81vhni+yqwqp86C
sX+c8CmXcFLGck485qqL18/+W1qiW2R5lbunPIqEgGDuLR4NSJ5iFSyPeAB+WiGY
nhfCkjo24QA/jtX/3Ob34N4xhc9rD/Pa2+s6m2K3WWBcSlKyn9tYsEyAmcxZXA8V
RHbwgvm9IWSBO3z23cHJ86KysYuqrjukfW/CHENRiOHGUily/SXF+5N8nC7rqflg
inisK+ZvyKILY17obx/hZ81ulpx5L3r56yN4vfcnvGNqSsNJntPuf4riLFWQFYah
Y3uLGpZNYKRdK9AlW3272iw8Xfug/vPGWU/VnQsxFQzjcnZGLu1i7opAsVVYN0PQ
8dUNjM8AcWZpqtApRYO9+Bvk+67m+UB9ZSPEDYYEGJtSz+vXvtiw4mHp29yphJ0F
ACt+sCx/JhVZl7tjXPCTAUgj+kz4EdJrRLURyxO0jmVSZKdz6vrGyRkHzW7tzQ6C
2ESakGp+D+kNbYIjxIdFLBkstKeX0ymu/6wnql29GwilUjpcAZj+sL5TRGoIJ3Ba
Cju4CdMD0t0Pg5TjpSRI
=pK00
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
