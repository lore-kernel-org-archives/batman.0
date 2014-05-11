Return-Path: <antonio@meshcoding.com>
Message-ID: <536F209C.3070507@meshcoding.com>
Date: Sun, 11 May 2014 09:02:52 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1399736110-22333-1-git-send-email-antonio@meshcoding.com>
 <1399736110-22333-5-git-send-email-antonio@meshcoding.com>
 <536E8E96.7090401@cogentembedded.com>
In-Reply-To: <536E8E96.7090401@cogentembedded.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="39Tqf8KQSLWXFvjHR5xaCcd3sUM8whuCw"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix removing neigh_ifinfo
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
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, Simon Wunderlich <simon@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--39Tqf8KQSLWXFvjHR5xaCcd3sUM8whuCw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/05/14 22:39, Sergei Shtylyov wrote:
>>   /**
>> + * batadv_purge_neigh_ifinfo - purge obsolete ifinfo entries from
>> neighbor
>> + * @bat_priv: the bat priv with all the soft interface information
>> + * @neigh_node: orig node which is to be checked
>=20
>    The corresponding parameter is called just 'neigh'.
>=20
>> + */
>> +static void
>> +batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
>> +              struct batadv_neigh_node *neigh)
> [...]
>=20

Good catch! Thanks Sergei

I will fix that and update the tag.


Cheers,

> WBR, Sergei
>=20

--=20
Antonio Quartulli


--39Tqf8KQSLWXFvjHR5xaCcd3sUM8whuCw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTbyChAAoJEEKTMo6mOh1VU9UP/jDJg2AIuA76P9Q0SdSQ0Xoa
jZHe//Y6aYcFjnyEupdrVQXhrC/sUFm6fFOL2l3yqwISMpWpgUO6YGO+56wvOuvj
Isv/l7wQW20hupN/rrBNhh56Ia0mCtzBxeV9mIQU8IONDUDiVNrDN0rMFKun7u/V
Sq7TgXXSsef+6bdZr+R1oZPeLet4oS9HuMQwLk4HREwnnKO9X+pH2SJzr5EDWVLK
nZPtK+cbOxn2P0mJNrT2yY4qPNTMRdzL8GdS6/FOXCodZ70ORMFzF7O08YLaLZIF
Q0UJrVqlAU6EFShngspBeqthtlBLwnXWMMm+MS+OCt3m4nYXJSYPa+e5hQCI5Jn/
7neyKQeehJDF6Rb5siLE8sx/DxOCFYNJUv36DC/mpvzU87v88ubTABM5GghV8gSM
KArYQqsbrSpO8+ENgSA0rx1Ym1n57WkCURTLFP3iHe/3ngCxjEmjdPFeCfsbxexG
usCBQK7uUQAILbR13W4S56t87XHhvezY6c78ygPQwx1tqHP9sPHLzU1yYx/K3veW
N7M8C3h2BpoBKAXJCXbeYXoecSXzoaSNSJzq2Mdk3TMen9iQmre16NilrbkRi4hh
1yD031evvq57tADvgEoi0OTC08U3XNjMIfCuQHulAvBXRprddJAUGFMZzBzc5WBq
nERsl3ek7Mupnev3eBBn
=t+0H
-----END PGP SIGNATURE-----

--39Tqf8KQSLWXFvjHR5xaCcd3sUM8whuCw--
