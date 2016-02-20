Return-Path: <a@unstable.cc>
Date: Sat, 20 Feb 2016 13:28:40 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160220052840.GF5584@prodigo.lan>
References: <1455634888-29400-1-git-send-email-a@unstable.cc>
 <20160219.153718.442738962662787470.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <20160219.153718.442738962662787470.davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 20160216
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 19, 2016 at 03:37:18PM -0500, David Miller wrote:
> And thanks for the heads up about the potential merge issues, I'll watch
> for that.
>=20

Hi David,

actually I just realized that the patches that will create the conflict
are not yet in net-next, but they are still pending in my queue.

At this point I will wait for you to merge net into net-next first
(there should be no conflict at that point) and then I will rebase
my pending patches on top of that.


This should prevent you from dealing with any conflict.


Regards,


--=20
Antonio Quartulli

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWx/mIAAoJENpFlCjNi1MRwBEQAIDXMq5STK4n8ASouQ1SHc0w
xpvmSOEVPe9pdvw59quDCQvYefXJIwBf4rAAgw9qoJVcsMQSSXXz+LLSXI5nyrRj
oBpIJ4W+yqjwpDI7bKNvJ25tVGFLSEHjOlPGzrOwMekLlr8CaqOW1m2I7WOccIEY
uXRs2NfjTFlcIz0TE8iEmjyuMXx8z/q7jKC4KfEOtLHlrfCjfqajL4bMCvjKn+q4
rAVCQcsEWh2pPegsEHVD1EoUbnuGK4GFU6gR3w614qIFtzVXzufdjCzA3ccDfe2I
RmmhIteHAaaVQPp1PcFHE/R83bMDr5gsgPWGvOR2VUrLXK3TQl7XSaLRDCy6NHrh
4wrB/y8iW/pK7qeVwB8rM7YJoRIxqTXtxrwwuuOaiJchxr3bz6Lzt9hWEEnxLsW9
fmVnkJyX7sB87i+GhmmjtRsTqOQt+Z2rZZlq/gCV4L9Up2vfN6OS3JjKn11sbHYQ
qfK68pVT/4vrzOfbFmuFMpsUs0uvjeWAUjibFpdOH8FKDLj4ap/VQdjIXbpuBIB3
wxL0iclJS+gcqUjWLHdiAAiKU1ghB9f5mGcthcUjrvAeL0bjr2bff16ecofvrvJt
VnKuTalksrhleeuXYcShUJQfhLQnH+8UvQtkoI0m59oPZWazYGSxhKHrdpoXhUlH
s7sRhxpOZ5HkWmggR5FA
=7l/N
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
