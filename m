Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 24 Oct 2016 13:18:22 +0200
Message-ID: <2151701.jMsebSiiDR@prime>
In-Reply-To: <2403515.P9aVkiGJpp@bentobox>
References: <2403515.P9aVkiGJpp@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2274107.Q6GxXk0I0S";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 0/9] batctl: rtnetlink interface
	manipulation + userspace icmp
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

--nextPart2274107.Q6GxXk0I0S
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, October 18, 2016 4:16:39 PM CEST Sven Eckelmann wrote:
> Hi,
> 
> I had to merge the ICMP and rtnetlink patchset [1] into one single patchset
> because the two remaining ICMP patches depend on the rtnetlink query
> functionality. This is already the biggest change to the patchset(s). Other
> minor things are:
> 
>  * remove patchset already in master
>  * rebased patchset(s) on top of current master
>  * changed __unused to __maybe_unused

Applied in 60e519b..4bd751e

Thanks,
     Simon
--nextPart2274107.Q6GxXk0I0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYDe3+AAoJEKEr45hCkp6h5bcP/1zKM1AMK/3tBcOW3HokhY0l
sXXCBCGKssp7VLJuxnzb+H+6gG/GvMp7Yc+58OLzqw+XAlyJgGj3teoc2F4O/7Sc
ca60U+iAnxwsdx35YGlfvks+2gE4XFFCis5KNsItLh+K8qzl+y9U/lsr1B94KX0X
eZRYp9v2z9ylTO0dXBnSUOvHS/Ruvapm6TEvZPr68SIHA4uNPNYyNg+bWmRnpMva
MYp05SsvvCbeX/8o0M9hvjP6qOPVuXL971jefcTUfpl05btv7N9nF2SFM3i4dLrA
bAM3bvkcw2WhVh5i0itBnRrB0/1ZyeQ09R+LmeTE6v9M5CxlLt19CZJ7IRskDH8U
fm1jLlwraZwQ2BS9dmdY++t0aBKSQj19L/C5smpUjuNyY3m63Tut0JHGhxEsPuKw
JfybkZv8/RsXteh64or849ztBVDyAeEy70QVr2UhQPJHHaO7K5dz0qfMwmuYFFlW
r7EgIx6laUTtmjy78+DfxVjR+5BBafitgWJeyVlzs28+B57G6KaXoneqkoOysawN
AcJwyx+sjZOq5JXuvM3BYBvJ00ORRuOOwomx0jkKxntVqCXWU/SUgmc/NbtmqYDh
uiM4tSHcFh7c/ILchYEQNnb1hvMh4TdB6fW0TW172/IwYmzFUtQwYMdWUTnbv9ph
QKyHzMxMXUiSlGeuhVlg
=mjpU
-----END PGP SIGNATURE-----

--nextPart2274107.Q6GxXk0I0S--

