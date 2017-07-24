Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Jul 2017 23:18:09 +0200
Message-ID: <13899415.9hl4lahuAs@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1832308.2Ql9foS9Tp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/2] alfred: Use bitmap to store dataset
 change events
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

--nextPart1832308.2Ql9foS9Tp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

the --update-command implementation looked quite memory inefficient to me and 
I have therefore replaced it using a simple bit map which stores in BIT(i) 
when datatype I was modified. Here from the second patch:

> The implementation for --update-command uses a double linked list to store
> the detected modifications of datasets. This implementation requires 24
> bytes (1 byte data type, 7 bytes padding, 16 bytes linked list pointers) on
> amd64 for each element of the list. Each modified dataset type requires an
> own list item. Each list item is allocated using malloc and therefore
> additional overhead for the libc allocator information has also to be
> stored next to it. The list head uses a similar amount of memory (16 byte
> list pointers, 2 byte counter, 6 byte padding) but doesn't require
> additional allocations.
> 
> The list based implementation provides information about modified dataset
> type and the order in which these modifications were detected. But the
> latter is not actually required fr --update-command and can therefore be
> omitted.
> 
> A simple 256 bit wide storage element (32 bytes) is enough to keep the
> required information when only the detected modified data types have to be
> registered. BIT(i) is either 1 when dataset type i was modified or 0 when
> no modification was detected. This removes the (de)allocation CPU + memory
> overhead and avoids list searches when adding newly detected modifications.

The bitops.h file is used to implement the bit operations and keep the details 
away from the server code. I've reduced the size of the header file a little 
bit because most of it was not used by alfred.

Kind regards,
	Sven

Sven Eckelmann (2):
  alfred: Use constant to define data type range
  alfred: Use bitmap to store dataset change events

 alfred.h |   4 +-
 bitops.h | 379 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 main.c   |   9 +-
 packet.h |   1 +
 server.c |  46 ++++----
 5 files changed, 406 insertions(+), 33 deletions(-)
 create mode 100644 bitops.h
--nextPart1832308.2Ql9foS9Tp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAll2ZBEACgkQXYcKB8Em
e0ZwEw//YSlzVayLTRECN4zrzOuba/ECP1NX87BSliuYUDNz4390Zn7zg5bvFes1
itL50Yc5cDDruZDJaMZIOIkJ5kGxYha6r9IqxbjiU8oqN9PmdgxRrDA1tWtADQqx
YJXBiom2Ia5PAmLBfUh2h7QeITPFFtg506mMXzmSL0gQM7gyDIfydg1ZSA1AdWX8
zRmrzaZgiy8mJjjcXmnZC1tLZYR2ZB504Z11C7Jr9O1n0LIkYPob/3CkcqgTi2vW
rGw6L6gj+iMNh2A6DvmsZpR1Ro+A9tWMjtOz1hU2oBTh2r6lSqAwZ7k8q84otAPy
wraPUB3/1Cvz98lv4nXwDahPXIgC/GSTBe/MP8ba9aIiRnzp7aFuHUOMlauX50mf
km024BQz9o73GgSdwlbpVytAsNRXryaxOQwjTWnhOUOu2Tcob+7zDpyI2XMvC0Up
neOoCvRCgmk5upT+Wfu8wue5XkqPFVlEOC5vozDu3pi5wferYYtN5Rt78T1ZS4Sl
WZfoUp/4Cyr0zKCiE6mdVhj1RRmaLKqwqzNzpTvdTEbJaGpNVWuXpM3W8S2nHQRu
KziU2mJ8BLlwpxqldbMHATs15VbiT391jrNpYPMdzr3qghZi5X6GYvqV9byPCAmq
dgNUhxFZG0Lf5E/xW5X9VbBaiXlOh4iwyf8rXqVMyufWCDBIJkc=
=kNGU
-----END PGP SIGNATURE-----

--nextPart1832308.2Ql9foS9Tp--

