Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 13 Jul 2017 18:24:56 +0200
Message-ID: <1781795.uu9pZesUxg@sven-edge>
In-Reply-To: <20170712111448.30712-1-sven@narfation.org>
References: <20170712111448.30712-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4312718.Yc3DkGrqEf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Convert batman-adv.txt to
 reStructuredText
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

--nextPart4312718.Yc3DkGrqEf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 12. Juli 2017 13:14:48 CEST Sven Eckelmann wrote:
>  Documentation/networking/00-INDEX       |   2 -
>  Documentation/networking/batman-adv.rst | 220 ++++++++++++++++++++++++++++++++
>  Documentation/networking/batman-adv.txt | 215 -------------------------------
>  Documentation/networking/index.rst      |   1 +
>  MAINTAINERS                             |   2 +-
>  5 files changed, 222 insertions(+), 218 deletions(-)
>  create mode 100644 Documentation/networking/batman-adv.rst
>  delete mode 100644 Documentation/networking/batman-adv.txt

Just in case somebody wonders, this is really a patch against the Linux kernel 
and not against the batman-adv repository. The batman-adv repository doesn't 
require the changes to:

 * Documentation/networking/00-INDEX
 * Documentation/networking/index.rst

But it requires a change of the README link.

Kind regards,
	Sven
--nextPart4312718.Yc3DkGrqEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAllnntgACgkQXYcKB8Em
e0YYXBAAurSZEOWLnoa3MeNbM4k9EqFJQmYPXcMXctdPilB5kxnfO6HOr8GKLt5G
VqPC54rrHcGAXrORZ4PvIThhbNo/aipJph5b0ZSZb/YOrNRUyEm/8oQoQsS3NSLc
sXEFwIFmj4IYGhKN7R0PN42RzH2fZ6TfOaJOaoLOPPMzmqwZQOQwMl6iTu6XDZ/Q
M5nauoD0uAayccspNm58ohlkZ+unnQL3CHDv7ebZB4E8mHPyHptzh78kVISJae7z
n4rhFtCfa//nTL33gruHkqRG53NHLf0ai/TsZzLUW6uY1f9IqnwRdo/6rt8JlYI8
5u4UharOnqlWq9kKHIoLTPZ3MWanlWfeboKXTW/W2Q3uoA+VszoIWEDiiW+qPbir
RP5nm8e71/+Kzz5jG9bGtKmhOISbWBqXfpBXLDyk69fTcZroEcHfsOEmIHZrg+CT
ggyf2bsn8Trsel8F4RZ6YgXb1RXnvdt/ptp9Y4FbyV+aCcyinyWY/7H2zDRtBP4u
KX3n7RGOxB6cONI8DwNIVEEpxbJJWct0NyBY6TXmiZxGDkXM+QgGcBgP2inumWMf
LrZ/FIbi2Pqa0N7cVoFLK6UnSOwX7OPfe+atGm+0Or8NB4E40AJ/gQT0xxhfkQqf
ha5hEsNyulJJB7JMhTvucSiYOszFwxhe8KFxcxPMaTVY9RXHAuY=
=28T8
-----END PGP SIGNATURE-----

--nextPart4312718.Yc3DkGrqEf--

