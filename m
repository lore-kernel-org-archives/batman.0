Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 11:48:16 +0100
Message-ID: <1562656.nUcF8KtnQf@sven-edge>
In-Reply-To: <1456867148-31883-3-git-send-email-andrew@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7258172.0Ozi5GYqQW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: Create batman soft
	interfaces within correct netns.
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart7258172.0Ozi5GYqQW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 01 March 2016 22:19:06 Andrew Lunn wrote:
> When creating a soft interface, create it in the same netns as the
> hard interface. Replace all references to init_net with the correct
> name space for the interface being manipulated.
> 
> Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@unstable.cc>
> ---
> 
> v2:
>   struct net forward declarations
>   Removed unneeded net/net_namespace.h
>   Rebased on https://git.open-mesh.org/batman-adv.git master
> ---
>  net/batman-adv/hard-interface.c    | 9 +++++----
>  net/batman-adv/hard-interface.h    | 3 ++-
>  net/batman-adv/soft-interface.c    | 7 +++++--
>  net/batman-adv/soft-interface.h    | 3 ++-
>  net/batman-adv/sysfs.c             | 3 ++-
>  net/batman-adv/translation-table.c | 4 ++--
>  6 files changed, 18 insertions(+), 11 deletions(-)

Just so that I have mentioned it: In theory '#include <net/net_namespace.h>' 
should be removed by this patch (hard-interface.c) and added again in the next 
patch. But this would be rather useless when applying the two patches 
together. It may be different when this patch is applied first without the 
next patch.

Just to be sure (and so that I don't have to test it here :) ): When this 
patch is applied, batadv_softif_create would already fail when the two 
namespaces have a batadv interface with the same name because the debugfs 
function would fail. But it would work when the batman-adv interfaces + the 
slave interfaces (for per-slave interface information) have different names. 
Right?

Just some of my notes (just in case someone else asks himself the same 
questions):

It looks to me that the only reason a device from a different namespace isn't 
added is because batadv_softif_slave_add + batadv_store_mesh_iface is getting 
the namespace of the new slave device and batadv_hardif_enable_interface then 
only searches the soft-interface (batX) in this namespace.

It is currently not prevented that a slave device changes the namespace after 
it was added. But this should not be a problem because the device will be 
first removed from the original namespace (so it will be removed from batX) 
and later added to the target namespace (see dev_change_net_namespace).


Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart7258172.0Ozi5GYqQW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5UVwAAoJEF2HCgfBJntGGC4P/j1loM4etxeDUojFTwr6YI0b
YMpAECBrO5OvIh3If2WiAqRwUibh80pgF/hb4MBfYau27ns7mgC2g5QuElTXR1LZ
71fdsG6zys59M/gcBMfUYBj9xR0/OR7yqSw7juLcZ8ppDxNzE5oDMG9g9epIaYOC
cqEWkiVWFZl6fwk9zmWrP9nxXCxrsrhN9l7qtu402hZD4Bz+CvWdMP3ALxVRCNtA
SfqRhqmnkfWDJEUY6X3OB2c+7d91UiCZL04+ATM/VSodktydNfl3PFSERU86sveG
nHiLfRqF4X5WmzBg1+Wg1YAtPH/UE2LkdOGznQMzFwplX69Hsd9RxhMyhn0EDCI5
jh7QBD6RsnqFiPrNo4dpveoauhun1X2BW13Vt7MbcD2aSY8WChdKipWrZdILayc+
aH2mutLMMM3f4ZeWTx1rfIVbRnvlXxbRNSNUJmLA2ny6X2ebueKJEk+FJ42xvL/E
w5j0XdcDLxgksqFHmpiq2QSqvoEgc6oZExhvBS4T/WAl06EfvWHaE1B0woDaH2PU
F+F4mvGh24QqiCJNe+vWjnKZnyjjeAXVrRMPU3IPYyQu/wJTMOmU0NVwdddNltMV
xgEtxmsT/iTHUHRFhUd+UZhEibwg5/73mzloQ+OzORMhoxPKEBP9SSbUpQtReaY9
CV0ucn9InP2T6XwwNSup
=+LSd
-----END PGP SIGNATURE-----

--nextPart7258172.0Ozi5GYqQW--

