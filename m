Return-Path: <mschiffer@universe-factory.net>
Message-ID: <54C779EE.5010509@universe-factory.net>
Date: Tue, 27 Jan 2015 12:43:42 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <b4fac27152a34dd39d59ca0b83de0157a8f7805f.1422326992.git.mschiffer@universe-factory.net>
 <2512638.rHeWM5fpXe@giomium>
In-Reply-To: <2512638.rHeWM5fpXe@giomium>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qtJ5evPb6xpIjTwEewbiKNqxIjrKopEpj"
Subject: Re: [B.A.T.M.A.N.] [OpenWrt-Devel] [PATCH netifd] bridge: allow
 enabling or disabling the multicast querier independently of IGMP snooping
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
To: Gioacchino Mazzurco <gio@eigenlab.org>
Cc: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qtJ5evPb6xpIjTwEewbiKNqxIjrKopEpj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Regarding IGMP/MLD, batman-adv will just provide an overlay ethernet
layer, on which the normal rules of RFC2710 / RFC3376 will be used to
elect the querier: the router with the lowest IP address that has the
querier feature enabled becomes the querier.

Linus L=FCssing, who developled the multicast optimization feature for
batman-adv, suggested to only enable IGMP/MLD snooping, but not the
querier, on normal mesh nodes, which is why I wrote this patch.


On 01/27/2015 11:48 AM, Gioacchino Mazzurco wrote:
> Reading this mail seems that who installa batman-adv nodes should do th=
is=20
> setting manually, doesn't batman-adv know/(can estimate) who is the goo=
de node=20
> were to put the querier?
>=20
> What happen if we have the querier on every node?
>=20
> Thanks!
>=20
> On Tuesday, January 27, 2015 03:49:52 AM Matthias Schiffer wrote:
>> In larger networks, especially big batman-adv meshes, it may be desira=
ble to
>> enable IGMP snooping on every bridge without enabling the multicast qu=
erier
>> to specifically put the querier on a well-connected node.
>>
>> This patch adds a new UCI option 'multicast_querier' for bridges which=

>> allows this. The default is still the value of the 'igmp_snooping' opt=
ion
>> to maintain backwards compatiblity.
>>
>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>> ---
>>  bridge.c       | 8 +++++++-
>>  system-linux.c | 2 +-
>>  system.h       | 1 +
>>  3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/bridge.c b/bridge.c
>> index f8478ad..f7dbf61 100644
>> --- a/bridge.c
>> +++ b/bridge.c
>> @@ -32,6 +32,7 @@ enum {
>>  	BRIDGE_ATTR_HELLO_TIME,
>>  	BRIDGE_ATTR_MAX_AGE,
>>  	BRIDGE_ATTR_BRIDGE_EMPTY,
>> +	BRIDGE_ATTR_MULTICAST_QUERIER,
>>  	__BRIDGE_ATTR_MAX
>>  };
>>
>> @@ -45,6 +46,7 @@ static const struct blobmsg_policy
>> bridge_attrs[__BRIDGE_ATTR_MAX] =3D { [BRIDGE_ATTR_MAX_AGE] =3D { "max=
_age",
>> BLOBMSG_TYPE_INT32 },
>>  	[BRIDGE_ATTR_IGMP_SNOOP] =3D { "igmp_snooping", BLOBMSG_TYPE_BOOL },=

>>  	[BRIDGE_ATTR_BRIDGE_EMPTY] =3D { "bridge_empty", BLOBMSG_TYPE_BOOL }=
,
>> +	[BRIDGE_ATTR_MULTICAST_QUERIER] =3D { "multicast_querier", BLOBMSG_T=
YPE_BOOL
>> }, };
>>
>>  static const struct uci_blob_param_info bridge_attr_info[__BRIDGE_ATT=
R_MAX]
>> =3D { @@ -547,6 +549,7 @@ bridge_apply_settings(struct bridge_state *b=
st,
>> struct blob_attr **tb) cfg->stp =3D false;
>>  	cfg->forward_delay =3D 2;
>>  	cfg->igmp_snoop =3D true;
>> +	cfg->multicast_querier =3D true;
>>  	cfg->bridge_empty =3D false;
>>  	cfg->priority =3D 0x7FFF;
>>
>> @@ -560,7 +563,10 @@ bridge_apply_settings(struct bridge_state *bst, s=
truct
>> blob_attr **tb) cfg->priority =3D blobmsg_get_u32(cur);
>>
>>  	if ((cur =3D tb[BRIDGE_ATTR_IGMP_SNOOP]))
>> -		cfg->igmp_snoop =3D blobmsg_get_bool(cur);
>> +		cfg->multicast_querier =3D cfg->igmp_snoop =3D blobmsg_get_bool(cur=
);
>> +
>> +	if ((cur =3D tb[BRIDGE_ATTR_MULTICAST_QUERIER]))
>> +		cfg->multicast_querier =3D blobmsg_get_bool(cur);
>>
>>  	if ((cur =3D tb[BRIDGE_ATTR_AGEING_TIME])) {
>>  		cfg->ageing_time =3D blobmsg_get_u32(cur);
>> diff --git a/system-linux.c b/system-linux.c
>> index 4737fa6..ef90880 100644
>> --- a/system-linux.c
>> +++ b/system-linux.c
>> @@ -772,7 +772,7 @@ int system_bridge_addbr(struct device *bridge, str=
uct
>> bridge_config *cfg) bridge->ifname, cfg->igmp_snoop ? "1" : "0");
>>
>>  =09
> system_set_dev_sysctl("/sys/devices/virtual/net/%s/bridge/multicast_que=
rie
>> r", -		bridge->ifname, cfg->igmp_snoop ? "1" : "0");
>> +		bridge->ifname, cfg->multicast_querier ? "1" : "0");
>>
>>  	args[0] =3D BRCTL_SET_BRIDGE_PRIORITY;
>>  	args[1] =3D cfg->priority;
>> diff --git a/system.h b/system.h
>> index 9a2326b..94e0dd9 100644
>> --- a/system.h
>> +++ b/system.h
>> @@ -50,6 +50,7 @@ struct bridge_config {
>>  	enum bridge_opt flags;
>>  	bool stp;
>>  	bool igmp_snoop;
>> +	bool multicast_querier;
>>  	unsigned short priority;
>>  	int forward_delay;
>>  	bool bridge_empty;
>=20



--qtJ5evPb6xpIjTwEewbiKNqxIjrKopEpj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUx3nuAAoJEBbvP2TLIB2c2y8P/jlGS9EjAndsekgNR4QxRm7a
TgwFDxvO7Sk2G9u0r7jeBDhRw471VoWxm0c5iXf/baErmMZ0tt+xpCvX73eTsMAR
OqxL0N8G7PeeQ/mewwWae53+juH7op82P1U1qcBMShBYN0m8b0EFCQCUzk90TVBu
XBk7fvfQch1jhDc9gCFtJLoFZwplXHA8ZdZ9xtLykIw4Ye1JnZStPpBM6n4rJ8A3
gyRFXrYz0LrpOiXySr7zzyx57giPqgMtm/cRHxEnGIAvVkHxZAdILlIVzWIFjrxF
kS/wkVx9fYX6cef7bgRkUAIaX7vnVTSrqx69YWDESK7Z+Oxqy2cZoVsLkqM99Djk
0JVMTe72F6KHd9IxcLEOmsTIfO5ifIiJCXSOYhH5kUtv7ltwXTxYsFAWVdUt1zCf
NEWelEZtGzcVs5z8hAETIaLPs/zKbYZuHwSkMIXdO8n48XAMf3eB6xHCqVpBhuv5
8lVvVrCV8bwBaZbn9p227r+HPVMgAuJVBdAmuBijaa5I/3PgIGoyzJAWMtdfHJUL
iKpLqmwObe71bOOgrAZTNjW4Gj9wJtI7hf4kCzRePgHUbKknU4je60Mf1to7nuE0
jftJZkimMK3gv3VGwzDxK2pLURDHUGkeoVT2zSQHN/9npiunXYwZ9dLUcN0j11H0
+HEVTeh7ArP2ap75SPTU
=pygV
-----END PGP SIGNATURE-----

--qtJ5evPb6xpIjTwEewbiKNqxIjrKopEpj--
