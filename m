Return-Path: <ordex@autistici.org>
Date: Thu, 24 Jan 2013 05:14:03 +0800
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130123211403.GC10344@ritirata.org>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <20130123211137.GB10344@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20130123211137.GB10344@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix skb leak in
 batadv_dat_snoop_incoming_arp_reply()
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 05:11:37AM +0800, Antonio Quartulli wrote:
> Hi Matthias,
>=20
> very good catch!
>=20
> On Wed, Jan 23, 2013 at 06:11:53PM +0100, Matthias Schiffer wrote:
> > The callers of batadv_dat_snoop_incoming_arp_reply() assume the skb has=
 been
> > freed when it returns true; fix this by calling kfree_skb before return=
ing as
> > it is done in batadv_dat_snoop_incoming_arp_request().
> >=20
> > Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>=20
> Acked-by: Antonio Quartulli <ordex@autistici.org>

I forgot to say that this fix should be merged into maint, so that we can s=
end
it to net.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAFKbAAoJEADl0hg6qKeO8hgQAKG72GkV/F4bGceoLv2XMiTg
QJztM7rMqojTfKnnVgQ/H6XdtrFg+KXQ3BsSJOt0JMWQCFEeIoGTxs5ugmNCcMn/
aj3xZb9AIxiWlOvxL1n6asK6KnImeLSgCTiozN6lhBsff+CZs42tfz8cVtMuDTnO
JpDd2N060Rxp9l9xaW84yahEUtOeQo+9orfIAiDDKwL29ie8IjsD3dpKBkEpZ0nY
gtMUwiuzEjbGQRRqPohb1PlF77Gl1V+hVklVFXmJTHg227S2rJ/VdFJpkjU9qVfG
AxBZ3mm8rTFdGjZ8BUSp/zentidLiJrZCgCpNLqRb9wYPEbG/GUhBibe+KJ4VMZU
5lafTBNSpKP/F5IeGhecUzKMgAaNY6Cl3MjDA4sQt4xZhQNoFlXb84dvt7DweIOW
RT72Rn6RG4RlwTN5gS85RN0Im2Y5yKRjIavbyfySc9fm962gQyBB0KLgTjG4TC2Y
cSN7sljf21lwer6rckEdKKJYzQSfKpJ0twGFNvlroW9PMmamUICmcD4P3NGFihZ9
b/3GMaFhQvwaAtA5fHwrRYYxXs8HaX5Myf7qsO3cclU9s66d1Lgr7L7GkxYgLdDF
DxWkGFNlsxuKMELVmuFW3agJwwSZRAPjfiWjLqO716eTFjyfIsV6BkGptSjsMN+G
FtWhyWdjEbLfkn695Yv7
=egNv
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
