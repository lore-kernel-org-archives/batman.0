Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 24 Oct 2016 12:20:20 +0200
Message-ID: <2620660.dmJzxXI5bC@prime>
In-Reply-To: <2666783.nl87Kib46y@bentobox>
References: <2666783.nl87Kib46y@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10051015.IlueqGGtDC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/7] batman-adv: wifi interface
	detection on
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart10051015.IlueqGGtDC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, September 30, 2016 3:20:23 PM CEST Sven Eckelmann wrote:
> Hi,
> 
> Marek created some patches a while ago to automatically detect the wifi
> interface under virtual interfaces like VLANs. These patches had some
> problems because they failed to correctly set the num_bcasts in these
> situations and also had some locking problems.
> 
> The following patches try to address these by introducing a cache for the
> detected wifi configuration (wifi_flags which make taking the rtnl lock in
> critical section unnecessary) and by updating the num_bcast and wifi_flags
> when the interface behind iflink changes.
> 
>  * added patch "batman-adv: Return non-const ptr in batadv_getlink_net"
>  * added patch "batman-adv: Close two alignment holes in batadv_hard_iface"
>  * added patch "batman-adv: Cache the type of wifi device for each hardif"
>  * added patch "batman-adv: Update wifi flags on upper link change"
>  * introduced batadv_get_real_netdevice which can be used inside rtnl
>    locked contexts
>  * replaced wifi check functions with ones that use the wifi_flags cache
>  * use batadv_getlink_net to get the iflink net_namespace
>  * force rtnl_lock in batadv_get_real_netdev
> 
> Kind regards,
> 	Sven

Applied this series on 451eab1..846df98.

Thanks,
     Simon
--nextPart10051015.IlueqGGtDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYDeBkAAoJEKEr45hCkp6hUSoP/AyMoL6RPgMrpC2SKlDDTcQo
07sdzqtFgbmlah5LJHMOzh4qb74x12IxYN39+4D03oRsrHwaqYyNKFaWcwI89zAR
K26kffSizfdvcIvoerXR52GWDmtywtqqHZXnOfQ1g0PUWtX3bXitxZhpwnFJ/ib3
RY9h/K1GudxgKVYeeUHXmrJLNse9gRVjTMjzBRKQbDoF1aFIzPxrELQvNSmrH1Ps
T3x2sKywZ3M+3LIfjQOMfg5+jgKOQWaWfcIuOysOekmJD3Z4eV65kcb+8DdAzx1g
XSiLIejt6Z+c9S092V58sxHC4/lwx1hFx2As6nMW/CEEEm63ius3O9X8eZaBkyIu
yRMMDhl2+VPK1nOLCZIHUCsuvVXUcINhlpre7jm1W4dhqPcNgLGQjRBuW2suqib+
3cuTTAIhd1xT2rQARuL21HTlehvoKK2iDNKEaNTJmhvY9xSjY1vVUfkJF5V+pINq
FeQ5Gwop2PzaPFn+euALRdp1QqFcdZ1qJs+/CY1mZW/d/NoQv/3JlZQMN6iBjgLd
xf7QUZZkiCviIdRD9A7oGy8PtoIL5TrlAk+V1TkSx/juDCzsEp+EjjYPocybjN8X
D2OeVRi+8FMV53X/NzQs2JTwCs3pO6h+qBmnPDUrXJVgrn6IobYdNOQVs6Sb8gSq
BdvVBfv/efdz/pIqVGb8
=x6ex
-----END PGP SIGNATURE-----

--nextPart10051015.IlueqGGtDC--

