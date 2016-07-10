Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 Jul 2016 13:18:27 +0200
Message-ID: <3888556.A4u9qGtres@sven-edge>
In-Reply-To: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2708337.zjiajBBCXF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Add wrapper for ARP
	reply creation
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

--nextPart2708337.zjiajBBCXF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 5. Juli 2016 20:01:36 CEST Linus L=FCssing wrote:
> Removing duplicate code.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Changes in v2:
> * Rebase to master
> * Moved skb_reset_mac_header to earlier position (to avoid calling it on
> NULL)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Small request for the next submissions: Could you please add a space betwee=
n=20
"PATCH" and "v2" (like `git format-patch -v2` does). This will make sure th=
at=20
patchwork will remove the unnecessary information "PATCH" from the title.

Kind regards,
	Sven
--nextPart2708337.zjiajBBCXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXgi8DAAoJEF2HCgfBJntGnWUP/i6NZrpyCXP8BWV/qRrwfOUY
zTd/JxNm7I3lhxr7X2OyYuGKm/djI7Nqm2zo9s1TheGZRzWYObPKR52vNFOyKfhK
mhaRNjJcOPgCIh0BIHmDvFNApQ0NjLRRDsBD9FIF7sGQQOdKUaO8MZV7GCFoolWX
eVB15cwzdXI39lLhTDbNjQZgzpT7uxIwS1jvgHpYikxXeEY8jQkigwhST9nK8rfM
00hzHyHe9NUTUrv22JE8IIVCVrcrYxPLEtcxuN3Sy/LGgBCqPe4lx5lHwcUL0t5x
y5fChqLPQEfhvg3eNgaUUCX3YOYx3Jjj/8oC7hqQZotaAcBbnLDgpAcUhMYEuCu2
71tqFfBu4m7oC4n1Z+hMtCZ56p07DUox1JOdMM4cDcNoxy9o7bt2DovhEET968IL
foAvuZ9eHu20SYAeWCYWBrApsjNPDmM2bj9R6RwaV5+Nm2sMJdIZqregyltoiG2n
0kmU6MugQaq5Y8DJU2U0HGbw5j6cjbJKPJgUXiPSDwmVIiNoPkk2Ye3Xw0SfTgZR
DuL9z8j8HoezUv/wdo9EDKEErgFyDPqXFozFz5INj7qnXKcjxF46Sd0MClG2mTIG
uTrW9QBLQVTOaLxohAOgqkIYC/98g+NP/CDCPFcEPxIxqTuCq0Rg5nnYKl6l/WRF
8Yd4B1Sntyr6XYSMTzK9
=dPCL
-----END PGP SIGNATURE-----

--nextPart2708337.zjiajBBCXF--

