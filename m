Return-Path: <a@unstable.cc>
Date: Mon, 6 Feb 2017 19:48:23 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20170206114823.GG12187@prodigo.lan>
References: <20160905112029.32533-1-sven@narfation.org>
 <2104576.qJKP21On3P@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xUq7mlTLx96rFlBf"
Content-Disposition: inline
In-Reply-To: <2104576.qJKP21On3P@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 1/5] batman-adv: prevent multiple ARP
 replies sent by gateways if dat enabled
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--xUq7mlTLx96rFlBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 06, 2017 at 10:56:25AM +0100, Sven Eckelmann wrote:
> It is therefore currently unknown how to continue from here. Antonio, ple=
ase=20
> provide a statement what we should do with the patches.

There were two issues here:
1) the code was not really following the kernel style and I started my bran=
ch to
"smoothen" it a little bit and possibly re-propose it to the mailing list;

2) in one of the patches I found a logical issue that needed some rework.
Unfortunately, I can't recall exactly where the issue was. I'd need to dig
again into the code. I can have a look later this week and let you know wha=
t I
find.


Cheers,


--=20
Antonio Quartulli

--xUq7mlTLx96rFlBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmGKEAAoJEJ6F1zG2JyOsX+4QAKKwJeSWgKRaMjiWL1NP9B4w
U/mE4cykbqdm8CREOpF8YlKHez5h7xQj/j/pI9Tr0WbAVaJZJO2kjddmY9jww26A
HYXnx5BEyIiPRrNQ6ASNsmbVP78xC6dqUhjwrvb6tDuZauqf/UVgksW2vtUYk3kv
b0ECnR/8Q8wdXZpGhmzPKJiTbbSWhkEjkAMNl/80vUUB9b+gQ86K1iVVtiohVf9C
TN+Qw+9VkKWN12RWu7uFWd9aDlZbbJ9EizOJKJhcU/KZ8vfTvAm3gmYD/NR2Ovke
V8G+vwJhOG0Jy7AudmthTutcp1WxABaJU9uM4eWEae9tbyY7uNTQoVjdzuwq85dJ
tjx1+KUWWLHOIFO/DLtSfW1tz1gDmWvXghTq8SViPsDyaSvL62obFy39QwtVLP5j
Siig6hF6fLR5SV2Jtt6c8HYkUpH8Pj9zo/wjkJtPwLPyUNoSSrYIK5+MkE8qtqD1
RPHFIWbfL1YXZmOVHZM3imtenyp7Jk40gFKXi6E0WLb81ruU+Vq1ClPh0WJnqj+q
9Q43t6wmraRX+0B38hCbVc3uk9fZlYkXcZdFzAjvA56uOXMfZfHhLuv+mmU3NRaX
vUfOfB0RPutS1MMnUeJUSh+AzuOfeKGDNSH4CBI9xfY7SNOdltktkYFflEj9+rpO
ITfFaPtGh7wTTVuajp7x
=yeZX
-----END PGP SIGNATURE-----

--xUq7mlTLx96rFlBf--
