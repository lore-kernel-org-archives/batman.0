Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 11 Oct 2010 10:04:54 +0200
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<201010101442.08908.lindner_marek@yahoo.de>
	<20101010190037.GA2240@Sellars>
In-Reply-To: <20101010190037.GA2240@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2013655.1hZ72HHdSn";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010111004.55912.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Introduce generic
	BAT_ATTR_* macros
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

--nextPart2013655.1hZ72HHdSn
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> Hi Marek,
>=20
> actually, there were two reasons for renaming that I guess. One
> was out of "laziness" and I wanted to keep the number of
> parameters of a BAT_ATTR_* macro as less as possible. Otherwise
> I'd have to have another field, one for stating the name in sysfs
> and one for the name in bat_priv.
>=20
> I then was wondering why the names between sysfs and bat_priv
> shouldn't be the same instead (or +_enabled for switch/bool
> attributes). I could have renamed the part in bat_priv to
> aggregate_ogms_enabled but found that a little long (the same for
> fragmentation_enabled). Or the _enabled parts could be removed in
> bat_priv, but making it less obvious, what kind of values they
> might take.
>=20
> So I thought that just aggregation might be a good trade-off. And
> that anyone who might be confused by the names, not knowing what
> they might be used for, should use batctl instead (and its manpage
> for explanations).
>=20
> Or would anybody prefer another solution (of the ones described
> above)?

Please don't change the sysfs names.

And document all your sysfs files for sysfs-class-net-mesh and
sysfs-class-net-batman-adv in linux-merge.git

Still missing stuff are:
 * fragmentation (@Andreas - your part)
 * gw_mode (can be documented later)
 * hop_penalty
 * num_bcasts
 * log_level

Thanks,
	Sven

--nextPart2013655.1hZ72HHdSn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMssUnAAoJEF2HCgfBJntGQRoP/RhmZFH4PGAFhO2QRMfroanh
kFvBH9oOC43eduFGytlYu+qPWzffpkj2zMTjZrg9FZ5mBw97+KS/1sYbG0qBfuw5
hvqpiH/RW1XKF8CLVkOi2zGcDGCkbY02mKv+facNVLYOTcA3nErTszNSyyDQc2Zy
BXdPBxhOXwwRbNWfoFmT++VYFrYrhs0R1lyibmvTwzjV8csMgGCWSt71wSE5y5Wz
Y0h7lp4yAE63qjbFRkptTnBxwwwPWjIuddG36bWIZ/OF8Ox1TCKunSneN+vKbLbL
Q39m2id2EmnVrffMyJ9sToBdmf6vfA1CWju0Ck3z5AxmXpMiEEDFnl561F1vKMjO
+uztyLLoM/QC1Of879/nsEnywjGuNrxGQmnG0wilTig9ERgiTlhK808/dIt5LeHq
FoyppEmcd8h0WTo49lfP4hDfIGuhlB+QW4CaN6rN8gpG/urhbGUaen+dnWwhfWYI
oWZimsf7gnSOLhg6qtJtfQEzClpSHxxEaUbcHeK9lFJ2U6oN78cU/U07qNJAgwho
GAByZ4R8qZucg20+pFiDAeMGDDwDGx3tpoy+1FL2ReN5o8+5MOyVZWdEgaXsg3WI
yLQ8I9Z2ItZAzSl7lwh5IiyVXmXe8Sn+BjzjeRWAGNuFrWbGqArfsqXg7EjdcEjT
pS4UuSBxD47TmkBLBGVO
=zpl3
-----END PGP SIGNATURE-----

--nextPart2013655.1hZ72HHdSn--
