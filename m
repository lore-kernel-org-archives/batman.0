Return-Path: <ordex@autistici.org>
Date: Sat, 14 Apr 2012 13:29:15 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120414112915.GA24739@ritirata.org>
References: <1334402127-5211-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1334402127-5211-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/2] Fixes reported by Al Viro
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


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2012 at 01:15:25PM +0200, Antonio Quartulli wrote:
> The following two patches fix the two issues found by Al Viro and reporte=
d in
> his email.
>=20
> Patch 1) simply convert the tt_crc field in the bat_priv structure from a=
tomic_t
> to uint16_t. Actually there is no reason to declare it as atomic_t.
>=20
> Patch 2) fixes a little bug we have when sending a tt_request message: no=
w we
> don't convert the tt_crc that we are sending within the request to network
> order. OTOH we convert this field from NO to HO on the receiver side.
>=20
> Therefore, nodes on the path of the request, which have HO different from=
 NO,
> will fail to reply to the request and will forward it towards the final
> destination.

I think David'd want to see this fix in the next pull request or so...shoul=
d we
commit these patches to next directly?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPiV+LAAoJEFMQTLzJFOZFyPMH+wfdzpjId1XJd1a6CmEtxv3n
4MQxlzrMtiZEkiWF6Xl25Pj2TK2+sTH0J4eXznqKL2RlQmIs6GyWySwxzF9zvJej
Qc3Gez8ubAhNSGsGKb6vX6NhUgHLaAOT3wWrtuZdrhn6JHyR+x+/0m4UhgBknenL
Nl+Mp3nWZ5czhwx20tt6PwOkilxPNF0SWUSi2T/umAqF5a+rqeAbwoK9hTCFuJEk
m+F+MccbaD3XtoQHDKEz0A+6rvxqVDCd56BY3r/ASm5zAcwF9E1lXgzO3/XID20e
xyKHGJgz6WLIAszggn643/F/YzENool3fV5atEz96NkstnpzlWQyI4lVnyLeaDs=
=c7kk
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
