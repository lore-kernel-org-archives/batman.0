Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 2/4] batctl: Integrate hardif setting framework
Date: Sun, 16 Jun 2019 18:28:50 +0200
Message-ID: <27871339.pAZbgkbM92@sven-edge>
In-Reply-To: <20190616145316.GB2727@otheros>
References: <20190613191217.28139-1-sven@narfation.org>
 <20190613191217.28139-3-sven@narfation.org> <20190616145316.GB2727@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2875872.j8hLqmcBA4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2875872.j8hLqmcBA4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 16 June 2019 16:53:16 CEST Linus L=FCssing wrote:
> On Thu, Jun 13, 2019 at 09:12:15PM +0200, Sven Eckelmann wrote:
> > batctl currently supports settings which are either mesh interface or v=
lan
> > specific. But B.A.T.M.A.N. V introduced two additional settings which a=
re
> > hard (slave) interface specific.
> >=20
> > To support these, an additional command prefix called hardif is impleme=
nted
> > for some sysfs commands:
> >=20
> >   $ batctl -m bat0 hardif eth0 ...
> >=20
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
>=20
> Three thoughts/questions:
>=20
> Currently we do not allow adding a hard-interface to two meshes,
> right? So the "-m bat0" here is redundant?

Yes and no. This is also the way how the netlink interface is addressing th=
e=20
device. But implementation wise - this should be rather easy. I've already=
=20
added the code to query_rtnl_link_single a while back. See
check_mesh_iface_ownership_netlink as an example.

So it is now a question of how many magic we want to implement at the=20
beginning. We already had the problem that the old vlan selection logic (-m=
)=20
could be used to run weird commands which you shouldn't be able to run that=
=20
way. Because of this I would ask to deprecate the '-m' parameter in favor o=
f=20
an optional(?) meshif selector prefix. And show this selector prefix for vi=
d=20
and for all meshif specific commands.

> Have we used the terminology "hard interface" in UI and
> documentation before? Maybe it's just me, but I'm wondering
> whether the terms "soft interface" and "hard interface" might be a
> bit confusing to users, as these days people not only add
> hardware interfaces but also virtual ones. And these terms are not
> used in other projects (afaik). Maybe just stick to the more commonly
> used term "slave interface" and keep "hard" and "soft" interface as
> internal?

We are using hardif for example in the OpenWrt config integration.
And the netlink stuff is called this way. Also the event parser=20
already print events out as "hardif" events (for hardif related events only=
 of=20
course).

And yes, this was then also used in the documentation.

> I'm wondering how it would look like if we were having settings
> both applicable to a soft and hard interface. What about using a
> "-s <slave-iface>", similar to the "-m <mesh-iface>" instead of
> the "hardif" command prefix? So that you could do things like:
>=20
> $ batctl [-m <mesh-iface>|-s <slave-iface>] multicast_fanout <int>

Just do it like you do it for ap_isolation - which is for both vlan and=20
meshif:

   batctl ap_isolation
   batctl vid 1 ap_isolation

Using these selector prefixes instead of -parameter value things allows us=
=20
to correctly filter the commands and to provide an overview of commands wit=
h=20
the information for which object type it can be used. Something like the st=
uff
we are doing for ap_isolation with this patchset:

        ap_isolation|ap                    [0|1]                display or =
modify ap_isolation setting
        vlan <vdev> ap_isolation|ap        [0|1]                display or =
modify ap_isolation setting for vlan device or id
        vid <vid> ap_isolation|ap          [0|1]                display or =
modify ap_isolation setting for vlan device or id

And I tend to have problems with -parameters when the order is too importan=
t=20
and not really clear. For example following would work:

   batctl -m bat0 ping 01:23:45:67:89:af

But not following:

   batctl ping -m bat0 01:23:45:67:89:af=20

While you can learn to handle this correctly, it seems to more intuitive to=
=20
have it tree structured from the start. Simply to make it clear on what you
are operating now. Something more like:

    [meshif <dev>]   aggregation|ag              [0|1]                displ=
ay or modify aggregation setting
    [meshif <dev>]   ap_isolation|ap             [0|1]                displ=
ay or modify ap_isolation setting
    vlan <vdev>      ap_isolation|ap             [0|1]                displ=
ay or modify ap_isolation setting for vlan device or id
    [meshif <dev>] vid <vid> ap_isolation|ap     [0|1]                displ=
ay or modify ap_isolation setting for vlan device or id
    [meshif <dev>]   bonding|b                   [0|1]                displ=
ay or modify bonding setting
    [meshif <dev>]   bridge_loop_avoidance|bl    [0|1]                displ=
ay or modify bridge_loop_avoidance setting
    [meshif <dev>]   distributed_arp_table|dat   [0|1]                displ=
ay or modify distributed_arp_table setting
    hardif <netdev>  elp_interval|et             [interval]           displ=
ay or modify elp_interval setting
    event|e                                                           displ=
ay events from batman-adv
    [meshif <dev>]   fragmentation|f             [0|1]                displ=
ay or modify fragmentation setting
    [meshif <dev>]   gw_mode|gw                  [mode]               displ=
ay or modify the gateway mode
    [meshif <dev>]   hop_penalty|hp              [penalty]            displ=
ay or modify hop_penalty setting
    [meshif <dev>]   interface|if                [add|del iface(s)]   displ=
ay or modify the interface settings
    [meshif <dev>]   isolation_mark|mark         [mark]               displ=
ay or modify isolation_mark setting
    [meshif <dev>]   loglevel|ll                 [level]              displ=
ay or modify the log level
    [meshif <dev>]   multicast_fanout|mo         [fanout]             displ=
ay or modify multicast_fanout setting
    [meshif <dev>]   multicast_forceflood|mff    [0|1]                displ=
ay or modify multicast_forceflood setting
    [meshif <dev>]   network_coding|nc           [0|1]                displ=
ay or modify network_coding setting
    [meshif <dev>]   orig_interval|it            [interval]           displ=
ay or modify orig_interval setting
    [meshif <dev>]   ping|p                      <destination>        ping =
another batman adv host via layer 2
    routing_algo|ra                              [mode]               displ=
ay or modify the routing algorithm
    [meshif <dev>]   statistics|s                                     print=
 mesh statistics
    [meshif <dev>]   tcpdump|td                  <interface>          tcpdu=
mp layer 2 traffic on the given interface
    hardif <netdev>  throughput_override|to      [mbit]               displ=
ay or modify throughput_override setting
    [meshif <dev>]   throughputmeter|tp          <destination>        start=
 a throughput measurement
    [meshif <dev>]   traceroute|tr               <destination>        trace=
route another batman adv host via layer 2
    [meshif <dev>]   translate|t                 <destination>        trans=
late a destination to the originator responsible for it

Kind regards,
	Sven
--nextPart2875872.j8hLqmcBA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0GbkIACgkQXYcKB8Em
e0b6IRAAsK3RCAHt7ufiB6e4L29j2RyH8iey5vWywzSiNszU1aPot6ueofJIB5yN
aamn9/8fzyGAejA/n9OPCzcG59dDQByIP/Vl3C3MAFdXq9oLDYTThnlZD9b5sMed
jg1UtjcT6axRMqQekb2O0aEzTzvEbTZmafTgD7q5tfh9lX8sBUD7ZP+5612QL3fB
lTYPVl8++1Ef8mW9vQGwxRoPmHf/35VhBEPkqshtprqKLtwBbAb5ZEIkTzxT4h2p
VB9dpjsURX82ph88UtVcdKt6apC5VYKQb9NE2gCgAqoeHsxFUpDAtHybWBaIeWI9
3G1ZhGIm1YUIL4ehaFKeCmjy3HutnPyxdorqrP4lhke0pTKYzQ4VeHi9V6MQpESg
Kj4wRPSHTzd9NcC15iRaKMm4iob0zSmpMWz9NXf0Yg85rH3uVI/J8e8Gj1NWPLbM
ao62WLbY/Xyb576AVJyOeRGQkAcBqcDvK5Q9E65JJ5zGG9PvtnIUNaPqa40hiK+F
gu+ZiCcqF7LYbeOaVvuzmziTb+f5E1zXNTdu4YhUD4FLJ0u/Dhs/squ2tsA3qak1
6OsxXEOsGImE84N+tyKNxi3E+jmeCoyuO58TRfKRfcmwGA1POMy5TgAK1CLv0g+k
BpTcyfoPpg7SxVRILNzdhcmaVAtpmvyn2uF1z1/bqtg3G7veJ8Y=
=0j7m
-----END PGP SIGNATURE-----

--nextPart2875872.j8hLqmcBA4--



