Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 22:27:18 +0800
Message-ID: <41274685.nSIqNVkME4@diderot>
In-Reply-To: <1400906627-18725-1-git-send-email-antonio@meshcoding.com>
References: <1400906627-18725-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1708867.jezHcUrCrd";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: prefer kmalloc_array to
	kmalloc when possible
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


--nextPart1708867.jezHcUrCrd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 06:43:47 Antonio Quartulli wrote:
> Reported by checkpatch with the following warning:
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  bat_iv_ogm.c            | 13 +++++++------
>  distributed-arp-table.c |  3 ++-
>  hash.c                  |  6 +++---
>  3 files changed, 12 insertions(+), 10 deletions(-)

Applied in revision d979cae.

Thanks,
Marek

--nextPart1708867.jezHcUrCrd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTlxXKAAoJEFNVTo/uthzAXi8H/AmIm4mpWWj2JceLCK6D/Zb6
ZtZ+NHh293w/NOIxwypeVLyEIkCSI7Y3RF0LFDA8DrGhduwd6aJ5Ti5JCbJ97GCk
kvUt+dDnxcf+jKicF5/HZnuYTIQThla+ZBa2SwyWmK5b5yrsmF5nmtiR3vqiw3o8
7B5LJzvwMtGzDSc6o6MkHicl1/2T6KF9MLWrEFPS1cAmA6Y2DhNcmy8lURB3o8XT
6u78TYPL+7QdOqEXoO8fS+l14nlmQkq5DmAil9cLuQ3xVPEaMjpcJSDA9jMm65Ko
RuuWG6KhLgbosEollrsNNWAaiGS+DM3qOrUPnjCOcJvIMb7aWkuohjJYBIOpuWo=
=WrMu
-----END PGP SIGNATURE-----

--nextPart1708867.jezHcUrCrd--

