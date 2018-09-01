Return-Path: <a@unstable.cc>
References: <2791173.mX5NbDZpiX@sven-edge>
 <733b64f0.dcd9.1658f661fb2.Coremail.heishuihe2008@163.com>
 <3991773.ZLWj8GO7DM@bentobox> <2087861.tpEfN19RDO@rousseau>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <68a21394-e8ac-2fb1-2132-901ea4c0e610@unstable.cc>
Date: Sat, 1 Sep 2018 17:33:35 +0800
MIME-Version: 1.0
In-Reply-To: <2087861.tpEfN19RDO@rousseau>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gNoBe1zGKGDUQ9vVNoAXw53OVHwJgnIMe"
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ligang LIU <heishuihe2008@163.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gNoBe1zGKGDUQ9vVNoAXw53OVHwJgnIMe
Content-Type: multipart/mixed; boundary="QWgHZWxp3w881JsFg5ENUt6blIVgorAfN";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Ligang LIU <heishuihe2008@163.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <68a21394-e8ac-2fb1-2132-901ea4c0e610@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
References: <2791173.mX5NbDZpiX@sven-edge>
 <733b64f0.dcd9.1658f661fb2.Coremail.heishuihe2008@163.com>
 <3991773.ZLWj8GO7DM@bentobox> <2087861.tpEfN19RDO@rousseau>
In-Reply-To: <2087861.tpEfN19RDO@rousseau>

--QWgHZWxp3w881JsFg5ENUt6blIVgorAfN
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 31/08/18 20:16, Marek Lindner wrote:
> On Friday, 31 August 2018 18:30:00 HKT Sven Eckelmann wrote:
>>> I noticed 2 macro definitons.
>>> #define BATADV_ELP_PROBES_PER_NODE 2
>>> #define BATADV_ELP_MIN_PROBE_SIZE 200 /* bytes */
>>> I wonder why it sends 2 prob ELP packets to each neighbour.
>>> Can I change the value of BATADV_ELP_PROBES_PER_NODE from 2 to 1?
>>> And can I decrease ELP prob packet size from 200 to 100, in order to
>>> decrase the ELP airtime?
>> @Antonio, @Marek: Maybe you can explain it better than me.
>>
>> I would guess that Antonio wanted to make sure that the rate control
>> algorithm of the driver probes enough and thus provides a more realist=
ic
>> expected throughput.
>=20
> Feel free to change these values to test if this has any impact. As far=
 as I=20
> am aware, these number are the result of an educated guess based on how=
=20
> minstrel works. Antonio can shed more light on this.

As Marek stated above, these constants are defined so that Minstrel has
always enough samples to trigger a throughput re-computation for every
ELP interval.

If less data is available, Minstrel won't compute a fresh expected
throughput.
Therefore after every ELP interval batman-adv checks if during the last
100ms (BATADV_ELP_PROBE_MAX_TX_DIFF) the node had sent any payload data
to a given neighbour. If not, then it will send the unicast probes.

This means that if you already have enough data over the link, no
unicast ELP messages should be sent (thus these constants won't be used).=


To conclude: if you have no data over the link, sending 2 probes of
200bytes each every 500ms (default ELP interval) won't really eat much
airtime, unless you have a lot of idling 1-hop neighbours.

I hope this helps.


Cheers,

--=20
Antonio Quartulli


--QWgHZWxp3w881JsFg5ENUt6blIVgorAfN--

--gNoBe1zGKGDUQ9vVNoAXw53OVHwJgnIMe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAluKXPMACgkQB6U8WA7y
zXT5gA/+PvP7Ut4R36X7CZ3zUuMqpTtUKxmqL1sF6E9+ZXPg/jrReeyQlaRZ4o+h
iqcg/OQ8T61j77bEzUPTsrvweE3Dbw23Yw1nnV0pxw9RdBKekCPnUSdCxpRUPIxq
hsjxOoHuDtBclpzI5ko58xX5qeszMfvBKv04gYTCMUsh00dqJ5rqaTjkjjdD8bII
FCxi/IHLz7qH1ytBamsdQ6fKP/7dIMVNkErCP8xgu8aUXCv+POFd8TJ3wpWxLtQN
1KFALcJpoKB2+AQcjekHMEoo6GBHWSwsVE0KD34OSkcpEWDwofpWjJn5dM6gUTqc
hSHypTJ8W8dEi9I/Tp6yuWBVvc9VgPzsL5gIbHRImd7cldCLDExxSmiaWU/06LnA
C0QXe193MBGo4mjG4wgaxiFDwflOXIzn0hGqYmK3f1Q3Skh5WmIn2PkEBdr/NyO+
O7YC9gytXQ3VuXhGb9F3APIbMyU2bgMwJyo07K63t2Dd+oE3GAaEj/QBno6dyIZh
XWL6qnSA3LCI+Hc3PZpuSthp5/vDXpp56WKYVmL17JATPKCnIMjalkQUOwVgvALl
LG+0GlcKc4VxeLaBycn6GOnlzQvhGSJ5LJow/4Xbt1pFJa9O1LHn1w/A/PWdZTaD
HOfrtOHZJFAdyGKLR+dFS2jtXe5xZcAsuiCc8rY4q4IwoxivkCA=
=D5jm
-----END PGP SIGNATURE-----

--gNoBe1zGKGDUQ9vVNoAXw53OVHwJgnIMe--
