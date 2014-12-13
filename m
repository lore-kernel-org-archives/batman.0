Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 13 Dec 2014 15:21:16 +0800
Message-ID: <1650897.KCXVhFc1Hb@diderot>
In-Reply-To: <CAKL2rw57A-bPxzrT6k=j9XyrEy3=X2XG2iY5hcWoTHvdxj5xxQ@mail.gmail.com>
References: <CAKL2rw57A-bPxzrT6k=j9XyrEy3=X2XG2iY5hcWoTHvdxj5xxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1460847.0P6meSx75L";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Fix dmesg | grep,
	use batman_adv (instead of batman-adv)
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
To: Melroy van den Berg <webmaster1989@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1460847.0P6meSx75L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"


Hi,

the mail below went to the wrong mailing list (commits@ is read-only).


Cheers,
Marek
 

On Friday 12 December 2014 22:04:10 Melroy van den Berg wrote:
> Hi,
> 
> This is my first patch :). This is small one, but it's a bug.
> 
> From 414638b05aacdfb111c8f4bf0e35d63b65b8ebdf Mon Sep 17 00:00:00 2001
> From: Melroy van den Berg <webmaster1989@gmail.com>
> Date: Fri, 12 Dec 2014 21:56:32 +0100
> Subject: [PATCH] batman-adv: Use batman_adv (instead of batman-adv) to grep
> in
>  dmesg, because batman_adv is the real module name.
> 
> Signed-off-by: Melroy van den Berg <webmaster1989@gmail.com>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 58e4904..4f401e5 100644
> --- a/README
> +++ b/README
> @@ -135,7 +135,7 @@ mands: dmesg, logread, or looking in the files
> /var/log/kern.log
>  or  /var/log/syslog.  All  batman-adv  messages are prefixed with
>  "batman-adv:" So to see just these messages try
> 
> -# dmesg | grep batman-adv
> +# dmesg | grep batman_adv
> 
>  When investigating problems with your mesh network  it  is  some-
>  times  necessary  to see more detail debug messages. This must be

--nextPart1460847.0P6meSx75L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUi+jxAAoJEFNVTo/uthzAglMIALIBh6oPuvp4MDDBt94JU58I
VoHWM2qAytNzG064q9ReG431S+X1F4e5NIEDgldJJExixtiQdcqLla1McjM5/hKV
8KHAVSImTyc/BJzUigCAcM/4iUUnTmp7daplI4a0/u9861HyTaK/SPPLMzi0rriP
vmEr7zpQM1XJo5FPk9+TsHr8D4QdDME0QGsSOV81+nJDaBwheYgfdWXNftJbKnjk
ifAcaPdS0UXIijGwhM603EeBS2snQlzmYk+NaLgHUHHHY95ET5VVT2BGJaPxqWsq
dj7QicOjmpJdrj4xzEnoZZYHoaiFgjf49PXPdL65TAr4jb8tiSwY8mfGM4s1tdM=
=MVmw
-----END PGP SIGNATURE-----

--nextPart1460847.0P6meSx75L--

