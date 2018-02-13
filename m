Return-Path: <mmokhi.fbsd@gmail.com>
Sender: Mahdi Mokhtari <mmokhi.fbsd@gmail.com>
From: Mahdi Mokhtari <mmokhi@FreeBSD.org>
Message-ID: <839a5aa7-ed42-27d5-1453-6b152943d811@FreeBSD.org>
Date: Tue, 13 Feb 2018 18:52:51 +0330
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GTCBYbZZFz9JOoUUBVKQ67rO2JCnK1PZG"
Subject: [B.A.T.M.A.N.] batman-adv and/or batmand porting effort to FreeBSD
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GTCBYbZZFz9JOoUUBVKQ67rO2JCnK1PZG
Content-Type: multipart/mixed; boundary="6X1Y5IZNxzRLSH9ZNp80VQkCi6pmVdnxA";
 protected-headers="v1"
From: Mahdi Mokhtari <MMokhi@FreeBSD.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <839a5aa7-ed42-27d5-1453-6b152943d811@FreeBSD.org>
Subject: batman-adv and/or batmand porting effort to FreeBSD

--6X1Y5IZNxzRLSH9ZNp80VQkCi6pmVdnxA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi,

After some time of playing with the B.A.T.M.A.N protocol and
net-interface on OpenWRT and Debian I was thinking to use it with
the servers I use everyday (and maybe on routers/appliances I have
nanoBSD on).

So I started an effort...
(As a background) I already ported some applications to FreeBSD [and I'm
maintaining them] and
also I did work already on the Linux emulation layer of FreeBSD (FreeBSD
has a Linux syscall-emulation and Linux-KPI layers).
So my approach (as naturally I didn't expect the build of batman-adv.ko
to be successful as is),
was based on the approach that we [at FreeBSD] did to port Linux's
drm... <https://github.com/FreeBSDDesktop/kms-drm>
I ended up in adding some header-files to FreeBSD Linux-KPI (like
average.h, percpu.h, ...).
Now I'm at a state that Netlink blocks me and I'm to determine next step =
:-)
[Which I don't assume it being trivial with my current approach]

So I'd like to ask:
1- Is it better approach to "rewrite" batman-adv.ko [at least
Netlink-ish (let's call "Linuxism") parts] than what I'm doing now?
2- Any other efforts are being done out there?
3- is batmand deprecated [So I should mainly focus on batman-adv.ko]?
4- any other comments do you have? :D

P.S. sorry if I'm not really good at starting conversation from scratch
and out-of-nowhere :D
but I hope by continuing the collaboration we can have better (more
enriched) FreeBSD and better (as in more portable) B.A.T.M.A.N :-)


--=20
Best regards, MMokhi.


--6X1Y5IZNxzRLSH9ZNp80VQkCi6pmVdnxA--

--GTCBYbZZFz9JOoUUBVKQ67rO2JCnK1PZG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEESuhb4AjR3liB/CMeuAn4o9TFroQFAlqDAtpfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDRB
RTg1QkUwMDhEMURFNTg4MUZDMjMxRUI4MDlGOEEzRDRDNUFFODQACgkQuAn4o9TF
roSqhgf/YXSjAAgUIKJ64zWIDUSAhxv0KMmvqer5qTG737chjgz8Q2jPPePBRqZb
1x2GnjOk96SOdbQiZmnqODzPKWkJwjK+LXHPTKhuEjdnTPMbZD+WAlEgT5NbM8OM
mI9NGjDFOpwGgG48sKq/QkIF9LhFF/m8//FXMxata9Bh4PmWowoM4O4PQfGCn6WE
+F4z+blmzuBi62ymR8vYrrE5R92o9uo4q6lvfw0s8X6K27QTSW3eD9zzwps9YEu5
A1ZNNcTdTUr78/z/ykiIgEDww+oSowNgLm6BC+wqd1fXwCl4To4OGY97ZqJ14a0c
OY9cP4Nb4oibffHc5/7q+OO0SS+/gQ==
=vXUt
-----END PGP SIGNATURE-----

--GTCBYbZZFz9JOoUUBVKQ67rO2JCnK1PZG--
