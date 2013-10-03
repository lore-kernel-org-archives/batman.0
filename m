Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 3 Oct 2013 16:18:54 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131003141852.GA3588@pandem0nium>
References: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] alfred: Allow listening interface to
 appear/disappear
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


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 02:02:08PM +0200, Sven Eckelmann wrote:
> Hi,
>=20
> a device running alfred maybe has to remove the underlying device (e.g. w=
lan
> device has to be reconfigured). This currently makes it necessary to rest=
art
> alfred to get the device sending data again. An unwanted side effect of t=
his
> procedure is the removal of all data currently stored in alfred.
>=20
> Instead alfred should detect such problems and try to recover by reopenin=
g the
> device after sleeping a while. The sleeping is automatically done by sele=
ct.
>=20
> I've tested the changes only using macvtap:
>=20
> Terminal 1:
>=20
> $ ip link del dev macvlan0
> $ ip link add link eth0 name macvlan0 type macvlan
> $ ip link set macvlan0 address 1a:46:0b:ca:bc:7b up
> $ ./alfred -b none -i macvlan0
>=20
> Terminal 2 (after letting alfred run for a while)
>=20
> $ ip link del dev macvlan0
> $ ip link add link eth0 name macvlan0 type macvlan
> $ ip link set macvlan0 address 1a:46:0b:ca:bc:7b up
>=20
> Kind regards,
> 	Sven

Thanks, applied the whole series (785bc8b, 87c1916, 02997b2, 1b79312, 65d26=
ca, d6de864).

Your testsetup did not work for me (no IPv6 addresses where assigned to the=
se macvlan0
interfaces), but I've tried on my WiFi network in alfred master mode and co=
uld confirm
that alfred continues to send announcements after tearing down the WiFi and=
 setting it
up again.

Thanks,
	Simon

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJNfMwACgkQrzg/fFk7axbDuQCgkzPFDViqXJElfsZLAGAKCJlH
eiQAoJhUfzTQm3QhXbDj4yijRvFdMlNt
=Bby0
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
