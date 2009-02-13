Date: Fri, 13 Feb 2009 01:21:43 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090213002143.GA27725@pandem0nium>
References: <mailman.134.1234470500.960.b.a.t.m.a.n@open-mesh.net>
	<499494DE.1070304@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <499494DE.1070304@gmail.com>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Digest, Vol 26, Issue 7
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tim,

On Thu, Feb 12, 2009 at 03:30:06PM -0600, Tim LePes wrote:
>=20
> I understand you can get good range with WiFi using directional
> antennae, parabolic antennae, "cantennas", etc.  I *have* thought about
> directional antennas for back-haul, but the project idea was geared
> toward emergency workers being able to set up a network as simply as
> possible.  So I have been leaning toward a good solution to work with
> omni-directional antennas.  No "aiming" needed... plug and play would be
> ideal.  With directional antennas it would take a little more work.  But
> may be a better solution in the end.  Nothing is set in stone here.
>=20
> I was going with WiMAX because, to my understanding, I could get a far,
> far greater range using omni-directional antennas than I could with
> WiFi.  I do understand that the data rates fall off with distance.  I am
> not interested, here, in providing typical municipal wireless solutions
> where the users are going to be working with rich content a lot.  I want
> to be able to set up a communications network that can help rescue
> workers get access to logistics and co-ordination web pages.

WiFi has some kind of range limit due to the acknowledgement timeout,
but you can easily overcome this by increasing the timeout (at least the=20
madwifi driver allowed to change this timeout). Another
limit is of course the allowed transmit power, or EIRP. The limit is
much higher for WiMAX (if it is even limited), but also for WiFi you can
use a higher transmit power than the usual 100 mW or 500 mW if you
implement DFS and other techniques. The specific limits depend on your
regulations, i think it was something between 1 Watt and 4 Watt in
germany.

It is no art to get connectivity over long distances even with omnis if
you can choose the power as high as you want. ;)=20
(please correct me if i'm wrong here)

>=20
> Mainly, I am interested in implementing SAHANA on this network.  From
> their web site, "Sahana is a Free and Open Source Disaster Management
> system. It is a web based collaboration tool that addresses the common
> coordination problems during a disaster from finding missing people,
> managing aid, managing volunteers, tracking camps effectively between
> Government groups, the civil society (NGOs) and the victims
> themselves."  You can find more info at http://www.sahana.lk/ or
> http://en.wikipedia.org/wiki/Sahana_FOSS_Disaster_Management_System if
> you would like to check it out further.  So the primary application I
> want to support is simply a web app on a server, and have it run
> reasonably well over the mesh.  I am not going for VoIP or streaming
> video, so the top-end bandwidth is not my main goal.  Distance is.  Ease
> of set-up is.  But, of course, I will eventually have to do real-world
> testing to see if the throughput would suffice.  If I were to do
> directional antennas, I would look to WiFi or Microwave just as readily
> as WiMAX.
>=20
> Now as a secondary function, this disaster-relief network could also
> support access out to the wider web, and it would be nice for rescue
> workers in the Red Cross tent or what have some PCs connected to my mesh
> node, using it as an AP into the mesh and on to the web.  The idea is
> not, even then, to support video conferencing or bittorrents.  Email to
> friends and family.  Government and NGO resource web pages.  Etc.

Sound interesting. :)

>=20
> The dev board I have is a 400MHz Freescale MPC5200B PowerPC SoC - based
> unit called the EFIKA 5200B from Genesi.  See
> http://www.genesi-usa.com/efika for details.  I am going to outfit it
> with a PCI to MiniPCI adapter and should be able to put two miniPCI
> cards on it.  Now here, I will note that I have only been able to find a
> mini-PCI EXPRESS adapter (from Intel, and it also supports WiFi).=20
> Intel's "Echo Peak"...   "Intel=C2=AE WiMAX/WiFi Link 5150(512ANXMMWG) is=
 a
> 1X2 MIMO (Multiple Input, Multiple Output) 1x2 (one transmit chain, two
> receive chains) PCIe Minicard supporting IEEE 802.16e and 802.11a/b/g/n
> wireless network adapters that operate in the 2.4 GHz and 5.0 GHz
> spectra for WiFi and 2.5 GHz for WiMAX."

Have you ever looked at boards like the ALIX? What are your concrete
requirements? If you need MiniPCI, you should probably choose something
which does not need an adapter.=20
http://www.pcengines.ch/alix.htm

And make sure the boards really support the high power radio cards.
(Sometimes these boards are only designed for lower power PCI cards, i
heard ...)

>=20
> 802.16d tends to be good for fixed stations.  And the idea is that these
> nodes will pretty much stay put once set up.  802.16e is largely being
> touted for it's mobile network features... and it is coming to the US.=20
> Clearwire wireless broadband (802.11d methinks) is already deployed in
> Nashville.  Clearwire is now backed by Sprint and others.  Sprint's XOHM
> is also picking up steam.  This is an 802.16e service that is one "4G"
> route.  Though for the cell companies, LTE is also on the horizon.=20
> Sprint are supposed to be carrying the Nokia N810 tablet now with WiMax
> in it.  More and more MIDs, netbooks, smart phones, and eventually
> laptops and such will be coming with 802.16e chipsets.  Especially since
> major cell carriers have been investing in this technology.  Sprint has
> infrastructure already.  I am not so interested in the mobile aspects of
> 802.16e though.  I am interested in the MIMO technology support, however.
>=20
> Licensing issues I will get to later.  There is unlicensed spectrum
> available here in the US.  But as this is geared toward emergency use, I
> imagine that there will be considerations regarding spectrum use for
> such an application that may be favorable.  More research is in order
> here, I agree.  At one point Genesi told me I had the Australian
> government interested in my project, but at the time I had nothing to
> show for it yet so I didn't pursue anything with them.
>=20
> Granted, this is a learn-as-you-go project for me.  I have Debian
> running on the device, but that's about it so far.  Well, it also runs
> Apache.  I have to get some hardware to be able to do anything
> constructive.  I am not being backed by anyone, other than Genesi who
> were gracious enough to give me an EFIKA at no cost.  Their hope is that
> I would create a product around the board, and I would like to make good
> on that.  They are a unique company with a strong open-source vision,
> including open hardware designs.  They make the reference design, and
> are first to be ready to market any products derived from it.  But
> others can implement my project as their own product, either using
> Genesi for the hardware or going it on their own.
>=20
> I have a LOT to learn about all this stuff... but for me, that is the
> point.  I get to play with cool toys and maybe in the end do something
> that could be a benefit to others.  WiMAX is "cool" to me, so that was
> my initial attraction.  I also am keenly interested in wireless
> networking.  I am no fan of monopolies.  And it's also a great option
> for rural areas and developing countries.  BATMAN is also very cool to
> me and I have been following along here for a while, lurking on and
> off.  But when all is said and done with the project... I don't need a
> WiMAX mesh node for myself.  So I will turn the EFIKA into a car
> computer when I'm done... there is already another project doing that
> and I'll just copy off them at that time.  But for now I want to get my
> idea moving forward.  I am completely open to suggestions and advice
> along the way.
>=20
> Thanks for being curious, and I hope you find my idea interesting.


I think its a good idea to do some experiments. Please keep us informed
about your WiMAX adventures, at least i'd be very interested. :)

best regards,
	Simon


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJlL0Xrzg/fFk7axYRAg4wAKDKIiI4EFQGbN8zq8uwM3ANu65ATwCdEaEm
RSnHQ7vdtizNu0vmzj1+YK4=
=jx8/
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
