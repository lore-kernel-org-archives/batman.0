Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 22:09:36 +0800
Message-ID: <2014442.qWOXX198dG@voltaire>
In-Reply-To: <558839E0.50201@meshcoding.com>
References: <1434904223-10227-1-git-send-email-mareklindner@neomailbox.ch>
 <558839E0.50201@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1950652.mse8Jt6G9c";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: convert
	orig_node->vlan_list to hlist
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


--nextPart1950652.mse8Jt6G9c
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 22, 2015 18:37:52 Antonio Quartulli wrote:
> On 21/06/15 18:30, Marek Lindner wrote:
> > Since the list's tail is never accessed using a double linked list head
> > wastes memory.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 8d85d13.

Regards,
Marek

--nextPart1950652.mse8Jt6G9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVkAAjAAoJEFNVTo/uthzA+nIIAKSWxF4YP+cEyjkhySi55h+v
rvtawWFAnsYfqsH8B+S1/ybSZgqFwNLSK+m4gA7uUpK16jvpOUwf+Akg117QXJ2t
JAQxsEZ5Pcsis3JzjeGau/H6WPhqg1cCH1c4rZHmF/QOZ7cbGxTh9arX0w+7DhsZ
qvf7PLjL218gEKeLms9Xz0VxBdxj5Rf+AEu4DCnZPpMrfvsVEOl3PIywYh2OPWsf
AADjbKvOJaxkDMaXweiCoChuJnBuPRinzCMXrqBnhKQ3+U3Qv45CIXbOQIDsL+69
LdHgZxoqF8Ip6VchE/kBirvr+5cg8Tz66QdXfz5bSVgv05YKv536IBT7Otx0nfo=
=cJrh
-----END PGP SIGNATURE-----

--nextPart1950652.mse8Jt6G9c--

