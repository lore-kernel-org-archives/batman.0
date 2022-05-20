Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Question about batman for ARM
Date: Fri, 20 May 2022 09:43:13 +0200
Message-ID: <2546299.1OsWWQgn6R@ripper>
In-Reply-To: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2744519.aNBPxFQpTQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Charles Chien <cchien@creonexsystems.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart2744519.aNBPxFQpTQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Charles Chien <cchien@creonexsystems.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Question about batman for ARM
Date: Fri, 20 May 2022 09:43:13 +0200
Message-ID: <2546299.1OsWWQgn6R@ripper>
In-Reply-To: <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
References: <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>

On Friday, 20 May 2022 08:18:45 CEST Charles Chien wrote:
> We=E2=80=99re currently trying to install batman-adv on an ARM platform b=
ut we
> ran into some issues and we would appreciate your help to answer our
> questions below:
>=20
> Is the batman-adv module compatible with an ARM processor (Raspberry PI 4=
)?

There is not just an "ARM" processor. It is a family of various processors.

Anyway, it can be used easily on Raspberry Pi - just make sure that you use=
 a=20
good wifi device + driver (+firmware) which actually can communicate over=20
IBSS/802.11s (without forwarding enabled) and has no (extreme low) peer lim=
it.=20
Unfortunately, you cannot take this for granted.

> I=E2=80=99m trying to install batman-adv onto an ARM Raspberry PI 4 with a
> Debian based Linux distribution (Pop OS). However, when I run
> =E2=80=9Cmodprobe batman-adv=E2=80=9D, it returns a FATAL error complaini=
ng that the
> module is not found in the =E2=80=9C/lib/modules=E2=80=9D directory. Wher=
e can I
> find/download the =E2=80=9C.ko=E2=80=9D for batman-adv for the ARM platfo=
rm?

Ehrm, this is not how this works. You cannot just use a kernel module and h=
ope=20
that it works on all kernel (builds) available in the universe. This is als=
o=20
why we write following in each batman-adv release news entry: "As the kerne=
l=20
module always depends on the Linux kernel it is compiled against, it does n=
ot=20
make sense to provide binaries on our website. As usual, you will find the=
=20
signed tarballs in our download section:"

Either your distribution has to enable this module in their kernel build or=
=20
you have to get their kernel headers (and build scripts) and then build it=
=20
from scratch. And at least on the default Debian kernel, batman-adv is enab=
led=20
since ages - so no idea why PopOS doesn't ship it

> And if I need to recompile the .ko file for ARM, is there an online
> repository where I can find the original source code for the
> batman-adv driver?

This is mentioned in multiple places on the website. Just to mention a few=
=20
interesting pages:

* https://www.open-mesh.org/projects/open-mesh/wiki
* https://www.open-mesh.org/news/108
* https://www.open-mesh.org/projects/open-mesh/wiki/Download
* https://www.open-mesh.org/projects/open-mesh/wiki/UsingBatmanGit
* https://git.open-mesh.org/
  https://git.open-mesh.org/batman-adv.git
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

Kind regards,
	Sven

--nextPart2744519.aNBPxFQpTQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmKHRpEACgkQXYcKB8Em
e0ZtNQ/8DyOqWFO3wofGzocWo2N6ljG6aegSNMptVks4cVb95GxgYURCxFBRkKMK
buZnje6nqGOUs/29Zj+rJL17r4WnY1ewboufcFkyfJq+mxoUSH7RREWPEvw320BS
lQ1LQ5mXHtbxhYzFYJySIJ6Jzi6hmdsR2JCuqUTTSgh/NkA3c63SI2Y0ffrePcs9
aHg5OAUvZ3mo4ACgJ0RzEkla9w9afFBOcxsl/YnUPBGrq1jMkElkL9o8SwHUgpmB
hNHAuG36pvRRMNqJNLx9SxJPkXYaoqZlsnVT+cdu6Rtos/PyoF8e6oDrsUd/QRFD
cfGhf6q09j6TkqLrqW4+4zI/Is9UXQxD3l5wFV3Gw08reoo/O+ZLTj5AYjKW4u57
qH3hsY4/lA/9mEzWqRfXMXavQYPixnDLEiGM0dQCU1o36BXxjuaX/V93x8VNRrM4
ZFAyK1srLFFQrnIEkqNFIINK4z05GGBL67bkDcNYsbvk5iG95+YALQpwM1FtJfTh
7MFQ17FvLbpipPsaTPH71t0AnPRjHQmK6nfNerL2rZKA6MH6gBylqLt9z48N4fwK
4dXznaClhkhXAAFCXBBfJfcQZBNurae2xORk5wKCNrqCrM5Msn7/spbR75OwGDSd
udKFJtz053nYnCRVrbqcHYawTfnj1TLEqG6ZnUgo1GcwMWrwBdw=
=QtBz
-----END PGP SIGNATURE-----

--nextPart2744519.aNBPxFQpTQ--


