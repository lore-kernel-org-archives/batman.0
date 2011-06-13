Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2011 16:30:51 +0200
References: <201106121152.02177.sven@narfation.org>
	<20110613132507.GA18690@ritirata.org>
	<201106131629.19141.sven@narfation.org>
In-Reply-To: <201106131629.19141.sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2634892.rDALUGgNrj";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106131630.52328.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Combination of flags in tt_query packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2634892.rDALUGgNrj
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sven Eckelmann wrote:
> Then you say that you don't use flags but 2 bits to store 2 values. Please
> don't use it in your code as flags, but use something like (x &
> TT_TYPE_MASK) to extract the corresponding bits and compare the resulting
> values against representation of TT_RESPONSE and TT_RESPONSE (TT_TYPE_MASK
> would be 0x3, TT_RESPONSE 0 and TT_REQUEST 3). Also remove the TT_RESPONSE
> and TT_REQUEST from the enum tt_query_flags and use another enum for them.

s/TT_REQUEST 3/TT_REQUEST 2/

1 and 3 are currently undefined.

Kind regards,
	Sven

--nextPart2634892.rDALUGgNrj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN9h8cAAoJEF2HCgfBJntGPGkP/ihAoQk5HHG1qeb1ljwPKNq1
/rhJ6mGjzs55l1BZeg0vwPPlyNltooE8Ep/Y3EawzjepzBJBusH1ZkmwO3xzfHzV
1rPgPePjjTXnXMizWRJQzJ6nafHT7/piwbPZ0hd3ijwrw3TIIaD7tD9TJfkB9UA0
s90jZPmq9hbuzrmydtDv1cZlKj23g4mnCkINlpetNPUftRUL7l7dUcsrUgPZVxuz
nG/zFXI59MMzdIPXklby+q5/fyPF43Y6ADZlPt/RaUYnY92lMsk7C//IbY8Xiy/F
o8pfwBLqpz5b3iFzo66fkjjBiH4QMaI1+6n2KJgzmC9P45XqNUe/ll4Vwe1LoM4A
fMdvoClbqK82ymJrGICVgdvkG/5Mp4OCM0H0Xk+7bgN+5keGXyn21lYe/csS9sjN
xmzdP+d1v0VAIrq+bFmk6s0rM8rnQUzMjSPCTKHMXe4JncYFJs9S5TNfG6NPXC/V
nFqsvhYNwF9L/PQFZwmBIMaorfD3zTOzakc8puNsZtNjkhhZjVXozRYGJDy0muOw
DvID1CRpL9adommax35dBn+LJchfbg+AZl6pHM61rxqPsPm6x9MAU8/nzpj1hMnt
82rgjngO7ZRh1b7j3ZkVclXMO7I98tiz8VHbXr7kD3kzNPbB9fB3c0I3ZSbgPXOo
VeWetqbGUBUcIN4oyiPF
=kuGr
-----END PGP SIGNATURE-----

--nextPart2634892.rDALUGgNrj--
