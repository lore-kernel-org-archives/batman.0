Date: Fri, 14 Sep 2007 10:03:59 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] translation of batman-adv
Message-ID: <20070914080358.GA1870@hrz.tu-chemnitz.de>
References: <002d01c7f5cc$825d8910$0cdbe29f@happy0bc06a65b>
	<20070914064628.GA1471@hrz.tu-chemnitz.de>
	<000e01c7f69e$7ca80400$0cdbe29f@happy0bc06a65b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <000e01c7f69e$7ca80400$0cdbe29f@happy0bc06a65b>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Yes we thought about that too (actually that was my first idea),=20
but this might lead to inconsitency as not all hosts will get an update
when a node moves but only those nodes which are on the way. Furthermore
the packet reading (and cache updating) increases latency to forwarding.=20
A solution might be to increase the rate in which batman-packets are
sent (because then host announcement goes with them), or create a new
packet type for announcement and send these more often. Both brings us
much more noise in the mesh.
I wonder if having a wifi-mesh is good for (hard?) real-time
applications. Even reassociating to a new access point might take a few
seconds (scanning & finding), or there is packet loss if you get out of=20
the range from the previous ap until your wifi card changes to another
AP.

Regards
	Simon



On Fri, Sep 14, 2007 at 03:11:35PM +0800, =E5=94=90=E9=BC=8E wrote:
> hi!
> but 1 second delay is too long to some real-time applications.
> i have look insight the batman-adv code.=20
> caching source host's mac and originater's mac when batman node  forwards=
 a packet  maybe is better way

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6kBurzg/fFk7axYRApufAKDwkx/Nwgz4qqQrQZaM48a0X4lQPACfU9TZ
Bk2udA2566bDqXR7C830NCI=
=eWRa
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
