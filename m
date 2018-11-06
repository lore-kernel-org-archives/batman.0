Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Nov 2018 10:12:34 +0100
Message-ID: <5411725.zfhiFjUOa4@bentobox>
In-Reply-To: <20181106090150.2905-1-linus.luessing@c0d3.blue>
References: <20181106090150.2905-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3037409.LojrFdAvxj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: enable MCAST by default at
 compile time
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

--nextPart3037409.LojrFdAvxj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 6. November 2018 10:01:50 CET Linus L=FCssing wrote:
> Thanks to rigorous testing in wireless community mesh networks several
> issues with multicast entries in the translation table were found and
> fixed in the last 1.5 years. Now we see the first larger networks
> (a few hundred nodes) with a batman-adv version with multicast
> optimizations enabled arising, with no TT / multicast optimization
> related issues so far.
>=20
> Therefore it seems safe to enable multicast optimizations by default not
> only in kernel module builds but also for in-kernel builds.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

I have now queued it up for the upcoming net-next PR. This patch should be=
=20
merged after we released batman-adv 2018.4. But my original patch to disabl=
e=20
the MCAST optimization by default [1] for 2018.4 was already reverted. The=
=20
2018.4 release will therefore still have MCAST enabled by default for the o=
ut-
of-tree module.

Thanks,
	Sven

[1] https://patchwork.open-mesh.org/patch/17435/
--nextPart3037409.LojrFdAvxj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvhWwIACgkQXYcKB8Em
e0aj1Q/8ChSZBIt30Egylhduojblfe5z9Nf2HwEz9cIFvZBu5TDEqfnDGgTmsF6A
Qr97pTmim+Y5ddX5/l/jg8kS1+8ezT+zbCOi90sfDOwy81CO1/O7r/1D5/U9hlkh
GbMdP6yIMwiY70j/gEHzjy+suVPoYCYZQni3mpkgJjvKAu37x6YKKTE9A1ZpkG+5
Lpf5cgPoFA98yW9iU8a49YMJn1tLaIFd4BBVWBiCFdMIPNKD2p5L5Xn4pqE2w+mH
yndUpCIr0qdmhTTk5GX/fBmyhKP8QY0J+kjs1vCPX2IKCDymQumsJkbm1tJk907I
wBsGdR/c5rXJA9Efdc3gSgHx83YRnHHBr6LOwvj3DOgMDmuQaKJmyiwiIo53MiVC
Slztldap7GjCTvkgQPUK6iG4o838sKxBhXf+kACG7m3S7KItEl7xWCnlgVy+9nzY
4TDIdSEkcJSbRS/00beUGf1icwVKw83H8/yIce4IUkFzUo5NBg5+qtE8ROsNSBGP
/WpCLZRIQfsXmR+4D6SszV+qCynnZfqmKnJclT/hSyZx3WMVI3cKD2Bn2snAsmjV
9G1LxAm+tII90ovvhSgY68oHsOjUAugnc6jOdzeTmCKg34luywDfGdh+4HAiBHYi
Fy3hNDvg8eWbY9urvZ4Rj4fvzSimEvqijgKVOJHLAhXbAlovcN0=
=1f6X
-----END PGP SIGNATURE-----

--nextPart3037409.LojrFdAvxj--

