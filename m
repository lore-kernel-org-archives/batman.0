Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Host endianness dependent DHT lookup
Date: Thu, 28 Nov 2019 11:01:24 +0100
Message-ID: <1815609.duLnqLk4gF@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2061994.47J4SoBXhB";
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: a@unstable.cc

--nextPart2061994.47J4SoBXhB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I just saw following in batadv_hash_dat():

	key = (const unsigned char *)&dat->vid;
	for (i = 0; i < sizeof(dat->vid); i++) {
		hash += key[i];
		hash += (hash << 10);
		hash ^= (hash >> 6);
	}

But the vid is in host order - not big endian like the IP part. So the 
batadv_dat_select_candidates will select different candidates depending on 
whether it is a little or big endian system, right?

If this is a correct assumption, then we would have this problem since 
3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan aware")

Kind regards,
	Sven
--nextPart2061994.47J4SoBXhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl3fmvQACgkQXYcKB8Em
e0aLIg/+PF29YIOfDRsKe19X2mQUEfd0xyAnfZysdI2y96JJ9Qj481P/KlszUkTD
/GwyiOQG/trh8KTNqnYd1xzYGALfURIENE8N/4yp73RJG25v3jpdfzi8qoV/FLpD
24lppW2aVuBGR3vvL9oUszLpUsgH8zbf9Ng0JAqCGVka2FBVXRCAA/hcbeazZ9OO
0pMgXWeR4x+sgadboOGqruBq+dRSdexC25fW/S3DQViMeU+HKTtn8bFcQeTtyrCL
vdOkffUvoEA42z7k3q8w6ziVp5kYdwzGdTeCfbkAAOydP9LcndroG2HE1/rp1BeX
5+5zTVvrr+YY/2OErtzQ3+zbO2tzoVhp6m6NZ9kUqhTnj/tCctUyK5CHKjUuVFn7
7qUTpktV45lQTB627pH4OyviikfQ1CBxCrBGR9LofT9JGIPjNJD5BSQzv0in/Zx3
hWrDyTrZWxf6yFs9MhfxfCeInFMx0WrFyYUlPik2+feUmICH+9rfIK2J+xgrl3K5
QbFf/neXNb0MRyje5xlvwPjrLzd+WGMODlzUcuokVNzgaDhNApedPZwlxrPCYRrU
JV4qJuMj3zv0e8sE/Sk/isKImWjUeyOdiwIxnnlqvdtsADOH/BPc8G25lB5kGzG0
5hQ3pDYDrWjfmWQcBpBNo6szkR1btrbIqwEKUFyLS4Adh1am3r8=
=iTzo
-----END PGP SIGNATURE-----

--nextPart2061994.47J4SoBXhB--



