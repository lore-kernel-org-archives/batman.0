Return-Path: <a@unstable.cc>
References: <20190214155100.10070-1-linus.luessing@c0d3.blue>
 <2119814.DADNbvlFmJ@rousseau> <20190214174913.GB1602@otheros>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <1b6712e2-92a2-06c1-6545-47dedea57065@unstable.cc>
Date: Fri, 15 Feb 2019 16:36:08 +1000
MIME-Version: 1.0
In-Reply-To: <20190214174913.GB1602@otheros>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GpuiX3gT7jwoPZqHEIdDdk8KfqznX2ZfT"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: allow snooping gratuitous
 ARP Replies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: Daniel Ehlers <sargon@toppoint.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GpuiX3gT7jwoPZqHEIdDdk8KfqznX2ZfT
Content-Type: multipart/mixed; boundary="6YUFxH2jvQ9Rn5Q5VzLUFwkcS0b9w5p3v";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Cc: Daniel Ehlers <sargon@toppoint.de>
Message-ID: <1b6712e2-92a2-06c1-6545-47dedea57065@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: allow snooping gratuitous ARP
 Replies
References: <20190214155100.10070-1-linus.luessing@c0d3.blue>
 <2119814.DADNbvlFmJ@rousseau> <20190214174913.GB1602@otheros>
In-Reply-To: <20190214174913.GB1602@otheros>

--6YUFxH2jvQ9Rn5Q5VzLUFwkcS0b9w5p3v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 15/02/2019 03:49, Linus L=C3=BCssing wrote:
> On Fri, Feb 15, 2019 at 12:16:31AM +0800, Marek Lindner wrote:
>> On Thursday, 14 February 2019 23:51:00 HKT Linus L=C3=BCssing wrote:
>>> So far, gratuitous ARP Replies were ignored for DAT processing as it
>>> contains a broadcast MAC address. This patch changes this and allows
>>> snooping such ARP messages, too.
>>
>>> Gratuitous ARP Replies were ignored since this commit:
>>> ab361a9ccc5 ("batman-adv: filter ARP packets with invalid MAC address=
es in=20
>> DAT")
>>
>> You're kind enough to mention when the filter was introduced but fail =
to=20
>> explain why the filter introduced in the past was has outlived its use=
fulness=20
>> or how the new behavior addresses the  previous concerns.
>=20
> That patch added filtering for both zero and broadcast MAC
> addresses. While the original premise is correct - we do not want
> those addresses in the DAT, the assumption that a broadcast MAC
> address as ARP target MAC address were invalid, is wrong.
> Gratuitous ARP Replies are valid packets.
>=20
> So that patch was a bit too strict in that regard, I think. For
> gratuitous ARP it's enough to ignore the (Target MAC/Target IP)
> pair. Snooping the (Sender MAC/Sender IP) should be fine.
>=20

Is there any situation where an OS would reject a gracious ARP? Or are
they always blindly accepted and processed accordingly?
If they have any protection against any misuse, I guess batman-adv
should try to do the same.

Cheers,


--=20
Antonio Quartulli


--6YUFxH2jvQ9Rn5Q5VzLUFwkcS0b9w5p3v--

--GpuiX3gT7jwoPZqHEIdDdk8KfqznX2ZfT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlxmXdgACgkQ9FVsWUWD
Dm2hTQ/+N5JLh4s6n6fuFtdp1Z6NKAlnGNOC2G8/oeayUngekxXwOAidQ/TcREiJ
DXv2tecNLHYF35WVNFyF+oPPzpa/7sHe1Vz6on/RD/J+9bSv5krBZiP8r6ZN4As+
e1i1p+W7zGwZz6vZbG7XoAR6bSORIFNKWsv4k8kHiVGbVKjUWKN3aj460jBWeFmd
N3AX7Eb9yLaTgVQD8jeRfJJmu7zG7zf75eI6Oe6/npyqjAZmqACFZQ2Xf4VYzfK4
XDR3AEq5un7BHXhtvkJrTDvAIqB6B8CdpbttEJ3/U9+g26aVdEw61mBD8BjPgWMC
yMnNy/PVGY/yjoEaZgYfNW4N8ow/LtYULlVIUMwSUn+5FVHpt4rVbUDNWfUy3Q0q
sNY2QumimWamK9yZe081ss7Op4EE/nkXMgx3VOy1TxTGVWwRsg6PC9ETjHy0paFj
xSjxFg9FLEAxvs+2H5ayN5TzCUEE4BslofoeAxraQhaK/mVH5f/lOvnl79GM5PWI
5ZeEtJ38CCajNnRP9e+Fj+Iu+NOtDuF/qYA8Qz+0fZ+8BCYw+h6J1dNqa1mvXHxF
0aeXnO17bDtzVQqtazZ/EbrbiDY2MOE6SsXvgUmQSI/Zb49oFHmU2co8cpEkPPKe
SyL6Q8twBMcg3u2Gl/QLUXak6xzqIV1GNV5plGBWzNAAXpDEY2s=
=U+wx
-----END PGP SIGNATURE-----

--GpuiX3gT7jwoPZqHEIdDdk8KfqznX2ZfT--
