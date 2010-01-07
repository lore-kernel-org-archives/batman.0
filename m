Return-Path: <linus.luessing@web.de>
Date: Thu, 7 Jan 2010 23:02:14 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100107220212.GB2554@Linus-Debian>
References: <5522db2e1001050935j3ea06437k3ffe0119d34d93b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <5522db2e1001050935j3ea06437k3ffe0119d34d93b3@mail.gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] mdns over batman-adv
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


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jan 05, 2010 at 12:35:49PM -0500, Eric Smith wrote:
> I am using batman-adv and can see multiple nodes in my ad-hoc network.
>  However I can't seem to see the avahi services of the nodes that require a
> hop.  Is there some configuration I need to get this to work?
I've never actually tried/used avahi. But as far as I know
zeroconf uses arp in ipv4 networks to detect available / coliding
ip adresses which should work well with batman-adv. For the
service discovery (i.e. for mDNS) multicast IP packets are being
used, these as well should be forwarded to all other batman-adv
nodes and mesh-clients.
So as far as I know, there is no need for a special configuration
to get avahi working. But if anyone else has some deeper knowledge
about zeroconf stuff? (or might even have some practical
experiences)

Cheers, Linus

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLRlnkAAoJEBKw7u43QNpfAlEP/i8gYy1WjDDie4dGmUqvfdHT
yDFo3hh2yTcDHhFqwStTtDWLuUQX2fMNI4kwDFuOsBfMqbtnVMpwYuc8edvKCw0a
kYbrwrMWQmUkg5JDtlyTQQLKQm5v1rVImuhQVOuemU+Mr04egZV3qDkqYKOsQBlc
cvZpaR0GmNwdu+tPC/KgSVLUNpW35H4WAvwjJJ5PCy9waL9ZPM+/4DTM1lY2m8Vt
1m0NLZ2InbPvikSpL+G6onHY54lcL7Eep2z/sspIN7uoH7bAhHy0KvB5omUV/Tej
O3vtyTVy1zt8lbiUPm2d6/7LRHOJVgbdjM4bIwGeVe3PDxtu2Y9T3wYB/zK6Uzvr
Ja1wJ6BtbSArreKgzdVz5kL7pVlLSWBiA32KcQEiCpEE/0DMXha3fXsT5z4B8geW
ifc0Tq/Cc4Bu+HefK75u0iobu2adJgNcdr3/ThCrTuId1z27eA4tP8Yr91ULTmHM
plvDiAwEwmKtRQ6vrvoYZmib1wGeDNqYoqVS8iT3Fx/kZVURaHsH3pazchsyhFz/
mCBzGi85ZGasMIR794qOhiZV45aO3KhT8JO3KGQCqaoOBuLwibzDzrj6W5NCOQos
Akq4PkQDtP3vBsScy6Rbz1dqCRCX8oYD0jCsiw2pRiim1Vk+3NVR/4KtV/TXmmTL
q1gYBeljt2ylP3+6tNcn
=4r06
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
