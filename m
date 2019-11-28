Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Host endianness dependent DHT lookup
Date: Thu, 28 Nov 2019 11:15:44 +0100
Message-ID: <2234043.pOP8SIytGP@sven-edge>
In-Reply-To: <29e86b84-9f03-030e-8681-1d4a7b83bf0c@unstable.cc>
References: <1815609.duLnqLk4gF@sven-edge>
 <29e86b84-9f03-030e-8681-1d4a7b83bf0c@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22828417.gDNSA6WHKS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart22828417.gDNSA6WHKS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 28 November 2019 11:13:21 CET Antonio Quartulli wrote:
[...]
> Will you send a patch?
> I guess converting the VID into network order before accessing it should
> be enough, no?

Yes, I will prepare a patch. Just want to finish debugging another problem 
before doing this.

Kind regards,
	Sven

--nextPart22828417.gDNSA6WHKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl3fnlAACgkQXYcKB8Em
e0YrlxAAurzftI8oIpdkoL++VlAG637EEPFJfPxhu6oFy/uS7nd1kwFQzyua+iZh
JXl1reW6A75OAVS6X0o+XOg1748poGqYWLg7t8yfeJK8azj/OoEHvGLQdi+DQaN/
pt28oSjwlUVorbGZ+UQ3cR1cJq8rvnXoXZfyvVodV1L9owmitGkCgEQehVHFLFYz
dGm8sc47WsBjfLQWkC9noa0P3xxRG700X7+LduLlz1E5bi/lHeEgv13nL+g+R3OU
yr/9flnf8qsjBIuonURYOVscO827ltK26N6inoT+eYmhcD1QGU9bfUSlbE9nKqQr
wFBBMAlMEWo0W5k2KkzSLG8GdicZ0rwz3kBrVoqUjnrI6I9pLJ0wiw71Jy6v65GU
m8kUZYXUWbaIahdA8IyuTD5HaSEmzV/qlpnD+uIMt1YOyA70rASN6WCsmgdua1ki
oJIOmc5RRVuuHOiNwsTxk8V9O3rCC5PNs9XR5jwpwpE0dhBGV7wwgdiIR9oyD8vD
km/XdnHjY/UEqJ2Wn9e+RoMKnRjf98khg0QnwIXjshvhsYn6oMMcRJkvrYOrgLn6
JEAvTbYabDlJnElJL1hbvV5eYTotEoMgtLV2Gj2pr8OIOdLgymr9r26pAUgSaF6B
FZBGELUW3Z4U1k8ThF5mB1aeziLEmki00pNGVLDiTOYEcevRCfY=
=h7FS
-----END PGP SIGNATURE-----

--nextPart22828417.gDNSA6WHKS--



