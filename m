Date: Wed, 14 Nov 2007 17:20:50 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] parametrization for bmxd on ethernet?
Message-ID: <20071114232050.GA5080@apoderado.ometepe.net>
References: <20071114170618.GA4282@apoderado.ometepe.net>
	<200711141934.51710.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <200711141934.51710.axel@open-mesh.net>
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2007 at 07:34:51PM +0100, Axel Neumann wrote:
> Hi,
>=20
> On Mittwoch 14 November 2007, Jan Hetges wrote:
> > Hi
> > I did'nt find doku on that.
> > As i'm getting a 2nd GW :-)...
> >
> > setup:
> >                       ---"DMZ"
> >                      /
> >  vsat --- gateway ------ wifi-gw --- "wifi-world" --- 2nd-wifi-gw
> >                             \
> > 			     ---"wifi-world-2"
> >
> >
> > I'm running bmxd-rv785 on all the wireless stuff, where wifi-gw runs
> > bmxd -g -blabla,  but i liked to move the bmxd-gw to the cabled gw,
> > so if the sat-link fails, "wifi-world-2" and "DMZ" can still reach
> > the internet through the 2nd-wifi-gw.
> > So howto parametrize bmxd for devices without wireless-intrerface
>=20
> usually the same parameters as for a node with a wireless interface shoul=
d be=20
> fine, like:
> bmxd -g 1000 eth0:bmx eth1:bmx
>=20
> You can slightly optimize the cpu consumtion and protocol-traffic-overhea=
d by=20
> appending the /c 100 option to the first interface parameter like:
>=20
> batmand -g 1000 eth0:bat /c 100 eth1:bat
>=20
> This overwrites the default configuration (/c 200) of the first interface=
=20
> parameter which is assumed to be the only wlan interface. /c 200 achieves=
=20
> some optimization for the path detection via wireless links.
>=20
> However, on a cabled lan the protocol-traffic-overhead does not really hu=
rt =20
> and on a i386 architecture you will barely recognize any increased cpu=20
> consumption.
>=20
> > Can i use --gateway-change-hysteresis together with -p ?
> No, --gateway-change-hysteresis can only be used with -r 3 (fast-switch=
=20
> internet connection).=20
>=20
> with -p 10.1.2.3 the gw-client will stick to its selected gw as long as i=
ts=20
> somehow available (until it times out, as you described below).
sorry, actually my question has to be:=20
can i use -p together with -r3 ?
>=20
>=20
> > Suggestion: in bmxd -cbd1 i saw nodes with lvld >400 before they
> > get deleted, i think 180 should be more than enough, 3 minutes is plenty
> > of time for normal reboot, and if a node dosn't send OGMs for more
> > than that... it has a serious problem ;)
>=20
> Well, these long timeout defaults are kind of traditional remains from=20
> batmand-0.2. But, not constantly receiving OGMs from a distant node does =
not=20
> mean that the distant node has not send some or is down. And it also does=
 not=20
> necessarily mean that the old route to this distant node does not work=20
> anymore. With 0.2 we sometimes observed paths to distant nodes via which =
only=20
> one OGMs was received within the current window-size (which was 128 secon=
ds)=20
> and still the path was somehow usable.
yes, and sometimes (actually pretty often in some cases) there was not
even one OGM received and the path would hav been pretty usable ;-)
> On the other hand we thought that it has no much benifits to delete a sta=
le=20
> route (even when its definitely death). Not unless a better path is known=
=2E=20

primarily i'm thinking about path(s) to gw-nodes, in my case here,
i loose the vsat regularly due to power-outages and missing backup
batteries because of the energy hunger of that beast.
But i have to do "some kind of load balancing", and thought for now, it=20
would be the easiest to do that with -p.
>=20
> Ok. 0.2 had some problems with path detection=20
which bmxd doesn't have :-)

cheers

  --Jan


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHO4LSlTtvZdk47D4RAmFjAJ9RLVMYNvj+9thhygN0JMgH4HedkwCaAk0k
hGupIeo99Q6MVNcsCwhtiQ4=
=kWqd
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
