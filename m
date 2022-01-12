Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: alfred: allow startup without network interface
Date: Wed, 12 Jan 2022 22:02:58 +0100
Message-ID: <10410848.OOsao9LFFs@rousseau>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1678592.4hFhtZiafV";
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

 
--nextPart1678592.4hFhtZiafV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: alfred: allow startup without network interface
Date: Wed, 12 Jan 2022 22:02:58 +0100
Message-ID: <10410848.OOsao9LFFs@rousseau>

Hi,

alfred could be used without any interface at all and operate as local data 
storage between 2 processes on the same system or the interface could be 
configured at a later time (via unix socket).

To allow for these additional use cases and keep the current behavior, the 
interface command line parameter shall accept 'none' as interface name 
(similar to the batman-adv interface).

Cheers,
Marek

--nextPart1678592.4hFhtZiafV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHfQgIACgkQU1VOj+62
HMDjpQgAhkM+znVLmicJjf0mzlqIolbg79+FtRqBynQ+imYX4w0tcRevk6D3SM8Q
l/M+Ld6ZdR59QlalDTou4yfakfUzECLrIvMAF5fo/G7YzPHtJAwonHy60kxGvkE0
oQuK6C8xEkkaHTVWdbdvuWgclgBQUFSxJAD+0R3UKSTU1pwABWOVzBzi5FDaF9nM
Fv+SNBxfzQ0k7bHkACjQ5Fo0QPYZs9z/77ntQ3JZ0MiGV6KvWxWiyCSOAe5DKOed
F08Z+y/DxrPS7fpVzIpEoB9AsMkOeBYQHYr3QfdXABak68L8BpxiY3KRRxHn8QE6
vyq5N7G9cdSSe9k/BVkShNDwiLXtIA==
=SBcI
-----END PGP SIGNATURE-----

--nextPart1678592.4hFhtZiafV--


