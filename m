Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 20 Apr 2016 09:39:08 +0200
Message-ID: <243525463.WEoUOFbSir@bentobox>
In-Reply-To: <57173083.6020305@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <3565172.dz0c0eMaPu@prime> <57173083.6020305@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7652408.dfNstchSho";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
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

--nextPart7652408.dfNstchSho
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 April 2016 09:32:19 Matthias Schiffer wrote:
[...]
> As I've mentioned before, regarding the batctl support, I'd love to see a
> little library ("libbatadv"?) on top of libnl that could be used by batctl,
> alfred and other monitoring tools (like the ones we are using in the Gluon
> Freifunk firmwares).

Hm, then we would have to make everything ABI stable. So we would loose the 
flexibility of netlink (adding more fields) again just to keep the library 
stable.

Or what kind of functionality should this library expose that can be easily be 
kept stable?

Kind regards,
	Sven
--nextPart7652408.dfNstchSho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFzIcAAoJEF2HCgfBJntGQuMP/29+qCYEpc90ht5FVDkBgE9i
uZHcXWB/rATmkwYUjlATpYgeDLODV40WRJLg6PfVCRiw615e76Z9T8Dw+woRb8H1
EGnp7P6nI5emNtmkbuOlfWVeDjt/leOFPOQ+EiAJ673YEk8I7TtaSSpqHwtjnuYy
MxMirn1PY472qREp+qaqmB+Lnj1xlGq5zi+D3odemfMJ5HTo8Qd1sYBoO/LarQ++
UBo532oyW0gcww+pWJ8ac7aY2VLWRMwnfeQiLc9yA58Dn9pSzkONQzWBHu0dwKOc
mBim52z+fLSuhriqezxesWFjFoeHqsRGQT3lWKw8058qqAHIg34wUoJx5wk8nTA4
/ZL0928nWeDvZVu0lUWWN227Fq/497e/9WqdNmmn8CTCyxJOsOXuyy/dUcmjDRNt
n8LhDTmHOknSW89ea2jno6TSVzZ2Xoq+njUy8+3Poo91LXipTl3t83RRMUCu+PI7
Gv7jwkQDiIQwIkIB2619dQRcCnDnJ3VCiFGzaNs8doSJMuTp6LlwF0wUdVORfQBw
r1ViK9FpbrRV0bTUSQFZyGA8L6h1KrBFGtr0v4tX4/SUITRGN4DzSbX8Py2LGiwf
RT5qC77LOCElT+ZXmehiQA38ADDCsySqXvotI9eIEQma0S2V5MeYOZkVoHMe2lCa
+FnO5E+4/5FNEmeZGwHx
=S9Dr
-----END PGP SIGNATURE-----

--nextPart7652408.dfNstchSho--

