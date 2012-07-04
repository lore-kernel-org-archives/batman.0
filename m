Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 4 Jul 2012 11:20:52 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120704092052.GB10142@pandem0nium>
References: <CAGpqJgoJ2V5TNcr5j+c=y88Vj4ipE0ke=y9ZDKqOvsaci+u54A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <CAGpqJgoJ2V5TNcr5j+c=y88Vj4ipE0ke=y9ZDKqOvsaci+u54A@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [B.A.T.M.A.N] OGM problem and documentation
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


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arthur,

On Tue, Jul 03, 2012 at 10:57:28AM +0200, Arthur Lambert wrote:
> Hi,
>=20
> I am testing Batman Advance (Batman release 2012 1.0) and I am trying
> to measure signaling on some topology of VMs. I have 81 nodes (Debian,
> 3.0.9) with KVM virtualization. My topology is something like this :
> http://imgur.com/Xh1gM
>=20
>=20
> I have a topology with an adjacency matrix of maximum 4 as you can see
> on my screenshot. I record on each VM signaling received and sent. On
> some VM, my node send OGM at each "orig_interval" but does not receive
> any OGM at all.
>=20
> Is it normal ?

Well, no. :) Have you checked that the problem is really with batman and
not with a layer below (I don't know how you interconnect your VMs,
wirefilter/bridges/etc)? You can check using tcpdump on the interface
batman is using and see if you have any incoming packets of other nodes.

If not, there is most probably something wrong with the interconnect.

>=20
> Moreover, I have found a wonderful documention here :
> http://gitorious.org/batman-adv-doc. Unfortunatly, it is not maintened
> since two years. I have also found some papers which describe your
> protocol, but most of the time, the paper are too old or not correct
> in the protocol description. At this moment, my first source of
> information is the code. Can you advise me a good paper or
> documentation on the architecture and features of Batman Advance set
> apart your twiki.

Well yeah, this documentation is pretty old. I'd suggest to read

http://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.pdf

which has a nice and (quite) up-to-date introduction to batman-adv included.
Furthermore, we try to keep the Wiki as much up to date as possible, if the=
re
is something missing feel free to ask.

Cheers,
	Simon

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/0CvQACgkQrzg/fFk7axYygACfa0uCbrlMDd9bklpcEm3XFnik
sq4An09exU1zZWlVF27ybLMVFZyFM8FZ
=gIYi
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
