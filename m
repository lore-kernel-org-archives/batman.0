Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 29 Jan 2014 12:45:46 +0800
Message-ID: <7324971.gcLLUq3Wf7@diderot>
In-Reply-To: <1390871207-431-1-git-send-email-antonio@meshcoding.com>
References: <1390871207-431-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1556495.0qG3ZzzxTP";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: release vlan object
	after checking the CRC
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1556495.0qG3ZzzxTP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 28 January 2014 02:06:47 Antonio Quartulli wrote:
> There is a refcounter unbalance in the CRC checking routine
> invoked on OGM reception. A vlan object is retrieved (thus
> its refcounter is increased by one) but it is never properly
> released. This leads to a memleak because the vlan object
> will never be free'd.
> 
> Fix this by releasing the vlan object after having read the
> CRC.
> 
> Reported-by: Russell Senior <russell@personaltelco.net>
> Reported-by: Daniel <daniel@makrotopia.org>
> Reported-by: cmsv <cmsv@wirelesspt.net>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  translation-table.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied in revision dc08c04.

Thanks,
Marek

--nextPart1556495.0qG3ZzzxTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS6Id7AAoJEFNVTo/uthzA2KAH+wZnF3cbhx+P7LXfNiIY0Dip
UrV/8l59uCg09g3z0wqpVDTY4OoZGzYaYBgzBcqhkOPKRK2Vg/rPZbHxLuTjOerO
YB8aSuZVueAZhwJ7v7hunZB8lsY/FxLXg0prrTA2cXq9o2SLxmd9XU70ipw7dBTz
VluMQOr3kzT/hLxuWh1WdiVLZIvsBKXpzyrFnnunZp3Kse28Sg1cjNZ419I1g5e3
VowXS02Ym7CUMQAapaxmq/A63SA4RsI47FoVYlouTYJuWmwUdZ8r0hV7kMuLahxB
I8IMAiDN+qlrdBX9T90YiFiHAmzSj/dhRpXJTHZpFUnuwMj0EtGngGtadKLDRjk=
=53Np
-----END PGP SIGNATURE-----

--nextPart1556495.0qG3ZzzxTP--

