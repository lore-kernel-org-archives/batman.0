Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 07 May 2018 12:23:57 +0200
Message-ID: <7337501.sxbCbvYRv0@bentobox>
In-Reply-To: <b8f1dd55-d22a-0590-c27a-9c46344af809@irrelefant.net>
References: <20180506195559.32602-1-me@irrelefant.net>
 <2722022.Z6qn7ThOV8@bentobox>
 <b8f1dd55-d22a-0590-c27a-9c46344af809@irrelefant.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2771404.tAPPvJageb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: mitigate issue when
 empty vlan is received
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Leonardo =?ISO-8859-1?Q?M=F6rlein?= <me@irrelefant.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

--nextPart2771404.tAPPvJageb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 7. Mai 2018 10:06:20 CEST me wrote:
> On 05/07/2018 08:32 AM, Sven Eckelmann wrote:
> > Can you attach a (small) pcap of actual traffic which show a packet whi=
ch=20
> > triggers this behavior?
>=20
> For sure. See for the originator 5e:25:f7:13:2d:eb and vid=3D0x8000 in the
> attached pcap. I selected the interested packets (one ogm, one full
> table request and one full table response).

Thanks,

These are always from intermediate nodes. I was hoping to see the initial=20
packet which "introduced" the incorrect vid=3D0x8000 without entry in the f=
irst=20
place to better understand the problem which causes this.

At least I would have hoped that this might help the people at WBM to have =
a=20
better discussion about it. At least to understand whether this is from an=
=20
intermediate node or from the sender.

On Sonntag, 6. Mai 2018 21:55:59 CEST Leonardo M=F6rlein wrote:
[...]
> - The receiving batman-adv can not handle incoming TT announcements
>   with empty vlans. (The crc check routine batadv_tt_global_check_crc()
>   fails.)

This part is not 100% clear in the commit message.

Right now it just sounds like softif_vlan_list (see=20
batadv_tt_prepare_tvlv_local_data) has an "empty" vlan entry (an entry with=
out=20
mac addresses). Which brings me to the point that batadv_softif_create_vlan=
=20
initializes new vlan's with the CRC 0x0 before it adds it to the list (see =
tt/
batadv_vlan_tt in batadv_softif_vlan). We know now that the function=20
batadv_tt_local_update_crc is responsible for updating the crc (holding the=
=20
tt.commit_lock) on the sender site (for non-intermediate nodes). And this c=
rc=20
is calculated over the bat_priv->tt.local_hash - which (according to the cr=
c=20
0x0) doesn't have a single (non-NEW) entry for this VID. The return (new cr=
c)=20
is therefore 0x0 and it will be submitted this way.

The same should be true for the receiver. The batadv_tt_global_update_crc g=
oes=20
over the list of entries for this vid. And we just received a full table wh=
ich=20
only contains non-vlan entries and no vlan 0 entries. My assumption would=20
therefore be that the crc on the receiver should also be 0x0 when=20
batadv_tt_global_update_crc was done. But if it is not then it would mean t=
hat=20
there was still some entry on the receiver which batadv_tt_global_crc used =
to=20
calculate the crc for this vid or the crc was just not calculated for it=20
(because it doesn't exist).

The latter would match the content of the full table reply in your pcap, th=
e=20
comment in the patch and the info info I got from Antonio: The vid entry wi=
ll=20
only be created in the originator vlan_list when an entry was received (I=20
haven't checked this). This would sound to me like the vlan should just be=
=20
created instead of adding this workaround. But maybe you should discuss the=
=20
details here with Antonio because at the end it is just about the different=
=20
ways of handling "!vlan" case from your patch.



Btw. Antonio, wasn't the VLAN 0 always created on each device in the local=
=20
table by the VLAN driver? See the message

   [   29.866038] 8021q: adding VLAN 0 to HW filter on device bat0

when batman-adv attaches itself to the vlan monitoring. But usually, there =
is=20
at least one entry in it (the bat0 mac address). Not sure why this isn't th=
e=20
case here. At least batadv_interface_add_vid should add it at the end. Mayb=
e=20
there was an error before the entry was created? Would be interesting to kn=
ow=20
where exactly.

Kind regards,
	Sven
--nextPart2771404.tAPPvJageb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrwKT0ACgkQXYcKB8Em
e0aIBRAAlVOjMpUqvWUGb2b/gv9P31mn1r8seejb9I1MGOKqnHy5NUo+oxzb8VHI
laPCBiKQoD5fHwHcaUk/0vu+LTVfsZb7dByJM9jiPi9hULTIlPjd17n2TkPZO/ZU
H66WjFmIsMu7nxcSrwExrKUCx2YIIa/QthV35ntOW1MCkU7XGZwg+Sp44inOraxE
EiwloSaN3riG4TXnIhu6nribS1N31NqQ+lGbO3CuNE7XL37qK/wTc9vU473qtYbn
+ZRfGW8iqUp6jN1vuurE9FTCOGLQ0yHSKGr7LFp0c1bI6mIn08OjB7z8Szs/kMnf
4x7MPR7bJ1T4QySO8sAntIbbyGkl/oajuR467izdPqDB/7MsS+/6AilKfoQttanq
KrY6R68cVN9Ev2rdiX14P+AxZE/zjDCExsBT9Us/fls5z7qH2kKcLtrk8zj3S/bp
M26FPPqB13dIaO2V+zFA9H7kZbNL4kEmg+zLIibpgsyxmpjYCTHkjofGVSZKmsmM
jsQlBJ2NZpfCW71wsHh5uwpot/IgtYsDc2nuoGz/nQFiQLM4NIAeHDV6Wx0+pwZi
YAcnvq8o+TLyKPJ90dLXy3EemVp2DY2iUqrpwcC5MaJk+DcrFvatGh50j0hT2o9J
pVwz/WiWsbVPt64iEHq1htYrvXZQYUenuaOu8ztxi/HuSoadM9Q=
=hOcX
-----END PGP SIGNATURE-----

--nextPart2771404.tAPPvJageb--

