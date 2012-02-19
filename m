Return-Path: <ordex@autistici.org>
Date: Sun, 19 Feb 2012 15:54:19 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120219145419.GB7006@ritirata.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
	<1329583133-11681-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <1329583133-11681-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/7] batman-adv: add UNICAST_4ADDR
	packet type
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
To: b.a.t.m.a.n@lists.open-mesh.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2012 at 05:38:47 +0100, Antonio Quartulli wrote:
> The current unicast packet type does not contain the orig source address.=
 This
> patches add a new unicast packet (called UNICAST_4ADDR) which provides tw=
o new
> fields: the originator source address and the subtype (the type of the da=
ta
> contained in the packet payload). The former is useful to identify the no=
de
> which injected the packet into the network and the latter is useful to av=
oid
> creating new unicast packet types in the future: a macro defining a new s=
ubtype
> will be enough.

Hello people,

I was wondering...what about adding a "payload_size" field to the new packe=
t?

The handling code would probably be generic enough to handle any future cha=
nge
leading to a more stable compat_version (instead of increasing its value
everyday).


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPQQ0bAAoJEFMQTLzJFOZFxScH/2LGWkGasnXeYd3vwGc970SR
YPIu2YHuvgPGLfRfl/ctN4GsYD5v5LreS4KS+bteewhYvY9oiRsz06AdA+k9K+Xk
w3pQQUPEw+b18njff2VQrgZUYNale5O03sS3gETwy2PIf8KvNdsMguON0aIghM+5
qfdFD+7l2cRDaYcNELRZQ3z9FE/O9NkIo8NgAG881ou4JzxsnpaAy6QNoM5d/hyx
HUh2W40mcZg5DIb/l7fusH/Wgr/w1FrPT94WhMYIrmAyT6ATVIqy4Ei41ZY9pAWd
4LJAZCT2oarvltSdOaDvi9yc/7t/miyOlKScb0+c2QguJubxtUIUWLbnw/zmmck=
=b9SI
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
