Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 23 Nov 2013 01:25:13 +0800
Message-ID: <1644927.XJ9ypIo1Au@diderot>
In-Reply-To: <1385031136-15967-3-git-send-email-sw@simonwunderlich.de>
References: <1385031136-15967-1-git-send-email-sw@simonwunderlich.de>
 <1385031136-15967-3-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5230712.0gBurOhjZ3";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 2/2] batman-adv: add debugfs support to
	view multiif tables
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart5230712.0gBurOhjZ3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 November 2013 11:52:16 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Show tables for the multi interface operation. Originator tables
> are added per hard interface.
> 
> This patch also changes the API by adding the interface to the
> bat_orig_print() parameters.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PACHv3:
>  * change *multiif* function names to *hardif* names
>  * fix outdated kerneldoc
> 
> Changes to PATCHv2:
>  * use name "originators", not "originators_multiif" for the
>    originator table per interface.
> 
> Changes to PATCH:
>  * use one file per interface instead of all tables in one file
>  * kernel doc and commit message improvement
> ---
>  bat_iv_ogm.c |   12 +++++++-----
>  debugfs.c    |   16 ++++++++++++++++
>  originator.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  originator.h |    1 +
>  types.h      |    3 ++-
>  5 files changed, 73 insertions(+), 7 deletions(-)

Applied in revision f13f960.

Thanks,
Marek

--nextPart5230712.0gBurOhjZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSj5N5AAoJEFNVTo/uthzAyWIIAK6ox6wYjHEVch/fpwzmwcmJ
aP5tWvkroeEqGcXL0SB7UhgjdimM1BhXI00fX3FmIXaVdltGPe7qmHBrHct01XaG
yAeFOHbdzWcZUAVJczciJCZAyOahENMYZNvuqF1fk9s3ctrxvoXc9ZXqHQ/5d4zy
id9lgY4JlF2dsVkaBt58JZtYYLQqnUiZTeiJwD+Z+9ZjT/cKQkE5W96OylFMN3Tu
Sths+ycdA/3D7MPQUjzsmmXQQrqMr0R9/ER0rhBXMUX0R2K0xtgd+3MwTkmHjbq9
u7JoTlvz1ISAS2spCZ8lMT/bfNPT6pyMBvuOIUxUO5sNtce5L+el4GkfZrd40Zo=
=NEhO
-----END PGP SIGNATURE-----

--nextPart5230712.0gBurOhjZ3--

