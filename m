Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 Jul 2018 12:06:14 +0800
Message-ID: <1778848.TvDNe92q0N@rousseau>
In-Reply-To: <20180625172919.GA2433@otheros>
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
 <2744691.dbA1SKQ1ei@lafayette> <20180625172919.GA2433@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5218767.zEvQThrSPm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped
 DAT entry purge timeout in DHT
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

--nextPart5218767.zEvQThrSPm
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 26 June 2018 01:29:19 HKT Linus L=FCssing wrote:
> 1) Host (A) joins the network and has the IP_X / MAC_a
>    statically assigned.
> 2) Some ARP Requests reaches this host, it issues an ARP Reply
>    which populates the DHT.
> 3) The host leaves the network.
> 3) Another host (B) joins the network with IP_X / MAC_b
>    statically assigned.

Let's distinguish the problems we're trying to solve:

 * Cache consistency during updates: A local DAT cache which is not updated=
=20
during a cache update event, thus needs to time out faster and a global DAT=
=20
cache receiving regular updates with less need to update.

 * Timely cache update: The global cache shall be updated as soon as the=20
information is available.

My previous email focused on the former while your response is about the=20
latter. Is that your assessment too ?

Both problems require solving to fully support this dynamic environment you=
=20
are describing whilst reducing ARP traffic overhead.

Would you mind commenting on the cache consistency issue ? Antonio will=20
respond to your 'snoop outgoing ARP Requests' question separately.

Cheers,
Marek

--nextPart5218767.zEvQThrSPm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAltRX7YACgkQU1VOj+62
HMDnXwf+LusUTDwsPLrbkUcuKHo2/qLQm3OyZu9toFGRyIMo6iU2DHw3SHJfBZpt
se0MNdIlOX86bO9Q3Pa5yDQWqUv3rz6wlosdQiE8Sf0woign//3I4FD0CRMhIO4M
7N3R24WB66qyuUXx6j9ou8GEYbYhKm+j9HLXwkMGu2iMbCQZGl+80Q/t+z2SSRnZ
JYC/raf9hUIcUWzqvdoot/V8IsdRQ+z9H/rCY0VPQYiWmxYMPVOj25VYXpyyKD08
+06/SXtCmhqBXOKGkleLK1AgKI5j2h2PPU9YyDTC7DvozyzUCMD+aZSbNv4qrWK4
4UXveqLDwtI8MbXNWJs0bXG+j1REDQ==
=6Q59
-----END PGP SIGNATURE-----

--nextPart5218767.zEvQThrSPm--



