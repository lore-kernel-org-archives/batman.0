Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 13 Mar 2014 03:25:52 +0800
Message-ID: <2119609.ziFXCXahWC@diderot>
In-Reply-To: <1394640288-1611-1-git-send-email-sw@simonwunderlich.de>
References: <1394640288-1611-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4829079.eExSYmjody";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next v3 1/2] batctl: check for batman
	interface
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


--nextPart4829079.eExSYmjody
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 March 2014 17:04:47 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Check if the interface supplied by -m (or bat0 by default) is actually a
> batman interface. The check is performed by testing if the sysfs path
> is available.
> 
> This change is required since debugfs now contains originator tables per
> hard interface. This might be confusing for users as batctl -m eth0 o
> will now (accidently) print these tables without eth0 beeing a batman
> interface, assuming eth0 is a hard interface used by batman-adv.
> 
> Some reordering of commands were required to first allow commands which
> don't depend on a (correctly set up) mesh interface, like bisect or
> interface.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv2:
> 
>  * fix VLAN check, this is now similar to the sysfs handling code
> ---
>  main.c |   32 +++++++++++++++++---------------
>  sys.c  |   30 ++++++++++++++++++++++++++++++
>  sys.h  |    1 +
>  3 files changed, 48 insertions(+), 15 deletions(-)

Applied in revision da65d62.

Thanks,
Marek


--nextPart4829079.eExSYmjody
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTILTFAAoJEFNVTo/uthzAPqgH/27QOk1kNc6I3n3/vjOzzw/u
vCeQsnPcgYFxEaSFv07VEkBI2SxCfUC3Dxe7HzSw15uA895PU5Zh3bwoAPqj9/xe
fj3I1p/G18CKuK+0rqftUcUAiVI94jLiXMjHsT/3+2MyeZYSAlUJkm3K7dcPL7hL
zXj88kQjCZwLa/FARp2LRSSTav28bO5q8ePQjXbXKfCrCC2vbpcbExKBQBilo/FA
hUB7yaJkrxgACBTiuRc3lM1truoqBjvVcMC87ME6Rf/q2rjmVQd/aZGKzRarSbMj
l499BjKaL8LkukixXttDMMb+5RtOnr8CiOmkxbvOIVRaOoYtBKpcndI1GK+WRj4=
=dmsh
-----END PGP SIGNATURE-----

--nextPart4829079.eExSYmjody--

