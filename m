Return-Path: <a@unstable.cc>
Date: Thu, 16 Feb 2017 23:13:48 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20170216151348.GM12961@prodigo.lan>
References: <20160905112029.32533-1-sven@narfation.org>
 <2104576.qJKP21On3P@bentobox> <20170206114823.GG12187@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <20170206114823.GG12187@prodigo.lan>
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
To: Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 06, 2017 at 07:48:23PM +0800, Antonio Quartulli wrote:
> Hi,
>=20
> On Mon, Feb 06, 2017 at 10:56:25AM +0100, Sven Eckelmann wrote:
> > It is therefore currently unknown how to continue from here. Antonio, p=
lease=20
> > provide a statement what we should do with the patches.
>=20
> There were two issues here:
> 1) the code was not really following the kernel style and I started my br=
anch to
> "smoothen" it a little bit and possibly re-propose it to the mailing list;
>=20

I pushed my ordex/bla_dat branch after rebasing it on top of current master.

Patch 1 and 2 are ok for me.

The doubts I had were about the rest, which is mostly about rearrangement of
BLA.

@Simon, I think here I'd need you to give a deep look to understand what co=
uld
possibly go wrong in the cases described. These changes may violate some of=
 the
scenarios fixed by BLA..

Could you please have a look?


Cheers,

--=20
Antonio Quartulli

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYpcGpAAoJEJ6F1zG2JyOsMs4QALpC9g4EVXLtBNMibRfceYD5
TWjbgJ/aWPKDE8MzeLdTkKNLoiw2Q+m13igW4IUGDbDnQrSLpinJ6nel7qhrGVK9
6baJ66wYMPIxKC//C7KOnA23FlicnqtFtm7lgpkJbXSayRKLdMl/OLfAOQQvx/+d
mPy9CMj9zKPZg/ylEjDWI1LXpCQrBSiLqrZs/oX2apY+4V4Jwxkh5Y1Dj6762J2o
vljLt5rkoTj7s74p30RcubvM/FJ5dNrO09iNg315xiPovJXlFFaEnA5R6qTCCGNX
PVWlLQfkfLtsF9p/0V93XknAf1RufzNwwMZuh7BCNaWxgqNf9rdj6oN7l6YDicJt
zLMLo7u++6Y7IFWE0ZXot75/zzPt1/giGNGOG/klH7ZFhWaUpnhjNOzxUtRJuwf1
zPepRU6Dd8mrk3dj2uCrpD96m6rDfu9RdOPVzXLyk/Ruos6ZScAHjdF66QRb+y/F
5OM9BOw+QSXCnwS5zxHae0DMwayzJHtkugFMjZEu+WpKmsZ3dhN1N+sHB8yfOXvY
8p7QwLedh3oLoFgRzeR8OMkcXuBVZGaeFsW2Zyo0MWCY4fjQqnU5W7bCGmfAS3ey
mB8f+fZiZcxRQSLsEpuLUxlNAiQn4vuSxNjL7IvpddSvWPCWT1gio8dVekTLBadO
1D+3zmc5rnoIywoTaghm
=aC/f
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
