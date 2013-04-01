Return-Path: <ordex@autistici.org>
Date: Mon, 1 Apr 2013 23:44:26 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130401214426.GI4024@ritirata.org>
References: <1364852436-18056-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline
In-Reply-To: <1364852436-18056-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH trivial] batman-adv: make indexes
 variable type homogeneous
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


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2013 at 11:40:36PM +0200, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Please, ignore this patch.
We decided to always use a uint32_t as index type because that might be the
result of our hash function.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRWf+6AAoJEADl0hg6qKeOHHQP/AhidQreoVfMX/1Pg2mUn+lr
v14oNOl34TMWhTJa3i4eAA/l0b1PSkyrQzF1zaOggphIH8S3QieZMREBPGiE6FKu
RsNm39lyB6DiPXB2kf929WMIjzykATsgv9OhIFRi2wNjXjttWmc28pCyoeVfV+wx
/bgMhRNf4S5z7WPCtuUHLJcHGtUxcFC2KqG8VzcqYeLjFs6WygaWmSQFw5ZirDdS
I0MtRsAmLVO7lyj7QRf/zMGD3mjgao587wk+ohb5s1HzX2TPHK8m4Kn5mDb9c9NE
pEpn37Gb/8JGj57QeNPB8Mz6upms6A7RowTfTlUJt+bJa7M7hFnuUmIrHWW+AeKB
STX1RL8AytA06cp8DNGJM3HpM5y4LyzHLK4pn3eTOmOIPz82IMFA8F9JCGdfUIJ8
vUfFuix3rWsBzxy2v7KCV6++t0HShIf2tXA2c3iLsASM62Ix/sV2kVtNYSUucpQM
P/jL8dpqb+Zgz/Z/aODy1xV0DNYHgTz/sEs0w6MiRI/N5HJmtt6fDqSWN6i3lSeR
+RYyzVndZ7R9QKgZ+w2fB+1y429ZimQx8E3FLACm8F+iNMBnzknRcC9ht0ZM4wyI
aB49S9a8d9pUvpTACobqUUNtSgPPI63dnryy32xXJSXb2hyXKwxv4NMaLZe1OE0a
ZJb0nlD5f5XrWu+RUKNT
=iwDe
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
