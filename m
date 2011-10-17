Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 17 Oct 2011 20:19:20 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111017181920.GA15303@pandem0nium>
References: <4E9C2AA9.4070208@hundeboll.net>
	<20111017163754.GA1646@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20111017163754.GA1646@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] Unused structs in Catwoman packet buffers
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


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Martin,

just my two cents: I agree to Antonio to keep the packet list struct alive =
at least
for a few seconds. If your packet stream has less than 100 packets per seco=
nd=20
(which is quite common IMHO) for your 10ms send-and-free scenario, many pac=
ket list=20
structs would be destroyed and reinitialized over the time.In worst case,=
=20
this would happen for every single packet which comes by, for example if yo=
u have a=20
steady 50 packets/s stream (typical VoIP streams with 20ms packetization).

Cheers=20
	Simon

On Mon, Oct 17, 2011 at 06:37:55PM +0200, Antonio Quartulli wrote:
> Hello Martin,
>=20
> and thank you for the explanation.
>=20
> On Mon, Oct 17, 2011 at 03:16:25 +0200, Martin Hundeb=C3=B8ll wrote:
> > Now here's the question:
> > When a list of a certain coding_path becomes empty, should I free the c=
oding_path right away, or should I timestamp it and mark it for removal at =
a later time. The thing is that I don't know whether a new packet for the s=
ame coding_path will arrive in a short moment. If I have just freed the cod=
ing_path struct, I would have to spend ressources to initialize it again...
> >=20
> > It is probably a micro-optimiziation and the simplest solution would be=
 to just free it right away, but I would like to have your comments anyways.
>=20
> In my opinion it would be better to _keep_ the struct even if the corresp=
onding
> packet list is empty.
>=20
> Imagine there are two packet flows going through a relay
> node R. If the two coding paths of the two flows have an high coding corr=
elation
> at R (coding opportunity?), one of the two packet lists on R will be empt=
ied
> several times during the data transmission.
>=20
> For this reason I think it would be better to wait a fixed time before fr=
eeing
> such structure. The overhead given by the freeing/reallocating/reinitiali=
sing
> operation could become not negligible.
>=20
> I hope that I correctly understood the problem and that my idea was clear=
 :-)
>=20
> Cheers,
>=20
>=20
> --=20
> Antonio Quartulli
>=20
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
>=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6ccagACgkQrzg/fFk7axbWjwCg9XSddVPDWS+K71cYecYsUJo4
OhkAmwa6STkOwYQ/PDdfM62Yc7zarY0l
=DMKB
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
