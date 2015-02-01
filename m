Return-Path: <moritzwarning@web.de>
Message-ID: <54CE26E4.7070307@web.de>
Date: Sun, 01 Feb 2015 14:15:16 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qphVUi4LcHIJQ22IKH9JIEKPpJRAMSppH"
Subject: [B.A.T.M.A.N.] batctl: feature to filter nodes/clients
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qphVUi4LcHIJQ22IKH9JIEKPpJRAMSppH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I need to display the number of all nodes/clients as well as all neighbor=
 nodes/clients.
This would be easy if batctl would be able to output the respective
list of mac addresses (batctl ... | wc -l).

I've started writing a patch as part of a feature request:
http://www.open-mesh.org/issues/203

But the problem is how to get the respective output form the debug tables=
=2E
I have been reading the docs, but have not been able
to understand the necessary information needed, no offense:

http://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batman-=
adv-network

Some explanation beforehand:
Clients are computers not running batman-adv,
represented by the MAC address of its network interface.
Nodes are computers running batman-adv,
represented by the MAC address of its primary interface.

List of all nodes:
Get all MACs from the 'Originator' column of the originator table

List of all neighbor nodes:
Get all MACs from the 'Nexthop' column of the originator table
and make it a unique list.

List of all clients:
Get all MACs of the 'Client' column of the transtable_local table
when it starts with a '*' character.

List of all neighbor clients:
Get all MACs of the 'Client' column of the transtable_global table
when it starts with a '*' character and when the nodes own originator
MAC (of the primary interface?) is also in the 'Originator' column.

I do not think this approach is correct, yet.
Maybe someone can drop some hints.

thanks,
mwarning



--qphVUi4LcHIJQ22IKH9JIEKPpJRAMSppH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCAAGBQJUziblAAoJECHrh56PP4wpdFYIAMDdDemSIzVBEauaf9LnTOQz
n2JPkqMsT8gZQdXT7RZJEKwOhhzmQ1scQoZAxjJSXDB1xlWTueChifS9wtL+Zozi
tPv2JXHGZHWIifYbOBnfF/tmdhW57AIwwdnhI6oyIg5Z6/A9n9LVD8pgK8EuOksZ
WaDb8gQHoGAU6rc0/bS9l+j/qcab/M8iDhBXXmrL7nAJRNCQUO/Tctk8821sq28N
xhYStTkQ8j0w9rjqiXpTM/f/Ufzk8fY0NpNYWjE61O7VSdg/Lg9vlXfLAznW+pLT
kpqYTAP/PQZTql2ieC5N2QME5scJ16JUA2AcHBU7Of7hgHiPGH7MuPZnSpAoj90=
=g1IH
-----END PGP SIGNATURE-----

--qphVUi4LcHIJQ22IKH9JIEKPpJRAMSppH--
