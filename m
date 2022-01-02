Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: alfred: runtime configuration
Date: Sun, 02 Jan 2022 12:30:23 +0100
Message-ID: <3748133.vRqKQLy7FI@rousseau>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2744425.ns5P1vhYYd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart2744425.ns5P1vhYYd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: alfred: runtime configuration
Date: Sun, 02 Jan 2022 12:30:23 +0100
Message-ID: <3748133.vRqKQLy7FI@rousseau>

Hi,

the alfred daemon has built-in capabilities for accepting runtime 
configuration. Network interfaces and alfred 'mode' (primary/secondary) 
settings can be modified via instructions sent over unix socket.

To make all settings configurable, the unix socket commands are extended to 
also support setting the batman-adv interface name at runtime. Network 
interfaces should no longer be required at startup as those can be configured 
at runtime.

All these runtime settings make understanding the current alfred configuration 
tricky. Therefore, alfred should be able to export its operating configuration 
via unix socket.

Cheers,
Marek

--nextPart2744425.ns5P1vhYYd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHRjM8ACgkQU1VOj+62
HMC+/Qf5AeDv8PmFhGPNSW2wFAcxxeLEgGalXyrwM1Zk0alru62ln4XSJAqWN9l+
Ox5mdYzkLE6la2cVm7xaJFqfM6FzaNC8nGMVcVd6AtEYt2wldB5Pb8TiANyTX3ET
XJ14gy42/2rpljdqtMRJEO9lh/Et3dEXExjf5TGGk0aVfvIDrEwc1nHeqbMNeg64
UyMtZZnr6nZq/tsClat+3CSbOA6ynZxti+k12JjciPP1OHDUhiheAlDojymcGWWu
K8TklX4dxL8Up46pnzc7tU+gx6j9/vsLO5u8A5+db1oFXmMXGTHekgqn0nqUgzCx
S8kIVecKefdbC6D7RPCcJBxVBjb9dQ==
=AXYb
-----END PGP SIGNATURE-----

--nextPart2744425.ns5P1vhYYd--


