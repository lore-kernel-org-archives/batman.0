Return-Path: <martin@darmstadt.freifunk.net>
References: <20190426171231.18156-1-linus.luessing@c0d3.blue>
 <2852684.HY4pDEyiBM@sven-edge>
From: Martin Weinelt <martin@darmstadt.freifunk.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood" broadcast
 flood prevention option
Message-ID: <cb27fa9e-c7d2-db51-6f47-c717612b82af@darmstadt.freifunk.net>
Date: Sun, 28 Apr 2019 21:04:19 +0200
In-Reply-To: <2852684.HY4pDEyiBM@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qOf7ldBdW7G0UReenGKA8T1xarIfDKm0K"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qOf7ldBdW7G0UReenGKA8T1xarIfDKm0K
Content-Type: multipart/mixed; boundary="LThiVLcTzabBBQMf3XMbwExyx6Q9ODbrB";
 protected-headers="v1"
From: Martin Weinelt <martin@darmstadt.freifunk.net>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <cb27fa9e-c7d2-db51-6f47-c717612b82af@darmstadt.freifunk.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood" broadcast
 flood prevention option
References: <20190426171231.18156-1-linus.luessing@c0d3.blue>
 <2852684.HY4pDEyiBM@sven-edge>
In-Reply-To: <2852684.HY4pDEyiBM@sven-edge>

--LThiVLcTzabBBQMf3XMbwExyx6Q9ODbrB
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Please see my reply below.

On 4/28/19 7:04 PM, Sven Eckelmann wrote:
> On Friday, 26 April 2019 19:12:31 CEST Linus L=FCssing wrote:
>> With DAT DHCP snooping, the gateway feature and multicast optimization=
s
>> in place in some scenarios broadcast flooding might not be strictly
>> necessary anymore to be able to establish IPv4/IPv6 communication.
>> Therefore this patch adds an option to disable broadcast flooding.
>>
>> Larger mesh networks typically filter a variety of multicast packets v=
ia
>> ebtables/netfilter to clamp on overhead. With this option such firewal=
l
>> rules can be relaxed so that such multicast packets are only dropped
>> if they cannot be handled by multicast-to-unicast, for instance.
>>
>> "noflood" comes in two flavours: If set to 1 then flood prevention is
>> enabled for all multicast/broadcast packets except ICMPv6 and IGMP
>> (cautious mode). Or, if set to 2 then flood prevention is enabled for
>> all multicast/broadcast packets (aggressive mode). If set to 0 then
>> flood prevention is disabled.
>>
>> "noflood" is disabled by default as there are still some things to tak=
e
>> care of to avoid breaking things (especially for the "aggressive mode"=
).
>>
>> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> @Martin, I think you've started to experiment with this noflood feature=
=2E Any=20
> experiences which you can share with us?
>=20
> Kind regards,
> 	Sven
>=20

We have been using the early noflood and DHCP snooping patches from
Linus since roughly 2018/04. They were based on sockmarking packets that
should be handled by noflood. This resulted in quite some amount of
ebtables rules on our gateways, that marked addresses within DHCP ranges
for noflood, since they were very likely already snooped. The result can
be seen in graphs I provided to Linus back then, that are now visible at
https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping#Resu=
lt.

We did not experience any usability issues that could be traced back to
these patches. I've dropped the patches when the DHCP snooping landed
upstream, so we're currently (since 2019/04) running
v2019.1-14-g28573050 without without noflood.

I have no knowledge of this versions two new "flavours", I was pretty
happy with the aggressiveness of the earlier patches even though it's
manual setup, where we created those ebtables rules from scratch. I
would be happy to also test these new changes, but I'm currently lacking
the wirerrd (https://github.com/T-X/wirerrd) setup that created those
fancy graphs.


Best regards,
Martin


--LThiVLcTzabBBQMf3XMbwExyx6Q9ODbrB--

--qOf7ldBdW7G0UReenGKA8T1xarIfDKm0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE7tAWAry9GWw4vJofvUqgUo9j8X4FAlzF+TYACgkQvUqgUo9j
8X5icwgAm+jr56XGyD90+2wh6b0/M0OdFSxmeErsPCxwwQXzXR3Qwhl03kbtTzqV
mM0vyceMLu3y+Cjd6gF5bbseOUdhzZEc9tkvmJnO1uuTfS++OIs6hNQKYPZ9dfBA
wAWHXM13+N3uTtrEmUQnx2Y6glZ9afYldBAUTZxeiLDeu7MhQOXIEbhEycwhCTPD
d1vd7GC3kRsKlnYNfTj/wDWO0CZ5Fh1UYtcDxy1Vn3ImPFMUY3jRmWXd+Mz3TnBC
bTAlbLpiAqDUJNVw0yRdsQmn1ts/w+NlxDlgi5raa1Xbk2afYeV+w/Yf9NjNpgdO
kdREm672eQx+Vge9PAMrpvU4+5qoag==
=saG+
-----END PGP SIGNATURE-----

--qOf7ldBdW7G0UReenGKA8T1xarIfDKm0K--
