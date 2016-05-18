Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed, 18 May 2016 11:38:20 +0200
Message-ID: <4816418.hDXNbSuFUQ@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2486891.3mT3dFWJdX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v11 0/3] batman-adv: throughput meter
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

--nextPart2486891.3mT3dFWJdX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Antonio had some extra suggestions about the tpmeter. All are now included in
the patchset. I have also noticed some problems with the patches
(net.git/net-next.git) scheduled for 4.7 which required some adjustments to
the netlink code.

batman-adv:

 * moved batadv_tp_meter_init to batadv_init (main.c)
 * fixed missing space in kerneldoc between "<" and "0"
 * port to nla_put_u64_64bit
 * add compat code for nla_put_u64_64bit
 * introduce attribute BATADV_ATTR_PAD which is used for alignment
 * rename batadv_real_genl_register_family back to genl_register_family in
   compat-include

batctl:

 * introduce new attribute BATADV_ATTR_PAD used for u64 alignment

Kind regards,
	Sven
--nextPart2486891.3mT3dFWJdX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXPDgMAAoJEF2HCgfBJntG+4UP/1GyZWrwUtFXxnAFgMH/VaM9
roUIlGPM07KHUW3vdTJ479/23B84+W+3hWvICxp6eUs4KKfTUAmyLjeK5U1Pq/aO
jimXnWFKzLgsFD5VFw7y72WXy1oWgxaEgjXtrsZ+PiIT/w/aJcv+BuYxhVj/3XZ5
zIV9v+JJO0qfQrtmK/FS732tUS87HaSUl+cuK0Npao446cEcncbAuAum4JHidOBB
r6AfEgbtKevenjYbeYesjR9HdEAHaO4yZgnjLwxl27RDRqSBLOCHYZENfr1odEtq
u70cIK6q+PiWl8rDG0ZJ1egGR7XqfUgtLdJhZqm/pBAxRXtrF8eF2ozyKEcrdhvi
wZ1MWIf/jmxiC+seLjGBKfFnRAVs7DGta+ij5oO3XfmZC24gMfVvtEqKze5hV24V
uMFtEOruf+D2KjKkhzafm/YtYGW5mM1ulxIYgmCo/eTw30eWp2Yz6HtuhkDuD8xn
KU2xujtQxBPXigYvljoQ/IC4YgmBeBI/2zhzywpTTTVP2C3XBKqODw/ybaoA6Lg1
v0u/j38WrDKc/GQ21AipNM3K+nzxu8PYXlce7dySAmUPqJL25RGqNI8ORq+g9Zn3
7Gs6+Am3wMAtCb27C+E5pnwGWsLXfPZzJVDTX0xYtT/SceoU9xGrlBA3/au0EJLn
TSMeegXw7QqsTpE+lXNl
=ATVq
-----END PGP SIGNATURE-----

--nextPart2486891.3mT3dFWJdX--

