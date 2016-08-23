Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Aug 2016 08:32:26 +0200
Message-ID: <5621960.PaUi3NJltb@bentobox>
In-Reply-To: <20160823011303.18487-1-linus.luessing@c0d3.blue>
References: <20160823011303.18487-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1727468.OhmBE4mQaE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix elp packet data
	reservation
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

--nextPart1727468.OhmBE4mQaE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 23. August 2016 03:13:03 CEST Linus L=FCssing wrote:
> The skb_reserve() call only reserved headroom for the mac header, but
> not the elp packet header itself.
>=20
> Fixing this by using skb_put()'ing towards the skb tail instead of
> skb_push()'ing towards the skb head.
>=20
> Fixes: a4b88af77e28 ("batman-adv: ELP - adding basic infrastructure")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart1727468.OhmBE4mQaE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXu+36AAoJEF2HCgfBJntGFfMQAMsGbqXqAC/JsGRzE3DAaz1i
mAFUP+ijoEQi+syBDiVrk6AoaK/7ZKACy+0q1vAeuXU8jZizRXeOgrst5jIXng1r
FtTkvXtkVNeiltYm8/bk05SDkCs1wSJr8i0ZjkwJHDTHYahCQNkysSeX6vZoh//l
F4hr4utb7igqhng2pkPzo7bRn+I2dCgtHofhtOAOckOOOshgf5TDpLmIDLJkkJJ+
R3QOcy+WtV74H3hXVgtSMSpqgeOhuRQ7G3GaM9PMHE28JLTuQEwI9BUbbZz0dHSV
PFYMyB0txB/WE0KyIghsOnZTIGH6nvBhVsZMr0CfzkCyBzLUIE4q4FlQxNM0Svib
N0qgSReg2AD1oqDaQPDf8CG6VyTj7JLFvG76s3xll39IrNTVNbGFWwyRWeQegoiJ
RQ9vUKB2WkSZ4ArC6rohCxE8ScOCQlUHqNt9i4AF99zzVT7yQi70mJP4ES5lZs2K
XGcqyi4lAQ1SsnOGk1aXi7ogEnttOsKJ2ZAJAv/SJbPED2sun0mE/jdvr1i5qkfy
46IiVy7q81FM7mvta700b/o+B5van1D1wx8OEM+lw+v0IK9CkrYaPpkIz/dG3D1p
C1C5owj8jvo5hJP4VcPwR1/1kKa69MIi/7Xv070qhEcJgBUDGTg1+84EnMH6v+iF
qSJmeI3s7qDgaWUK5jAf
=T2gq
-----END PGP SIGNATURE-----

--nextPart1727468.OhmBE4mQaE--

