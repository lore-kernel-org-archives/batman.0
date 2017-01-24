Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Jan 2017 14:39:10 +0100
Message-ID: <2809895.eiDvevZ9tY@bentobox>
In-Reply-To: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
References: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2429114.OGntAQ9Hoq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] limit of if per batman
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

--nextPart2429114.OGntAQ9Hoq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 23. Januar 2017 18:26:59 CET jens wrote:
> somebody told me that for gre there is a limit of 255 per kernel,
> does this also aply for gretap

I've already used over 500 (sry, not 9000) gretap tunnels. And I've just did
the same on Linux 4.9 with gre to test the 255 limit for L3.

    for i in `seq 1 255`; do
      echo $i
      ip link add gre$i type gre local 192.168.2.227 remote 192.168.3.$i ttl 255 dev enp0s31f6
      ip link set up dev gre$i

      ip link add grex$i type gre local 192.168.2.227 remote 192.168.4.$i ttl 255 dev enp0s31f6
      ip link set up dev grex$i
    done

At least my Linux kernel was not generating any error messages. Maybe this
limit was removed already?


> and mainly - is there a limit for if i can add to bat0 - since every
> gretap is a "if"

There is no artificial limit added by batman-adv. But transmitting a lot of
broadcasts over 255 virtual links sharing the same physical link
might get interesting (independent of batman-adv).

Kind regards,
	Sven
--nextPart2429114.OGntAQ9Hoq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliHWP4ACgkQXYcKB8Em
e0aeThAAu/iHiFN70rAdoRHZUJR2+o9X2VfTDvk9QICYHeWb8e1RBejBIADRIvX9
EJtnXkHMjxQ4wauk1Ku45OYSUdRoE/ogsyNCjv5btBrTZ2cTLAW5DgIUWk8wwzSe
TdjaOL21BRnt7QKSNqpRedtTlj6YMMbh7tjjIPlj6jMQrO7w0lhNVowgU5wiRbSM
JrpKZKhaaWsE39/ZF2m8a7yHThUktJ90dyerxfYjMrzyhgdb/5MmGHOFcKXEiQGV
lCYZY0sSTdB3a5bJHeAbePGjsr7ht5NE+D/JjhD/r7KVbj4ofIeZAtiTsUMfaaYO
nDXUuLm6ZqW/FKlSo11Z8gDuNodbOMEaQzVgqs8B0gpeGqXQYRuR5oxiGg+FEwza
qHVp+4wjKjIv5mcygB/nEgJu9FMbYsntqUtpvr0WwhURQznZz2IslgEaNtw7b+Z3
a8c8VAtPoFa2lK865kMkJCXOcQCehq8anttaD3bw7sS7pM/xAwMv0IgsfyJjjhhn
7eVrk9xKOqANd3bHIEJD8uC6uXGe3jJEnL42Q/uGcQ+E1gHjjUhLdI9mqWAv3n/O
CgQ2leoKNwUrzaCvyBXgqZyXZ6OI9xwO3patc7ObSsXDJ7P2Giss7lGQD/7lOcm3
iYduq6145S1CAXSFD5qHjLTbbRQXPl+5Dz2bEu4qPdjAKu4tWi8=
=HFxS
-----END PGP SIGNATURE-----

--nextPart2429114.OGntAQ9Hoq--

