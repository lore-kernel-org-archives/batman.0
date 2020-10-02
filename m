Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
References: <5e4c619d-bdb1-2fa7-57cc-e5d71ea13f08@kkk-web.de>
 <88928628.8v8VXxemU5@ripper>
 <998e8a9b-e0c6-babb-0b45-5fb3fb657a32@kkk-web.de>
 <5095353.evS3lK4dNX@sven-edge>
From: MK <mailing.m1@kkk-web.de>
Subject: Re: Does batman choose DHCP server by random?
Message-ID: <4fc7de29-7692-58b1-994b-4a3d623c075a@kkk-web.de>
Date: Fri, 2 Oct 2020 10:29:16 +0200
MIME-Version: 1.0
In-Reply-To: <5095353.evS3lK4dNX@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="FFStS5iMlo6naDDlVAdbiYGnLrDype3H8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

 This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FFStS5iMlo6naDDlVAdbiYGnLrDype3H8
Content-Type: multipart/mixed; boundary="vSr6jqvnit99Adj2lgEx06gCpuxWSLwsm";
 protected-headers="v1"
From: MK <mailing.m1@kkk-web.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <4fc7de29-7692-58b1-994b-4a3d623c075a@kkk-web.de>
Subject: Re: Does batman choose DHCP server by random?
References: <5e4c619d-bdb1-2fa7-57cc-e5d71ea13f08@kkk-web.de>
 <88928628.8v8VXxemU5@ripper>
 <998e8a9b-e0c6-babb-0b45-5fb3fb657a32@kkk-web.de>
 <5095353.evS3lK4dNX@sven-edge>
In-Reply-To: <5095353.evS3lK4dNX@sven-edge>

--vSr6jqvnit99Adj2lgEx06gCpuxWSLwsm
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi Sven & Marek!

Thanks for your help. Find the client side config down below:

$ batctl -v
batctl openwrt-2019.2-3 [batman-adv: openwrt-2019.2-4]

$ batctl gwl
[B.A.T.M.A.N. adv openwrt-2019.2-4, MainIF/MAC: fastd_mesh/ (bat0/
BATMAN_V)]
  Router            ( throughput) Next Hop          [outgoingIf]  Bandwid=
th
   (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
   (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
   (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
   (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
   (        1.0)  [fastd_mesh]: 10.0/10.0 MBit
*  (        1.0)  [fastd_mesh]: 10.0/10.0 MBit

 Star means choosen gateway?

$ batctl gw_mode
client (selection class: 5.0 MBit)


Regards,
Martin


--vSr6jqvnit99Adj2lgEx06gCpuxWSLwsm--

--FFStS5iMlo6naDDlVAdbiYGnLrDype3H8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE9IPOuVyPsFfx2iJ9cNiJ0EN5ao8FAl925OgACgkQcNiJ0EN5
ao8flxAAluJshwQY5pMOjoytIClyh5rlk+rwf8ge230OyaR+Kg6qmkHZEL69sNiR
4QWe7rPCPR06OrDHDKYLJ+/kulrqsElc7zmEUAmIwF9bqk+oO2hU5dRfI+897AG+
/9f3YhPf/9Pgz283OUDD01CR/Dqn8nLh6KPQtStbsXf4c72omOAZmoLPwlcZQb0Z
at91uCMnZLeXI8Cz4kZ6NGxDVO/OFSc5HoAtFjok8fjscD+AJhiCQYjFlfC3K7RI
Fv5MzizSBrCjBDrDwLy2xOi3LUm97OcIUtqlz1KYLHoO7DhPBhREvAjhbIQhYaoS
/stcmpN+zqh7cZWYmvmwuJjJq0HCiwD/4ET5uoASplkBIAPQDyuqrYTVF/e64STD
ZPzUNQDH4W/3tYKzghUZBrzHV3nk1cUKEbYJFKDUA/pqzKeDnjZYmgPT+B/mhKfP
fZAn4+yXh/n0gkNblZaN28/5jNyXmo2LvUupSQUljV5MWnmvFkpmwOuKhUhA1EIb
SSDt4efPyWGp5jIrn+t8GmRvX6eSFt8lz1Y7mJyhitfbkcF5+o56f9phDGH4egPt
axq7N/66rHwX6/hp2P3VYNcRVpW6wuinr3OAeDVCDXar4ifwT4518wX7UvQkq/yR
ZXe/2jhIFcIbA/qerTe6GmTVrIpOG29Rr4bI0CEzxCb8/Q+F1RU=
=ApXj
-----END PGP SIGNATURE-----

--FFStS5iMlo6naDDlVAdbiYGnLrDype3H8--
