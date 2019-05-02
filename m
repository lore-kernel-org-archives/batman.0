Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood" broadcast
 flood prevention option
Date: Thu, 02 May 2019 08:40:01 +0200
Message-ID: <3454648.6uTQT57BjI@bentobox>
In-Reply-To: <20190426171231.18156-1-linus.luessing@c0d3.blue>
References: <20190426171231.18156-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart111201324.tzmnCbSyTM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart111201324.tzmnCbSyTM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 26 April 2019 19:12:31 CEST Linus L=FCssing wrote:
> With DAT DHCP snooping, the gateway feature and multicast optimizations
> in place in some scenarios broadcast flooding might not be strictly
> necessary anymore to be able to establish IPv4/IPv6 communication.
> Therefore this patch adds an option to disable broadcast flooding.
>=20
> Larger mesh networks typically filter a variety of multicast packets via
> ebtables/netfilter to clamp on overhead. With this option such firewall
> rules can be relaxed so that such multicast packets are only dropped
> if they cannot be handled by multicast-to-unicast, for instance.
>=20
> "noflood" comes in two flavours: If set to 1 then flood prevention is
> enabled for all multicast/broadcast packets except ICMPv6 and IGMP
> (cautious mode). Or, if set to 2 then flood prevention is enabled for
> all multicast/broadcast packets (aggressive mode). If set to 0 then
> flood prevention is disabled.
>=20
> "noflood" is disabled by default as there are still some things to take
> care of to avoid breaking things (especially for the "aggressive mode").
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> ---
> The initial approach was a "noflood"-mark which worked similar to the
> isolation mark. Which allowed more flexibility so that the user could
> mark specific packets to be excluded from broadcast flooding via
> ebtables/netfilter. However, in practice skb-marking is not that easy to
> configure and if misconfigured will break a network horribly. Which was
> also a downside noted and discussed at BattleMesh v11.
>=20
> This version now is a less flexible but therefore also simpler to use
> variant.

It looks like this is an option which can break the mesh rather easily. Her=
e=20
some quotes from 2019-04-30/2019-05-01:

<marec> even the 'cautious' option drops everything except for IGMP and ICM=
Pv6
<marec> nobody has a clear picture what that $everything is
<marec> how does it help you if IGMP and ICMPv6 go through if all other mul=
ticast / broadcast is dropped ?
<marec> (because of too many mesh participants with multicast optimizations=
 disabled)
<T_X> with IGMP/ICMPv6 to always go through I hope we have the most basic t=
hings for IP-IP communication covered and unsucceptible to DoS cases you ha=
ve already outlined
<marec> T_X: how so ?
<marec> T_X: even considering your gluon case - how many nodes would you ne=
ed to update and have to enable mcast optimization to safely turn on nofloo=
d ?
<marec> as I recall, your meshes are all bridged together over vpns
<marec> with only 16 nodes not upgraded or mcast optimization disabled nofl=
ood will be permanently active
<marec> (or whatever your fanout value is)

<T_X> so even if no node were having the multicast optimizations enabled, t=
hen communication both on the intranet and to the internet would still work
<marec> that was not my point
<marec> I want to allow people to experiment with and use multicast in a va=
riety of undefined applications. <<< how do you want to get there ?
<marec> while noflood drops everything
<marec> (except for maybe IGMP and ICMPv6)
<T_X> ah. yes. in that case, such applications would not / would stop worki=
ng. but that's our current default case with basically filtering all/most m=
ulticast traffic except ICMPv6 via ebtables in Gluon

<marec> even standard DAT falls back to flooding, isn't it ?
<T_X> marec: yep
<marec> so, ARP does not work with noflood ?
<T_X> if no ARP response in x milliseconds (250ms I think?) then it will fl=
ood the ARP request
<T_X> marec: right


<marec> sounds to me the noflood will be pretty difficult to understand and=
 debug
<marec> how does a normal user understand when ARP works sometimes .. or ev=
en normal mcast apps work sometimes ?
<marec> how will that seeming randomness be distinguishable from normal pac=
ket loss ?
<T_X> yes. would at least need some thorough wiki page, I guess. *cough* :)
<marec> I am talking about user outside the gluon garden
<marec> sorry for pointing it out again but this noflood feature still feel=
s like a gluon tailored solution - assuming auto-updaters, mcast enabled, n=
o IPv4 or other things other than IPv6 with router advertisements


<ordex> my opinion is that I agree with T_X when he says "just add this pat=
ch to the Gluon repository for now"
<ordex> honestly, skb-marking is much better imho. way less prone to mesh-e=
xplosions and people (that have a thorough understanding of ARP, ICMPv6, IG=
MP, MLD and understand what batman-adv would do or not) can decide how to t=
reat such packets *externally* to batman-adv
<ordex> this is what how we use the client-isolation with skb-marking - the=
 dropping logic is implemented outside
<ordex> with a match on the skb-mark
<T_X> ok. and both the client-isolation and noflood skb->markings would ful=
lfil a kind of similar purpose - that is preventing specific packets from r=
eaching $destination, which could not be fullfilled with netfilter alone, r=
ight?
[...]
<ordex> the reason for the skb-marking is to have something to match packet=
s against. In the client isolation case the knowledge about what to drop wa=
s inside batman-adv, thus we needed a way to "export" this knowledge



I would guess that you can also do something like this using ebtables + tc=
=20
filter. Even with (tc) eBPF... since eBPF seems to be the miracle solution=
=20
for everything these days.

Kind regards,
	Sven
--nextPart111201324.tzmnCbSyTM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzKkMEACgkQXYcKB8Em
e0YGbhAAkIOq6okla+/blZ1pwE76wre7kPItj5nyjVWvj7yv6amxOQwFhOyf0mSo
v2K540n7G5AYdpB5biZJ7WMB+Pg0vLB7GvGbcn7CmnciKpfAi/669GD+lzkLYo+8
YKAFslmSdcNISee5lzDJvj0zxkAG3+yPUcY9yBQkgh68sabNjLC2tOqNrKfYmvRw
x+iUXTuJtJu66LDtsDhMQoiKZ0Wo0+cJopIjuwMdv0CfxgWvwdeVtfoK+W5h8DEH
BeW4IoGfVbF+f26ADjbKdZN09G8ewNnziIbrMN/Vo5G+sUGqwDN4wSAbJTYLfPB5
NvZXsLDvpx8ljJFBEUkqzfc9shQuBmx6G/6an3TbUDMe1LEY6MkOVB4pAof5mIrJ
dLN+VpyedwqjlDftHN1+c1kL9hWtSMKrWdslbwH9xUorR5tiTG8Cs7Pg3n15vmum
4STt1ED0g/et0CMZv4NdrsgfNcloGDss4Rse40PCkYPQ6DcHgImu762hDo39BUwt
o1Wlxr2cMYv9EVGz+Q/ld81oAgZTo7TfxNEgNlsZoqyFrpUIG/iOeExNTbnYJ/z2
E980ju5ysB7jOnayh4qnp+cy8IbLIXBF2kdMhzdwxT38McdOJiPJhv+c0+FwlF0h
FWfQQnmKvSueZsmYbxBTF4fJLtdlFBLcT9PQIcxqaO1LkVMZiKk=
=4yat
-----END PGP SIGNATURE-----

--nextPart111201324.tzmnCbSyTM--



