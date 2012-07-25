Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 25 Jul 2012 22:34:25 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120725203425.GB11999@pandem0nium>
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
 <20120708100956.GA10210@pandem0nium>
 <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
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


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Gui,

On Mon, Jul 23, 2012 at 04:20:39AM -0300, Gui Iribarren wrote:
> On Sun, Jul 8, 2012 at 7:09 AM, Simon Wunderlich
> <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> [..]
>
> When it doesn't work is when the ad-hoc connection is severed.
> which makes the thing look like
> http://www.open-mesh.org/attachments/download/128
> that is, there are two gateways that can only talk to each other
> through ethernet (although it's not "batctl if add"ed) don't get each
> other OGMs
> after careful re-reading of BLAII docs in the wiki, and extensive
> chats with NicoEchaniz, i understood this is the planned behaviour (no
> OGMs on lan)
>=20

Yes, that is expected behaviour. We don't want OGMs on the LAN, there were
issues with some more "intelligent" switches which regarded OGMs as threat
to the network. :)


OGMs are only sent on interfaces added with "batctl if add", and nowhere el=
se.


> >> now, node D and C, too far away from each other to communicate over
> >> wlan, but connected by a "loooong eth cable" (mediated by a wds
> >> transparent bridge) wouldn't find each other batman originator.
> >> C originator table was empty, and D only showed P.
> >> I thought the transparent bridge was misbehaving, so I tried in a
> >> simpler setup using P and D, with the wifi off:
> >> but after disabling wlan0 (batctl if del wlan0-2) and adding eth0
> >> (batctl if add eth0) on both nodes, batman could not see each other
> >> anymore :(
> >> i thought i was doing something wrong, so i tried in different ways,
> >> but could not get it to work.
> >> batctl td eth0 shows both outgoing OGMs from local , and incoming OGMs
> >> from remote,
> >> but batctl l only reported outgoing OGMs.
> >>
> >> http://pastebin.com/7DDUaXu1
> >
> > Mhm, that's weird indeed. Is eth0 really not included in any other brid=
ge?
> > It looks like the incoming packets don't reach BATMAN for some reason.
> Definitely not included in any bridge.
> Funny thing is, the only workaround i found for the bug is to
> *include* the interface in a bridge, and add that bridge to bat0
> as in:
> brctl delif br-lan eth0
> batctl if add eth0
> # doesn't work
>=20
> brctl delif br-lan eth0
> brctl addbr blah
> brctl addif blah eth0
> batctl if add blah
> # works fine, OGMs pass through perfectly
>=20

OK, so you say that it doesn't work when you simply add eth0 batctl, but it=
 works
with the bridge? What is the minimal setup which is not working, two routers
and one cable?

I'm sorry but you lost me somewhere, would be nice to get the smallest repr=
oducable
setup. :)

Cheers and thanks,
	Simon

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAQWFEACgkQrzg/fFk7axb0fwCcDDoLVtS/HbwyV5ou7AFuIUSE
VWMAoOw+4o4uvOjyNQ5LjT4mASrEDZFn
=Z3Up
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
