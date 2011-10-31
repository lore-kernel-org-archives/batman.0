Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:03:47 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031000347.GB10726@pandem0nium>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <1319964962-5092-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/6] DAT: Distributed ARP Table
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


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Antonio,

thanks for the patchset! I've tested it again in my kvm setup, it worked ve=
ry
well.

There are some issues remaining, I'll comment the individual patches for th=
is.
About the general stuff:

 * maybe we should rename arp.{c|h} to dat.{c|h} to avoid confusion with
   other code in the linux kernel?
 * please do a checkpatch.pl --strict check on the patches, there were some
   warnings about too long lines and bad spaces

Cheers,
	Simon

On Sun, Oct 30, 2011 at 09:55:56AM +0100, Antonio Quartulli wrote:
> Hello people,
> as most of you may already know, last summer I've been working on the
> B.A.T.M.A.N.-Adv GSoC project named "DAT: Distributed ARP Table". For who=
 wants
> to get deeper into the details of the project there are two links:
> - The GSoC proposal [1]
> - The DAT wikipage on open-mesh.org [2], with status and ideas description
>=20
> Just to recap: DAT is a distributes hash table meant to store ARP entries=
 for
> fast lookup. In a normal scenario, whenever a node wants to communicate w=
ith
> another one, it first needs to issue a broadcast ARP request in order to
> retrieve its PHY/MAC address. In a sparse network a broadcast message cou=
ld be
> lost several times before reaching the real destination so creating high
> latencies. With DAT, every ARP entries (a pair [IP addr, MAC addr]) is st=
ored on
> a "computed" set of nodes, therefore in case of ARP request theses nodes =
can
> directly be contacted (in unicast) and the needed information can be quic=
kly
> fetched.
>=20
> Cheers,
> Antonio
>=20
> [1] http://www.google-melange.com/gsoc/project/google/gsoc2011/ordex/4001
> [2] http://www.open-mesh.org/wiki/batman-adv/DAT
>=20
>=20

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t5eMACgkQrzg/fFk7axaI/QCbBHqbFyEliGK4Vy4cHWGbIPDa
s4YAn3zxJm6c4z1ma/bYcvNVDH/KvUOA
=UHgN
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
