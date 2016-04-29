Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 23:15:34 +0200
Message-ID: <2566792.fAMG9yDVtv@sven-edge>
In-Reply-To: <1461590722-2095-1-git-send-email-dvlasenk@redhat.com>
References: <1461590722-2095-1-git-send-email-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10370484.C1CHTA11P5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deinline
	batadv_orig_hash_find, save 9024 bytes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart10370484.C1CHTA11P5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 25 April 2016 15:25:22 Denys Vlasenko wrote:
> This function compiles to 473 bytes of machine code.
> 21 callsites.
>=20
>     text     data      bss       dec     hex filename
> 95903266 20860288 35991552 152755106 91adba2 vmlinux_before
> 95894242 20860288 35991552 152746082 91ab862 vmlinux
>=20
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: Marek Lindner <mareklindner@neomailbox.ch>
> CC: Simon Wunderlich <sw@simonwunderlich.de>
> CC: Antonio Quartulli <a@unstable.cc>
> CC: Sven Eckelmann <sven@narfation.org>
> CC: b.a.t.m.a.n@lists.open-mesh.org
> CC: linux-kernel@vger.kernel.org
> ---
>  net/batman-adv/originator.c | 29 +++++++++++++++++++++++++++++
>  net/batman-adv/originator.h | 31 ++-----------------------------
>  2 files changed, 31 insertions(+), 29 deletions(-)
>=20

This patch should also remove following includes from originator.h:

=2D#include <linux/kref.h>
=2D#include <linux/rculist.h>
=2D#include <linux/rcupdate.h>
=2D#include <linux/stddef.h>
=2D#include "hash.h"

and add following includes to originator.c (please keep them in alphabe=
tical=20
order):

+#include <linux/rcupdate.h>
+#include <linux/stddef.h>

Kind regards,
=09Sven
--nextPart10370484.C1CHTA11P5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI872AAoJEF2HCgfBJntGvl0QAKYmpQGDCbJ1LuhnmSfnDEdC
V0AFFMEM6mAOayfc0m9x4HOQh9b0LibP+0V6KdUe+q4TwNb7ruTQhfS7Gi6TMHD1
12tzVjI0F35SVkWaB8G4uOY+FBrPXdgCOqrrIw8+wwaX4anJ1ugenePM+H7g24Ep
LOwJEh2EfechNf3XmFZpF5JH8GeHmW8FuFluU7OzFV7Y1MLs7G0xoa2lAEv4/GPA
4GVfgMFPGXNkh4LKGx+BbvcFVuzjkUM17JeDAjSPp4bC7OlcdOyNK6xILikLoO+k
sBIbrSMyknVycTcyh3UOnVpTq3apMZKvYWLbD/8q87q2iMrL+cA4Lc9WczBhQ5Od
scc289roH9zgMZuZgAQH2fdFK+ViPZUI6BZOZTsveef7CRJN1+WuUSN4lEY5oIFE
nnxky++mPs58eDkLX63RMmOY5jDVKvEBjxyXSArDEDE21mH8WDCiaXiLtzHtH5n3
LVT+3fQaARDzms4xYWJQxahAg8micQkz2rYwZ1b4TrR7ldfwkWmZi9nrYGzY5Y41
LR/1LZHvvZUp4ZpvF10MFWq2han5lXobaUlaytzswwWU/ddDwauFjXyfdp3+L/WB
liQMcUfAYOtnFPCBIgiZWwyNFJuQBCHS9pVDPAEgtwxJtMjlcX3bm5aFGxTH/MaM
8ZN3J/5lUZrnuA6pf/Xt
=15J0
-----END PGP SIGNATURE-----

--nextPart10370484.C1CHTA11P5--

