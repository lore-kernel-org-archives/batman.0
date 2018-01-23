Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Jan 2018 13:33:01 +0100
Message-ID: <2280205.kRTqscCMRg@bentobox>
In-Reply-To: <4799954.f95c8XAbim@sven-edge>
References: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
 <2528254.P9avF0yZu7@bentobox> <4799954.f95c8XAbim@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5518173.ts8ksIh0YP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] limit of if per batman
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

--nextPart5518173.ts8ksIh0YP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 26. Dezember 2017 15:19:41 CET Sven Eckelmann wrote:
> On Mittwoch, 25. Januar 2017 08:15:52 CET Sven Eckelmann wrote:
> [...]
> > > this made me curious , and i modified your script a bit - turns out
> > > after the 127. IF you add to batman-adv you get an Error -
> > > all 510 gretap links was succesfully build ...
> > > # ifconfig |grep gre| wc -l
> > > 515
> > > # batctl if|sort|wc -l
> > > 127
> > > the error is mainly
> > > *Error - can't write to file
> > > '/sys/class/net/gre128/batman_adv/mesh_iface': Cannot allocate memory
> > [...]
> [...]
> > I would guess that your system mostly fails becauseit  cannot handle the
> > allocation of the "large" arrays which store:
> [...]
> 
> Looks like their could also be a different problem when your test system uses 
> signed characters by default. Please try the patch [1] which changes the type 
> from char/s16 to unsigned int.
[...]
> [1] https://patchwork.open-mesh.org/patch/17247/

Were you able to run some tests?

Kind regards,
	Sven


--nextPart5518173.ts8ksIh0YP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpnK30ACgkQXYcKB8Em
e0b8uBAAxTSDlgYWve5RTRag3fuPI06thtOaLffnGFhTPc1G5IssjbFy8y5cPlao
iLEQaTb65358jf8aivG+gVM4SqARvH6PRsWDVucy5/6tARon3tHpLWhGp2dit4zc
ZgeQ0jEz+Cn9Ue0B54s0AYSBSfT3OC06ZTWenK/rc+kBQf12KeYFtftcXfeWuWZ+
WMnN3dzUKaXTA3DrDgIkyorJ1pWJD05xapF4O+9OiBQQOIjRxKXZcA3jtCWaAM9h
iU9kXIds7ekh6DbrkBB2WkqfYoaGzCKDcLNM0ISc/yc90iqPuir4HQ+jWJAG8Uvq
ePFDmjchhupF3FsdfbpdeXzQt3lAL8atMfjpByuPp7lxpU4DR6VDLoZL+M6cRqqa
65bL3AzrLw9PkoDDhQO9WTZKVcI4ciWnmwCblbAwFiqY1nU11qMrnVZwYW4GLT46
v8lFe1XGTZ/dSEwopqhBLncVSTzap8DYJlYkaqrYdvaFNSFSaQGMWTRnJcn8y9E5
9M3QYFzSr0pi4h3fG3ugraEokvDniTYD+H0cz8U74OvHANlJCsACF/L1mGOabwaN
XrTXFvw3TvsLkGdx+XQfZvdBr7vhE4YLOJn5dO61Rkm2vlBL78qp+9FsbTHc9HUo
OishC3yHYrb/54j21oW/CVrS1gZH0KMKf0O68+UMQh2op+RfzPM=
=9G6f
-----END PGP SIGNATURE-----

--nextPart5518173.ts8ksIh0YP--

