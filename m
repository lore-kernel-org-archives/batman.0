Return-Path: <a@unstable.cc>
References: <2457136.iz2mu7y0Mc@voltaire> <20151231110712.GD30632@otheros>
 <20160109022925.GG5675@otheros>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <56910E6F.6050307@unstable.cc>
Date: Sat, 9 Jan 2016 21:43:11 +0800
MIME-Version: 1.0
In-Reply-To: <20160109022925.GG5675@otheros>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gtEbugmQa9L9vvKvq7SFktuqTPoGlp4Vn"
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. V leaves the nest
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gtEbugmQa9L9vvKvq7SFktuqTPoGlp4Vn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/01/16 10:29, Linus L=C3=BCssing wrote:
> On Thu, Dec 31, 2015 at 12:07:12PM +0100, Linus L=C3=BCssing wrote:
>> * Suggestion: Change "If the OGMv2 sequence number is not newer or equ=
al
>>   compared to the last received OGMV2 (from any neighbor for this
>>   originator) and if the throughput is not better, drop the OGMv2"
>>   to:
>>   "[...] (from the currently selected router for this originator) [...=
]"
>>
>>   (-> is another sequence number check here redundant?
>>       see "Age check above"? maybe some merging+reordering here?)
>=20
> Another issue I just noticed with the according sentence we have
> in the spec right now:
>=20
> Bad news never travells:
>=20
> We would ignore updates from our selected router if the path
> throughput got worse - even if it's a new sequence number.
>=20
> * Add a branch: If seqno is new + from currently selected router:
>   -> accept (even if path throughput is lower than with the previous se=
qno)

I think you are trying to say the same as what is written - just
reverting the condition to say "accept".

The spec says:

if (NOT(seqno newer or equal) AND NOT(better throughput)) then DROP

Therefore the statement "if the OGM is newer then accept it" is part of
this condition already, no ? Moreover, correct me if I am wrong, but any
new OGM should be accepted at this step, not only those arriving from
the selected router, hence your statement would be also a bit confusing
imho.


Cheers,


--=20
Antonio Quartulli


--gtEbugmQa9L9vvKvq7SFktuqTPoGlp4Vn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWkQ5yAAoJENpFlCjNi1MRS3wP/1qfloc2ZYbRB6CDnCYyD5Yk
r+mS94Htmp06djMp4WvUgAv9NWL+8yKU0vpTHoYH05iB8QTSK6v62V8yo0Mlk7ke
8w9uezophm4NoBrmVRtVTtLAJnhr7EqAey2V/qJKk0mKZvvHsTfmIoS9C/QNfPAX
lRs3b/XoHu8ARnQhKSlxw3ApmmTz+5Xx7gILelXD4H6sSFGhBZfx2v8oeLsRFeZD
7f2d+k0eBiICTNYMJ4Dh/GfJcTnKhC/l+0ODB86atYtN4N9xOfjU0Rz9Roe5RrHR
KrAdRdWKhMXCp1VNx+oN0NyjKpMZlkuNIm3+EGznecuEnBAPdeiY0OnjzGv/n2O+
GlRxwLBZRe0S32Hie1FAqbXzGOJkIzThsTLyQod79fmMojxLlELLDNjZxcjWM4Q/
z1mrrOPAyWkxW4ySMxBGhpIIQgOkfVCj39BY/Yr8kcF+bK0DJTPEhoRFqimsVk2j
hWfLL0TXoml7DvEm21SHwrZZIiUCea8UedGij+Wrb2CFXHshCVGJ/6B+PyjLnXkM
py5qZwP6jyL4ZtAGInOJwXIRgLqIvA3Xk8GbRsiE/Yf1AC0ts3Q6tfTPtxSHbw24
DIDJEurmVaczlwNFq4E9799rvC/9J9udnxGRLkAC2r4ZEhmCYbfrD6+l6SMt87AF
8CtUCNhKVq66OibAHEEd
=3eLR
-----END PGP SIGNATURE-----

--gtEbugmQa9L9vvKvq7SFktuqTPoGlp4Vn--
