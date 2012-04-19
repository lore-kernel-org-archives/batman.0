Return-Path: <ordex@autistici.org>
Date: Thu, 19 Apr 2012 07:49:49 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120419054948.GB8658@ritirata.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120418180837.GB6589@ZenIV.linux.org.uk>
	<20120418181058.GD6589@ZenIV.linux.org.uk>
	<20120419054113.GA8658@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20120419054113.GA8658@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman: don't bother flipping
	->tt_crc
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 07:41:14AM +0200, Antonio Quartulli wrote:
> On Wed, Apr 18, 2012 at 07:10:58 +0100, Al Viro wrote:
> > @@ -722,7 +721,7 @@ update_tt:
> >  		tt_update_orig(bat_priv, orig_node, tt_buff,
> >  			       batman_ogm_packet->tt_num_changes,
> >  			       batman_ogm_packet->ttvn,
> > -			       batman_ogm_packet->tt_crc);
> > +			       ntohs(batman_ogm_packet->tt_crc));
>=20
> If we don't need to flip tt_crc, wy are you introducing ntohs here? Am I
> overlooking something?

Ok. I was missing the correct meaning of __be16. Now everything is clear.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPj6d8AAoJEFMQTLzJFOZF4V8H/jTqofFNL46/wnHQDc0v9QsC
w56WPGR6vJq1bYVteSsNCJjm7l7nR8eOshx+uRGUEzUatmiw6KAnpPTO06ItbHU4
bvchu1pKIvbDqaNg22HwMVSKfTs01qtTnPY7o04rn4Wyp0Hc+yixbzfrzQnfxHVZ
fJWpJIs2Z27HE/2zwLN6QiFCG9TeXMKAyosezsaoQiHZ8v0Lz2mGC23yDyE+jXdR
FHDrrTFhJ6jSA4K6pfgZgd96cIwCSxRELdMHNVmLabeAObBIPICVHCOLmMS3jqNT
SxZYE+Cc25SzSL69DPs1T1LB2YcitfTsQF3wpmdEgc0B9CgSf55k3YUqBDatJeA=
=6YDP
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
