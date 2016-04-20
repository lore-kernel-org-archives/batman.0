Return-Path: <a@unstable.cc>
Date: Wed, 20 Apr 2016 11:23:22 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160420032322.GN6122@prodigo.lan>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <9919433.c4WuAskJuF@sven-edge> <20160313154222.GD9674@lunn.ch>
 <1812177.9NXi5yCt0r@prime> <20160420023640.GB13247@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline
In-Reply-To: <20160420023640.GB13247@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
 support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andrew Lunn <andrew@lunn.ch>


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2016 at 04:36:40AM +0200, Andrew Lunn wrote:
> I agree about debugfs. As i already said, i've played with netlink and
> netns. I changed my debugfs patch, so that it only creates files for
> the default netns. For all other netns, debugfs operations become a
> NOP, and you need to use netns.

I guess you meant "you need to use netlink" here ?

Thanks for your feedback.

Cheers,


--=20
Antonio Quartulli

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXFvYqAAoJEJ4aZjxxc6bKCVAQAMIXLvYaae0t6MLMa7RukbrJ
GRoQBStkJKDrGvsLkJr7lg47dM836kzqBJpDo6jvdSljqZfa/D8ckwrCddqPClYb
AEwkyiOno9dUOuRCn3HsutJg+Nrn0qaiesMXs5oByVs6L6bLbfrqph6G2bwaKeLU
rH34fGEhdqbV+qJLLYPv87w7HfPkg05Ozq+wpEt/Nsdl1Ztdm+lJtrM7c1z2TM+H
4WmcrppJI6dLkvtxRRsAPYUphaMDx0i4YfL8HL0Z5GnKHntPMtKe+Folr8PIhgRa
GgbDaH1IbUHKD1Uu+4DhQmAayTU+tBFlm1SaMnWqumeS5gDmcfJiWnFIDy/3/9sy
2jtXU4TVO6TZ0C5Uc6r0nt5FCwcnnQxzOIYh4TCwx29p2v8IQe3O8G59wpTvaco5
vfK/Jt7RctNZf46RqVnMqXNIFAs/SccZ+qMAkml9DPV81KgFX1XeEGvIxyIObwZm
c221IRscYbMQ9D4XfBBvHwU9MxuBSaePAI841wZjV3LzBImcZtPmA4EFPJbdQ7m5
omD31yWsexKor+02M801Tr79OXaL0rz5KIVLbr3j1IM+3reKXC0stNAoh2rq8kM8
OyirMeMRNAsWNFPyyyQm1LMWmRgleqCSICxgZ7j6PfkwhOg0F0c143+OYLKevNLj
sTKMH2E7PL0JGDOuS+H6
=H5GI
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
