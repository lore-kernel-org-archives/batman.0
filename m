Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Dec 2017 17:31:55 +0100
Message-ID: <45864234.JLrqauQgWL@sven-edge>
In-Reply-To: <975dadcd-f5f4-15ab-7926-f7b4beedcdb9@altermundi.net>
References: <975dadcd-f5f4-15ab-7926-f7b4beedcdb9@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3693679.Sm7ZDba748";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] weird alfred problem
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

--nextPart3693679.Sm7ZDba748
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 16. Dezember 2017 16:08:24 CET Gui Iribarren wrote:
[...]
> root@giordano:~# ip a s br-lan
> 11: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> state UP group default qlen 1000
>     link/ether c2:4a:00:fc:41:54 brd ff:ff:ff:ff:ff:ff
>     inet 10.5.0.31/21 brd 10.5.7.255 scope global br-lan
>        valid_lft forever preferred_lft forever
>     inet6 2801:1e8:2::5341:fc00/64 scope global
>        valid_lft forever preferred_lft forever
>     inet6 fe80::d4f4:2aff:feb8:ce2d/64 scope link
>        valid_lft forever preferred_lft forever

alfred expects that the link-local address for the mac (EUI-64) is set. And 
for the mac address of br-lan, this would be fe80::c04a:00ff:fefc:4154 and not 
fe80::d4f4:2aff:feb8:ce2d

Kind regards,
	Sven
--nextPart3693679.Sm7ZDba748
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlo1SnsACgkQXYcKB8Em
e0bV9g//WsvUV9eE3jsq4FVtwyHoiYRFA9wZtQqXNz4w9UCF8XLjGC2VenxGZEqk
z96JJ3V6XJWx6JSNaTHNAyx7f9V0lCUzHvFzrc+TftS4/xVhMfzo1MMhw+guk8Tx
AIefswPs/mAJZr0RUChqTsMjU87wH3/XaSWov0ZM+J2BDMyBqS1qPKppcTQcS2bK
FbQoJELBS8XQ4ew5u0XCkg/kFXroW67IDninseIGy4M2Od8tBxEGiwrM7dAEISLj
Exk38pzfIdoFFUDL3F7MkhDVr9p6ijgg+edLx/bpV3pgYjQnWad6w2uD6yP1HAOA
3qu0Rb+T3B8xJA5TMv9u9wIiRoab9IkwQp7T5yjubkpIpe6fM9FQluiu+KKNc+ce
l7vLEj01pOHuaKtCYwvrzgxlRPEM5RNs43ndhvQAMtVKng44A89oztyIrctQJICX
XK9yMm8cHolxnY/RIEysae+6m3DApcLkwj1EBR7dEAcjpuijGAmDLBQ/xdAOwvxm
4azuZh2Dy9Z3TS1wOT9K3KywZqayN0WrXz0bb021wlgebm4xq25T2r05SM1rJo2d
AH0wAtcsRZLtRhkciVFFZhnHH0ntS14dQ3+muJB1u6llp9IJVuFtEZwBde6EuEVt
KmLYmJiQrm+2aVKswcwzT2QIkQHwT2NX9b9Oojn+M/L9dvjYHTI=
=YwDG
-----END PGP SIGNATURE-----

--nextPart3693679.Sm7ZDba748--

