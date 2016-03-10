Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 19:54:50 +0100
Message-ID: <1890819.Y64XMdRy2X@bentobox>
In-Reply-To: <1444205214-5307-1-git-send-email-linus.luessing@c0d3.blue>
References: <1444205214-5307-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1838503.ce1GejcuZW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv11 0/4] Multicast optimizations for
	bridges
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

--nextPart1838503.ce1GejcuZW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 07 October 2015 10:06:50 Linus L=FCssing wrote:
> This patchset enables the usage of the batman-adv multicast optimizat=
ions
> for scenarios involving bridges on top of e.g. bat0, too.
>=20
> The first one alters the forwarding behaviour for IGMP and MLD report=
s
> which is a prerequisite before enabling multicast optimizations in
> bridged setups. It also increases the MCAST TVLV version number to 2.=

> More on the issue of insufficient report handling with the v1
> MCAST TVLV can be found here:
>=20
> http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizat=
ions-listener-reports
>=20
> The second patch finally enables the multicast optimizations for
> bridged setups.
>=20
> Along come two more patches adding according debugging facilities
> to make it possible for the user to check why the multicast
> optimizations might not work ideally to give hints about
> what they might change about their topology.
>=20
>=20
> This patchset can be found in the current linus/multicast-bridge
> branch.


It looks like these patches don't apply anymore. Can you please resent =
it
or mark it correctly in patchwork [1,2,3,4].

Thanks,
        Sven

[1] https://patchwork.open-mesh.org/patch/4699/
[2] https://patchwork.open-mesh.org/patch/4729/
[3] https://patchwork.open-mesh.org/patch/4717/
[4] https://patchwork.open-mesh.org/patch/4723/
--nextPart1838503.ce1GejcuZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4cL6AAoJEF2HCgfBJntG2JYP/1rh3qYFXRATRX+kiQfRUYYc
iX0kl7xLFj8egVx3393GYKUeVMz3jgs8sdkXguBFmuEOJNtZ7/TTaUUjadUZy7+v
wYdPs+IqI8UDgQFw/B5uIGojcvrQvuDMcCsQ+LXj/k3rQtqYKDd8M6EQcFyF3pfk
DFCbo8m3QEJ55OMMOo1FISlY4RPjwOzaw0ijbngELjZpkOH48SRZt0wyFtO5zewM
M/G/xc2uvh8elE7fo1WUzkPhP/M+aZRetFuYlVulSkiAI6nOVrHfEd0T1beZ5lPc
hQKRcXv2j3uvzRiyQdGh9ltDORUe2VmsLJydhK0iCm0IcVqJLPH9+Hljdr861bdK
43y2F/iJVaYhoNebGS3NpImK5YmZq4abF7ID9da4CcKx7nu44HKB1oDUXpxhbt5N
aWFo0VukveKEu9b7r8DZ7rOi4kwBT+oZ/eFVvSVdsgJ4a7ha6N14uqzokaCqTvZb
QKbLY+XB3743iMESsoGLVGv3NtwESeeDKKgS0dCUrAnYlRYfTXHOxR/AaRuTm+2i
3w6BMdSyTj3Efp+MTjYg8Mliiinn9r5Y8eCD055M3nvIqQ+TOutOItdHHgqmMXzN
XmiM6qOlhz7wzQ3XdPQD2TxJvoO/kVu6k6nscnDtaaH0sRRWlmSSn2LQgBta9rRe
fuol0Dksp5lBIz4lz/iQ
=vKBJ
-----END PGP SIGNATURE-----

--nextPart1838503.ce1GejcuZW--

