Return-Path: <antonio@meshcoding.com>
Message-ID: <52FCA639.9080204@meshcoding.com>
Date: Thu, 13 Feb 2014 12:02:17 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <20140213105249.GH7193@lunn.ch>
In-Reply-To: <20140213105249.GH7193@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CoAbCvRiBXjb9tPpcrvAMVf0u3KeRkbCL"
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
 determine link characteristics
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CoAbCvRiBXjb9tPpcrvAMVf0u3KeRkbCL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 11:52, Andrew Lunn wrote:
> On Tue, Feb 11, 2014 at 01:48:18PM +0100, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@open-mesh.com>
>>
>> The phydev member of a net_device can be used to get
>> information about an ethernet link like HALF/FULL_DUPLEX
>> and advertised bandwidth (e.g. 100/10Mbps).
>>
>> This information are then stored in the hard_iface object
>> to be used during the metric computation routine.
>>
>> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
>> ---
>>  bat_v_elp.c      |  8 ++++++++
>>  bat_v_ogm.c      |  4 ++--
>>  hard-interface.c | 19 +++++++++++++++++++
>>  types.h          | 12 ++++++++++++
>>  4 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/bat_v_elp.c b/bat_v_elp.c
>> index 763113e..958843c 100644
>> --- a/bat_v_elp.c
>> +++ b/bat_v_elp.c
>> @@ -78,6 +78,14 @@ batadv_v_elp_get_throughput(struct batadv_elp_neigh=
_node *neigh)
>>  	if (throughput !=3D 0)
>>  		return throughput;
>> =20
>> +	/* In case of Ethernet interface, the throughput has already been
>> +	 * obtained from the phydev object in the net_device struct (see
>> +	 * batadv_hardif_activate_interface()). So return this value.
>> +	 */
>> +	throughput =3D hard_iface->bat_v.eth_throughput;
>> +	if (throughput !=3D 0)
>> +		return throughput;
>> +
>>  	/* if this is a wireless device, then ask its throughput through
>>  	 * cfg80211 API
>>  	 */
>> diff --git a/bat_v_ogm.c b/bat_v_ogm.c
>> index fa3d1a1..060ce80 100644
>> --- a/bat_v_ogm.c
>> +++ b/bat_v_ogm.c
>> @@ -393,8 +393,8 @@ static uint32_t batadv_v_penalty(struct batadv_pri=
v *bat_priv,
>>  	/* proportion to use the same value used in batman iv (x * 128 / 256=
) */
>>  	hop_penalty =3D hop_penalty * 100 / 255;
>> =20
>> -	if (batadv_is_wifi_netdev(if_incoming->net_dev) &&
>> -	    metric > link_metric / 10)
>> +	if ((if_incoming->bat_v.flags & BATADV_FULL_DUPLEX) &&
>> +	    (metric > link_metric / 10))
>>  		return metric / 2;
>> =20
>>  	return metric * (100 - hop_penalty) / 100;
>> diff --git a/hard-interface.c b/hard-interface.c
>> index 2a04130..58c8669 100644
>> --- a/hard-interface.c
>> +++ b/hard-interface.c
>> @@ -31,6 +31,8 @@
>> =20
>>  #include <linux/if_arp.h>
>>  #include <linux/if_ether.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/phy.h>
>> =20
>>  void batadv_hardif_free_rcu(struct rcu_head *rcu)
>>  {
>> @@ -297,6 +299,7 @@ void batadv_update_min_mtu(struct net_device *soft=
_iface)
>>  static void
>>  batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface=
)
>>  {
>> +	struct net_device *dev =3D hard_iface->net_dev;
>>  	struct batadv_priv *bat_priv;
>>  	struct batadv_hard_iface *primary_if =3D NULL;
>> =20
>> @@ -315,6 +318,22 @@ batadv_hardif_activate_interface(struct batadv_ha=
rd_iface *hard_iface)
>>  	if (!primary_if)
>>  		batadv_primary_if_select(bat_priv, hard_iface);
>> =20
>> +	/* set the default values */
>> +	hard_iface->bat_v.flags &=3D ~BATADV_FULL_DUPLEX;
>> +	hard_iface->bat_v.eth_throughput =3D 0;
>> +	if (dev->phydev) {
>> +		if (dev->phydev->duplex =3D=3D DUPLEX_FULL)
>> +			hard_iface->bat_v.flags |=3D BATADV_FULL_DUPLEX;
>> +
>> +		/* set the speed according to the phydev setting. Store the
>> +		 * value in Kbps (as done for the other throughput variables)
>> +		 */
>> +		if (dev->phydev->speed !=3D SPEED_UNKNOWN) {
>> +			hard_iface->bat_v.eth_throughput =3D dev->phydev->speed;
>> +			hard_iface->bat_v.eth_throughput *=3D 10;
>> +		}
>> +	}
>> +
>=20
> Hi Antonio
>=20
> If i'm reading this correctly, you get the bandwidth once when the
> interface is added to bat0?=20

it is invoked every time the interface is brought up. So if you
disconnect and then reconnect the cable (e.g. to connect the NIC to a
faster switch) this function is invoked again and the bandwidth is update=
d.

> Are we sure that auto-negotiation has
> finished? It can take a few seconds to complete after the interface is
> brought up. It would not be good to have batman use 10Mbps/Half Duplex
> on my gigabit links...

So it can take up to "few" seconds? I did not expect such a delay!

However this function if invoked when the NETDEV_UP event is issued by
the underlying system. I expect the event to be thrown when the
interface is ready to be used, not when the auto-negotiatin is still
going on. I will double check.

>=20
> Is there a notification mechanism which could be used to keep these
> values up to date? Or is that in a patch i have not yet got to.

No there is no notification mechanism.

I see only two ways of changing this value at runtime:

1) NIC disconnected and re-connected to a different "thing" -> NETDEV_UP
is issued, we re-read the values

2) the user manually changes the bandwidth (e.g. using ethtool) -> not
handled right now (I would also not consider it a high priority item),
but maybe the NETDEV_CHANGE event is fired up in this case?


Cheers,

--=20
Antonio Quartulli


--CoAbCvRiBXjb9tPpcrvAMVf0u3KeRkbCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/KY9AAoJEEKTMo6mOh1VX/UP+wfmJKTI7p/GTdTHbfNKFoEG
Er5oXdg5GmHwLT6L0mVvHxpwu82KxPj50wVc9ONprx6d63cNqgZ++mbiYZHNL0Bl
BXLPkQvMVPNvfEHhKvI/LZRWeypiMTKCEraV0ju2+YqGcydPZmg3Fp8DtSfMItj7
MVh335wOx63pGOPn7StzRFWBmy/cw7saCssT8yHvX0bBmxWnB6kL0kCYcQEty8zA
nXUR6jXJ99BYlh7wuvo4Hc5NtRCnMdpGWssf+lIZ9pYehWiF+gpigy6iaX4hqCzg
DC2CTgULfKemFvWCH6FAzWwNXLIOuYzXCbzwFWTBeMrwqMP0d5viCVoy4Pha2736
t4Y9zEAgR1nrM9hTeaRMCeQr8aFjsA/A+Iy34dXiwV75XK+Q0AneUAiX6StMbwvu
aA6MUNOTFh6vAqbkjPFhZFtwkOrKed3uZ0V2NMRtDuvuQK6GOa8Q8Y/dUx7W5xpr
W1kIIo5bOI3BC9NsCPA/FHqnEzzPuF0SBM1BQYgk476RHmULLzmHEqeGV+8E7SYH
NAf3HYrUHZwDTDF5ZqR6r5FC0J9ZOhG9zDFSd33Q1BTDY6+MWVuuRX9KudbWqYzw
yDLBwWsvjUfOs8S2hfVW6JA16bUepItASxyDyUtrmrBthwai9by+mA5Urxhw2avB
tIS16fc7exj+tL+cvP6Z
=YEIG
-----END PGP SIGNATURE-----

--CoAbCvRiBXjb9tPpcrvAMVf0u3KeRkbCL--
