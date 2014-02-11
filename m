Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Feb 2014 20:08:30 +0800
Message-ID: <2670752.qANzrjjk1Q@diderot>
In-Reply-To: <52FA0252.6040209@meshcoding.com>
References: <1392114403-4069-1-git-send-email-antonio@meshcoding.com>
 <52F9FD08.9040307@meshcoding.com> <52FA0252.6040209@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1763805.Vk0ulcAmUc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory access by setting
	mac_header in DAT
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


--nextPart1763805.Vk0ulcAmUc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 11 February 2014 11:58:26 Antonio Quartulli wrote:
> On 11/02/14 11:35, Antonio Quartulli wrote:
> > On 11/02/14 11:26, Antonio Quartulli wrote:
> >> In the TX path we now have functions that rely on the
> >> skb->mac_header field. DAT does not set such field when
> >> creating its own ARP packets thus leading to wrong memory
> >> access.
> >> 
> >> Fix it by always setting the mac_header after having forged
> >> the ARP packet.
> >> 
> >> Reported-by: Russel Senior <russell@personaltelco.net>
> >> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> >> Tested-by: Russel Senior <russell@personaltelco.net>
> >
> > 
> >
> > This patch is supposed to be applied on maint.
> 
> Introduced by 41b38727749a94c1a65cf0f4be9bfe1cbaf0adeb
> ("batman-adv: fix potential kernel paging error for unicast transmissions")

Applied in revision df99b07.

Thanks,
Marek

--nextPart1763805.Vk0ulcAmUc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS+hK+AAoJEFNVTo/uthzA+GYH/2eo0GBTfJ+TRdPR41CaE8Rh
vsjXnhXLyCGFSIYt/RFYjvCn2n3NaCcmV3Jz1IO/py4H2isUueCiZW8BtnfCO9ES
Mnznq38CPhshIK3SV5kvrfvK8jwtW0Bfs5XsiZtXcUCAiotlQBERQu1VxDuDJewa
FW0xNjQwOQwEAP8GLe1OsGs+zEEn3GtFdOHu64q7v+P0tHQJ5VpdbA2J7fp7V12/
tAR0Q4ZvY3Ql4hGHB8ly7KF95AZHRWtJZXl0WMVT1+eV7xkhe02IzyKacS/bqe7X
3u3UkzErOZ7x/hhw5TZGMKvvvociva2dB/bKuq2Cshb4O+wHucMq/B9nq23iz7A=
=OyAV
-----END PGP SIGNATURE-----

--nextPart1763805.Vk0ulcAmUc--

