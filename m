Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Oct 2016 08:29:45 +0200
Message-ID: <5413531.KRiKksbB9Z@bentobox>
In-Reply-To: <580D980A.1090707@yahoo.com>
References: <580A26A4.5030005@yahoo.com> <1744565.jjMyA2xSBQ@bentobox>
 <580D980A.1090707@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2332322.vbTIsMcflF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] High latency with batman-adv on ethernet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2332322.vbTIsMcflF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 24. Oktober 2016 13:11:38 CEST johnzeng wrote:
> 
> Hello Dear Sven and Linus:
> 
>                                              You are right , and When i 
> check /sys/class/net/bat0/mesh/*   and i found  archlinux lost 
> network-coding .

No, they/you just haven't compiled network coding for batman-adv. And
you don't need it.

> 
>                             They were connected via a single cable as you .

What about the rest mentioned in my other mails?

>                             Whether i need use older batman version (batman-adv and batctl 2015.2 ) ?

No. Use a recent version (unless you know that this is a regression).

>                             and our version is newest version ( Linux alarmpi 4.4.26-1-ARCH ) and hardware platform is raspberry pi B , but
> 
>                             i search wiki , i found kernel 4.4 will usebatman 2015.2

It just means that kernel 4.4 includes (more or less) batman-adv 2015.2.
You can still use batman-adv 2016.2 as external module for this kernel
version.


[...]
>                                 if batman-adv don't support archlinux really , whether ubuntu will support batman-adv .

Hm? This doesn't make a lot of sense. batman-adv doesn't require special
distribution support. It is just a Linux kernel module. You have to find
out what other things (hw/drivers/tc/iptables/...) are causing the
problems on your system.

And I even know of people that use Arch Linux on their Freifunk supernodes
together with batman-adv.

Kind regards,
	Sven
--nextPart2332322.vbTIsMcflF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYDapZAAoJEF2HCgfBJntGS8kP/iD2MToYTiJWdO8a55qnUGKf
/pF5YAHPrKiLebvEY7lF8HqKW7RYM5feOUVxTynIvPSO8UugO4XBZuvyNQEi/3+z
fScBkxjYtYhOwdbgzwXNCxmhxJkaTj1+7apHghSZdHaEl0xm1LUOKtUHYdA86afN
mJlXqoVa/tLMjXZ5YHDUxAI+zl6opanoyF5dy4V129au4OJkuA9Z0RMw94omgwSb
4vj8L92h5zjquGkSPNAjv9sjEJ7hv/YDpMkVXV4qmd+1Da3Mn1Fjx2I4OVc14DJz
fE17IXD3s2RH+CdUvCgo7ZJBhgY4Ibt94B2fc+nxU7tTMAMPPv6kYV/alvCoHr6Z
PYLk0pYg+wLJXXh2sb+LGfs/T54PBwFxAPVc7baWvfsu0Q3DwIeP+g0Q9V2TLUle
WuSRJDJtgzrQo9UpUxHPCO6nZweX40LGpBxTYCMP17rfagnJnJsmNGRHtlJTxuX8
MX5+zSfchJeQu/rgrcGrb2c4yALqzTCsq4jCbM28atXKeCjtvZzdEXFaUAse+JZu
ZEtc0ET+wiIPgti6lzxIiO22ZpInFTR/MHi4LBdBmUqbWVrQIY+aU7QgtxkiPZGp
6CXEDE0DSaqlAFwjtXpOykBinvNfEr2BqButaqH21WqbBJmN38j3q4aSjdA/4c9k
/qCskg86+rXDX6bZ1eoo
=4Ly7
-----END PGP SIGNATURE-----

--nextPart2332322.vbTIsMcflF--

