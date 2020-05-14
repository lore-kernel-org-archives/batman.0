Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: WiFi chips/drivers supporting IBSS/802.11s
Date: Thu, 14 May 2020 11:39:22 +0200
Message-ID: <2392919.NNVJBL4L6o@bentobox>
In-Reply-To: <CADSehqPoEQGqdURG0g8OO85Dvb5dL0eExwG+-9uum8=wz9VXsg@mail.gmail.com>
References: <CADSehqPoEQGqdURG0g8OO85Dvb5dL0eExwG+-9uum8=wz9VXsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2043141.RrgemjlQgN"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Maksim Iushchenko <maxim.yuschenko1@gmail.com>

 
--nextPart2043141.RrgemjlQgN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 14 May 2020 10:17:07 CEST Maksim Iushchenko wrote:
> Hello,

Please add subjects to your mails. Next time, I will just reject this
kind of mail.

> I am creating a Wi-Fi ad-hoc network based on batman-adv. I read that
> batman-adv is able to work with any types of interfaces, but I still
> have a question related to ad-hoc networking. Will Wi-Fi ad-hoc
> network (based on batman-adv) work if Wi-Fi chip does not support
> 802.11s standard?

Hu? You are mixing stuff up. There is traditional IBSS (often called adhoc) 
and then there is 802.11s (meshpoint interfaces with and without an integrated 
mesh protocol).

> Unfortunately, there is no mention of ad-hoc mode support in
> documentation of many Wi-Fi chips.
> 
> How to check if a Wi-Fi chip is suited to be used to create a Wi-Fi
> ad-hoc network based on batman-adv?

Check for "valid interface combinations" in `iw phy`. Here for example from an 
QCA955x (when I remember correctly)

        valid interface combinations:
                 * #{ managed } <= 2048, #{ AP, mesh point } <= 8, #{ P2P-client, P2P-GO } <= 1, #{ IBSS } <= 1,
                   total <= 2048, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz }

You can see here that it supports a limited number of mesh points interfaces 
(802.11s) together with AP interfaces. It also supports IBSS (adhoc). Just
keep in mind that there are a lot of broken wifi drivers and wifi firmwares
out there which claim to support IBSS/802.11s but fail to reliably receive
or transmit over these interface types.

> For example, is ATWILC3000-MR110CA an appropriate chip to build a
> Wi-Fi ad-hoc network based on batman-adv? Or maybe you could suggest
> any another Wi-Fi chips?

No idea what it is.

ath9k based chips work good. ath10k work also with ath10k firmware in 802.11s 
mode. Just make sure that you disable mesh_fwding when you want to run 
batman-adv over an meshpoint interface.

Kind regards,
	Sven
--nextPart2043141.RrgemjlQgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl69EcoACgkQXYcKB8Em
e0Y3mBAAoEcpliYMgnG8075sxsz7b7Hj2IHRkp18Y7fQpJSTdW5rv/DiXND3tYNk
90tPuT2UhcscdPAp8uOcIUxy495P8rQ3DlYXnhqxJFfw+D49etSRakUa32U3jXLx
bw0+KK95BZlAVYighSuvGYE7SYPp8rRMJdcH0fA2rmxLUE+qmMbhPZ/xoJdKuBgk
2hz3NUhf5r95HWU2X3S9wpCoKz7UE8I4eEHKT8ca9U7CNl/NW0xr8yujDi81uMHf
nE2VYf7Ol/FtyHbbB63NQ2YnN8iPHFIneUIIRF0Tzvd5m8V+LvQPWaTqSsxGOKVq
I6LWhUf5S3gRlj5OAK8DJYvthVXhBMYmlTC2so/T3+HC1cPSuIYFT7zkAyZB2wa9
ZiyJMCf95TS+f04ZSBG8rAnh+h2PyvdfE+sZfKvjvdiO8yvGFFZq5I7rKO4fgsic
LQto6VzVUlMu+5yqDNxsDnuV9qhgwW8t4AkKQ8HvfdYDBAlEwp38ffqAGtrVPL5N
QUuti1nle2UjvDlYX03J110L19dRuTrsbi4LTT3FOfrRgRHgpUmyQIe8Yh//4mjR
cSk4xwnRNL9C9ZUzYdDsyudNJ74N5n0wFAodx1VkxzcASncCSSMR9O1fm+7+heeo
zt/RqKUZO1RryRkfl6BeBtHREbHxlgPVnJZ1wtMif+fB5idreZM=
=dWsM
-----END PGP SIGNATURE-----

--nextPart2043141.RrgemjlQgN--


