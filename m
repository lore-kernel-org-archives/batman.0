Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 7 Aug 2012 12:46:51 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120807104651.GA25568@pandem0nium>
References: <CAHD-aqJubnMBSuyjyS+aOXnS8FSQe=w8Aj2-SnaohNqXSs_xJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <CAHD-aqJubnMBSuyjyS+aOXnS8FSQe=w8Aj2-SnaohNqXSs_xJg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] propagate gw_mode over two mesh linked by
 ethernet with bla2
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


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guido,

On Sun, Aug 05, 2012 at 03:26:43AM -0300, Gui Iribarren wrote:
> Here i am again,
> the involuntary stress-tester of gw_mode + bla2
> and mailing-list readers' headache ;)
>=20
> Given the setup described here
> http://www.open-mesh.org/attachments/download/128
>=20
> let's say one node in mesh1 sets gw_mode=3Dserver
> any node in mesh1 will list it in "batctl gwl"
>=20
> but nodes in mesh2 won't get it, since backbone gateways (BGs) of
> mesh2 only get claims from BGs of mesh1, which do not include gw_mode
> status
>=20
> with bla1 setup, OGMs did flood the ethernet backbone, carrying
> gw_mode information, and both mesh1 and mesh2 would get to know
> gateways
> I miss that functionality! :(
>=20
> so, as Simon himself suggests [0] in the wiki' shortest-ever FAQ ;),
> having full control of the ethernet backbone, I batctl-if-added an
> ethernet vlan on BGs of both sides of the ethernet cable.
>=20
> OGMs flood the ethernet backbone again as expected; running "batctl o"
> in mesh1 nodes show nodes from mesh2, and viceversa; i smiled!
> unfortunately, trying to get a DHCP lease while connected to a mesh
> node was again malfunctioning :(
> a couple of quick "batctl td", and i thiiiink that looked like dhcp
> request packets were being dropped at the backbone gateway, kinda like
> the "check incoming type for bla" bug, but i didn't try to narrow it
> down
> instead reverted configs back to gw_mode=3Doff and things started working=
 again

Mhm, we could track this further down if you want. So you have eth0 in your
bridge and batman using a VLAN (e.g. eth0.1234) at the same time?
>=20
> i won't dig much into that since it's quite possible i entangled up my
> configs yet again, so i'll focus on the original question:
> are there any plans (or is it even feasible) to propagate gw_mode
> status through the ethernet backbone (assuming not sending OGMs)?
> maybe including/appending it in claim frames?

No, at least I didn't plan to do so, and I wouldn't favor to build a second
"attachment" system on claims as we did on OGMs - this will only bring
more complexity. Instead, we should focus/support/fix the situation as
you described above - let batman use Ethernet directly.


>=20
> what i understand so far is that with current blaII, meshes connected
> solely by ethernet backbone (which can't overhear each other OGMs
> through wifi) only know which macs are "on the other side of the eth
> backbone" so as to keep the single broadcast domain united, but are
> fragmented in terms of VIS data, gw, TT, and orig table.

Yes, there are two separate meshes, and the only stuff which is supposed
to be shared is the users payload traffic.

>=20
> sorry if i'm asking obvious questions, the blaII wiki explains notably
> clear the model, but is missing gw_mode interactions, and it wasn't
> evident to me how would that work - in fact, coming from bla1, i
> wrongly assumed it would be similar. if it's relevant, i can try to
> add validated snippets from this thread to the wiki[0]

Each node at the edge to the wired network may announce itself as a gateway,
provided that a DHCP server is available in the LAN (or any network behind =
it,
e.g. a mesh). From a concept view, a gateway (or maybe even multiple gatewa=
ys)
in mesh2 will not automatically announced in mesh1 - this must be configured
manually, or let batman use Ethernet if this is explicitly required.

Feel free to update the Wiki, although I'd suggest to add an FAQ to the
user page and not on the technical documentation. :)

If you want, I'd be happy to work things out regarding
multiple meshes+bridge+vlan+ethernet+batman+blaII with you. ;)

Cheers,
	Simon

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance



--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAg8hsACgkQrzg/fFk7axbwuQCfbFRjYxMjbWcdw0WoQRgSVk8g
8mgAn0D6HUqJOhs6ggwqwTVmaKbXecY2
=Ch3d
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
