Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Dec 2013 16:28:25 +0800
Message-ID: <8129371.6mLakJ0UnG@diderot>
In-Reply-To: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
References: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4673244.upnX21cVTc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: fix typ0 in sysfs.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart4673244.upnX21cVTc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 December 2013 11:21:21 Antonio Quartulli wrote:
> Fix a small typ0 in sysfs.c.
> Introduced by 99a6eb50ef5066e125cedb97bc0fcfcdff4f08cc
> ("batman-adv: deselect current GW on client mode switch off")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 2be81d7.

Thanks,
Marek

--nextPart4673244.upnX21cVTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqCIqAAoJEFNVTo/uthzAZVwH/iqoh+2p1mkf60BIW8I0RHMk
WuOuIlNcJj++GBUlXTZhpYss615d6G4Fp+0zWeXEESuMptxxL9aFOG9k3+jJAO8Z
GM8mdJkFuaXSp535odTk2DAWfjgXdfnosSDpBaeACqiSHM716sAPU5+0UejQdTZ6
8nAVYwCfNPJ+R0FY6GhzdCA238yZnAboQQ+bdFIDOAR60z1EZ7TZaCbtGxnBIImY
mQ3EkF7D5+bwOEedqqsbJCd8f6Lz4nUc5t1fBA9ODkeChJh9Pl2MF5YfqY6B461y
j24EDBhPAJqHcFrmsaOqg1SKC+ke2XViDxBXn70kAze1ZkE3Q7gRwt+/uO7tJNE=
=whmM
-----END PGP SIGNATURE-----

--nextPart4673244.upnX21cVTc--

