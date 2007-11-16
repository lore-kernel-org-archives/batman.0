Date: Fri, 16 Nov 2007 08:59:05 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] parametrization for bmxd on ethernet?
Message-ID: <20071116145905.GA4732@apoderado.ometepe.net>
References: <20071114170618.GA4282@apoderado.ometepe.net>
	<200711141934.51710.axel@open-mesh.net>
	<20071114232050.GA5080@apoderado.ometepe.net>
	<200711152029.49188.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <200711152029.49188.axel@open-mesh.net>
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2007 at 08:29:49PM +0100, Axel Neumann wrote:
>=20
> > > > So howto parametrize bmxd for devices without wireless-intrerface
> > >
> > > usually the same parameters as for a node with a wireless interface
> > > should be fine, like:
> > > bmxd -g 1000 eth0:bmx eth1:bmx
> > >
> > > You can slightly optimize the cpu consumtion and
> > > protocol-traffic-overhead by appending the /c 100 option to the first
> > > interface parameter like:
> > >
> > > batmand -g 1000 eth0:bat /c 100 eth1:bat
> > >
> > > This overwrites the default configuration (/c 200) of the first inter=
face
> > > parameter which is assumed to be the only wlan interface. /c 200 achi=
eves
> > > some optimization for the path detection via wireless links.
> > >
> > > However, on a cabled lan the protocol-traffic-overhead does not really
> > > hurt and on a i386 architecture you will barely recognize any increas=
ed
> > > cpu consumption.
> update: I added two more simple interface specific option with rv801 . Th=
e=20
> daemon now tells you about this during startup:
> The batman-exp default parametrization assumes the first given interface=
=20
> argument to be the one and only wireless interface, followed by zero or m=
ore=20
> lan interfaces! To change this assumption mark the interfaces explicitly=
=20
> using /w to specify the wlan interface(s) and /l to specify the lan=20
> interface(s). Example: batmand eth0 /l wlan0 /w ath1 /w

nice one
> > >
> > > > Can i use --gateway-change-hysteresis together with -p ?
> > >
> > > No, --gateway-change-hysteresis can only be used with -r 3 (fast-swit=
ch
> > > internet connection).
> > >
> > > with -p 10.1.2.3 the gw-client will stick to its selected gw as long =
as
> > > its somehow available (until it times out, as you described below).
> >
> > sorry, actually my question has to be:
> > can i use -p together with -r3 ?
>=20
> You can. Then -r3 is the fallback strategy for the GW selection in case t=
he=20
> preferred one is not available. But still the client-node will not think=
=20
> about choosing a faster GW until the preferred GW has been purged. Once t=
he=20
> preferred GW is not available anymore it uses the -r3 policy to switch=20
> between the remaining available GWs :-(

but with only two gateways, that's actually all i need :-)
>=20
> >
> > > > Suggestion: in bmxd -cbd1 i saw nodes with lvld >400 before they
> > > > get deleted, i think 180 should be more than enough, 3 minutes is
> > > > plenty of time for normal reboot, and if a node dosn't send OGMs for
> > > > more than that... it has a serious problem ;)
> > >
> > > Well, these long timeout defaults are kind of traditional remains from
> > > batmand-0.2. But, not constantly receiving OGMs from a distant node d=
oes
> > > not mean that the distant node has not send some or is down. And it a=
lso
> > > does not necessarily mean that the old route to this distant node does
> > > not work anymore. With 0.2 we sometimes observed paths to distant nod=
es
> > > via which only one OGMs was received within the current window-size
> > > (which was 128 seconds) and still the path was somehow usable.
> >
> another update:
> You can slightly modify the purge interval by configuring the value used =
for=20
> the rudimentary DuplicateAddressDetection (--dad-timeout). Default is 100=
=20
> which means that the DAD timeout is 100% of the (originator-interval *=20
> window-size). So 150 seconds by default. The daeomon also tells you about=
=20
> these values during startup: --dad-timeout 50 (which is the minimum allow=
ed)=20
> will print:
> Using duplicate-address-detection timeout 75s, purge timeout 160s, origin=
ator=20
> interval 1500ms, window size 100

o.k., i see, and thanks for the explaination


cheers

  --Jan

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHPbA5lTtvZdk47D4RAi4qAKCdVuhDUaoK3dFXmxl/VQFr9sBWggCfTmx7
lXuw8cRpRZAZYVzabD8G5Jg=
=y6r2
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
