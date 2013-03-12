Return-Path: <ordex@autistici.org>
Date: Tue, 12 Mar 2013 09:33:23 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130312083323.GB8563@ritirata.org>
References: <CAHQ_bginU7MXj-EAiy9PUEaWXC0JWTD-1ZbaEH6K4VLad2t89g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <CAHQ_bginU7MXj-EAiy9PUEaWXC0JWTD-1ZbaEH6K4VLad2t89g@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Ping related issue in batman-adv-2013.0.0
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


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 11:25:18 +0530, ajeet singh wrote:
> Hello All,
>=20
> I am getting a problem with batman-adv-2013.0.0,
>=20
> Please find the details,
>=20
> I have two batman-adv nodes A and B,
>=20
> Initial setup:
> A (bat0: 192.0.0.1) ---------- B (bat0: 192.0.0.2)
> Ping is working properly between node A and node B.
>=20
> Setup after restarting B:
>  A (bat0: 192.0.0.1) ---------- B (bat0: 192.0.0.2)
> After restarting node B, I am setting the same IP as previously to B
> (192.0.0.2) but this node (B) is not reachable from A for quite some
> time.
>=20
> Note: If I assign some other IP to B after restart for example
> 192.0.0.3, node A is able to ping B without any delay.
>=20
> Please let me know this is the problem due to DAT or something else.

Hello Ajeet,

I thought about it and I think this is a consequence of DAT caching bat0's
address.
When you restart B, its bat0's MAC address is randomly renewed and therefore
you have to wait for its IP address to timeout on A's DAT cache table.

If you change IP you don't see this problem because A does not have it in i=
ts
cache and will store it along with the new bat0's MAC address.

Other than the bat0 mac address (which change at any restart) long timeouts=
 are
usually ok because the ARP entries do not change so often.

However, since batman-adv knows when a MAC address is removed from the netw=
ork
(see the Translation Table mechanism for this), we are thinking about a sol=
ution
which combines the two components in order to proactively remove obsolete A=
RP
entries from the DAT cache.

Thank you very much for reporting!
If you have any better idea or suggestion feel free to share! :)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRPuhTAAoJEADl0hg6qKeOYlkP/1pncf0UfCJXJdpR39OAMz22
HZNXkf7JYYsTlfinUp0UGyslhRQA/Xxxgn4eu2hp8JbgLCnz+LT3TxXj5pLxJgW5
GaKJ75VokmjqYbpvuJhENhoFeaCUeuKfz6zPxD79ZDtTQ8nDn+4mSVIp7YD299z1
RtnUGKy3G3J3q3V4qOp/ySO8/sUbteOJIoDZpeG3zkQC0X/iZcJ3KbZdFGUzwqj4
YBUjZ8jel3Kr9sAwQMHzBaU4HhSwuvxtCxP9KQoXRnfpco7XpVC0DyXlnXJB9zlN
6rqxHdEXzSod+UYWej2BPtbhEszn+jEGfl4fHBxEdt664D7bnG6Ev1vUZpRFl+dB
iizL9V8R/pq9QXXvBgmwhEr5+5Lr4BXHGnhFhWX/aBNy47/Ch/wBzKpqxEQ87Vcq
nhNTwIYSuwje8fswBZAJTV4cYNjrai0jks8KQ1xCLJoQBIL89+v9agENl0YuRmnV
NRg/B1behpocZR/Do1uxDRUdgthZBjZwWEk3bJ3mF/c04JLW8OjuPiJ6vzLIxjwZ
AVHroZiXDSSGwsfAHE760nm1RGwmdMKZfK3PrGODWmlKhG2nAO01cTScc52ODvE4
aul85Bk2kUxqY662MapDAIB2nZkvfBjbxAE1bG3Sb5Z/PkcpJiqGAdFL/SmCND4/
Tp6yR3C5T+4L0YrDPrtj
=9TC9
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
