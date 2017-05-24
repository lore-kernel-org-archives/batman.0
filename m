Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 24 May 2017 12:31:28 +0200
Message-ID: <4690435.IOLn72U8Ez@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6233723.35ZseKWhTF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/5] alfred: TQ query optimizations
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

--nextPart6233723.35ZseKWhTF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

alfred uses the TQ from batman-adv to find its best alfred neighbor. This best 
neighbor information is used by slave servers to request/publish data.

This is done for each server announcement packet by:

 * requesting the global translation table (netlink or debugfs) and then
   searching in it for the MAC address of the detected alfred server to find
   its originator address
 * requesting the originator table (netlink or debugfs) and then searching it
   it for the originator address of the detected alfred server to find its TQ
   value

This was previously done whenever a new announcement packet received by 
alfred. We've observed that this can be a problem on networks with a lot of 
master servers (~100) which can see each other, large translation tables and 
slow CPUs. alfred still worked but the CPU load by alfred was rather high
(~20% on an 560MHz AR9344).

The idea is now to avoid this lookup for master servers. And (for slave 
servers) to process all servers at once. This is done before the wants to push 
its local data to a master server in an sync interval.

The process which was described earlier was now changed to:

 * requesting the global translation table (netlink or debugfs) and then put
   MAC address and corresponding originator address in tg hash
 * requesting the originator table (netlink or debugfs) and then put
   originator address and corresponding TQ value orig hash
 * got through all servers:
   - search in tg hash for for the MAC address of the alfred server to find
   its originator address
   - search in orig hash for for the originator address of the alfred server
     to find its TQ value

These changes reduced the load on the previously mentioned devices 
significantly.

Kind regards,
	Sven


Sven Eckelmann (5):
  alfred: Move alfred specific netlink code in separate file
  alfred: Only query tq of remote master in slave mode
  alfred: Check the TQ of master servers before pushing data
  alfred: Cache the TQ values for each originator
  alfred: Cache the global translation table entries

 Makefile         |   1 +
 alfred.h         |   1 -
 batadv_query.c   | 227 +++++++++++++++++++++++++++++++++++++++++--------------
 batadv_query.h   |  25 +++++-
 batadv_querynl.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 batadv_querynl.h |  34 +++++++++
 netlink.c        | 195 -----------------------------------------------
 netlink.h        |   7 --
 recv.c           |  15 +---
 server.c         |  56 +++++++++++++-
 10 files changed, 501 insertions(+), 276 deletions(-)
 create mode 100644 batadv_querynl.c
 create mode 100644 batadv_querynl.h
--nextPart6233723.35ZseKWhTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlklYQAACgkQXYcKB8Em
e0ZFShAAlK7ScWEkH0cJutyJ5JbDct+SnZxaO7gmcRsWufA9B+QHxf5po9Fkbb3e
MGE1iE6FSkmxj3G19oUph6dWZsMVIj1BN5vAS7tItJq2iKmmlobJMy5FqyZOYT3u
MOhaX57wXocu3df6m7I1P1rS6BsSlsaPZSYL1xIOMQEHnO8JBDZseQVleB+8fKho
gzbsc7ds//L7asRjd/W80KQtpMXOXf03bua/JBABUQvcqGyyO8sABU7iVDsyjTLe
4J2OAKXTUNytnfsTV2wx9RuQgfSUPLt4FylI1xKrQDAZAg6ULd+JqQLed06t8f18
9FS0lDQ6+RKLcoM56WdYeWQVnbg2HQK9+WVO4d8AGr8Jga/oHJrL7w/10hCWB/g2
jSSkO2aNmCHid3GVoPu/BOi+iYQPlULAS/TsC6IFZzIzC9nfKPN8XhYCANWVBiPL
ugtPcz8FZn53ejrmKx/0G4b2zbSx14PhU1JmDSZhRRIVdHosPr5LhjbYucO1VtEs
b6yFjAOsaVF2TXLfLgbZy15EJWPV7SvItmFBR/Vs/GM7qfxpkMvvLu+Ro7Rs1ktp
NfKb7kpZyBR1QgIsFFEDoNIzUE7QUh/JD/Di9keRKuYMqSN6AloQivUhx9CZs3n9
jYQ1aTDJO70iXID/UatHM4hP6mXBn5XgN/qOD8Cl6aq2VLj5nVw=
=Oe+2
-----END PGP SIGNATURE-----

--nextPart6233723.35ZseKWhTF--

