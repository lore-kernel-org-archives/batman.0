Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Fri, 4 Feb 2011 16:38:50 +0100
References: <201101282346.16035.clemens-john@gmx.de>
	<201101311933.01581.clemens-john@gmx.de>
	<4D47E5A4.2020005@kevinsteen.net>
In-Reply-To: <4D47E5A4.2020005@kevinsteen.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2426107.r0jBgjG4Xp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201102041638.54751.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2426107.r0jBgjG4Xp
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Dienstag 01 Februar 2011, 11:51:16 schrieben Sie:
> If your non-batman clients don't need incoming connections, you could
> NAT outgoing connections :
>    [client]-->[adhoc ath1]-->NAT-->[br-mesh]
> You would have to run a DHCP server on the ath1 interface to give those
> clients a private IP and tell them to use the private IP on ath1 as
> their router.

What do I have do insert into iptables to NAT ath1 to br-mesh? I=B4m a comp=
lete=20
firewall noob.

Regards
Clemens

--nextPart2426107.r0jBgjG4Xp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1MHYoACgkQZgdHbA22lqOv2QCfWwWUm1heHq6bNOohF+ZJMf53
Nb0AoJIUL3RAeyhO+N0i9sQoGsJNTcfv
=xBdg
-----END PGP SIGNATURE-----

--nextPart2426107.r0jBgjG4Xp--
