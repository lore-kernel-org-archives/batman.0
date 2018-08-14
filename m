Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 14 Aug 2018 08:54:40 +0200
Message-ID: <6851354.H9m7TIEccf@sven-edge>
In-Reply-To: <2018081411324765819119@163.com>
References: <2018081411324765819119@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7790082.9CvXBLSOjj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fw: What's the exact definition of
 expected_throughput in BATMAN-ADV V?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "heishuihe2008@163.com" <heishuihe2008@163.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Felix Fietkau <nbd@nbd.name>, a@unstable.cc

--nextPart7790082.9CvXBLSOjj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi,

please don't contact me privately about batman-adv (unless you have a reall=
y,=20
really, really, really good reason for that and explain the reason for that=
 in=20
the mail). At least Cc the official mailing list=20
b.a.t.m.a.n@lists.open-mesh.org

On Dienstag, 14. August 2018 05:32:48 CEST heishuihe2008@163.com wrote:
[...]
> I'm the author of paper "Performance Evaluation of BATMAN-adv Wireless Me=
sh Network Routing Algorithms". Thank you very much for your comments on ou=
r work.
>=20
> I am sorry for some wrong statements in the discussed paper. Actually I'm=
 new in OpenWRT/LEDE development and have much misunderstanding on it.

The problem is now that the paper with the wrong statements, graphs and=20
conclusions is now published by IEEE. Thus my proposal to retract it and=20
prepare a new paper which doesn't contain the flaws.

[...]
> The following is the email I tried to send before. Just for reference.
>=20
> I'll continue to work on the batman-adv algorithms and report our result =
to the community.
[...]
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A heishuihe2008@163.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A 2018-03-22 16:29
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A b.a.t.m.a.n
> =E4=B8=BB=E9=A2=98=EF=BC=9A What's the exact definition of expected_throu=
ghput in BATMAN-ADV V?
> Dear all,
>=20
> I'm working on a wireless mesh network based on 802.11.
>=20
> When I tried to test the BATMAN-ADV V, I got very poor performance compar=
ed to version IV.
>=20
> I guessed the reason was V had much more management costs than IV.

As we now know - most likely not the main contributor. But we will only kno=
w=20
it when proper tests have been done.

> Recently I found that the throughput metric was not reliable, probably.
> The expected_throughput value from cfg80211_get_station is different from=
 the one with batctl tp.
> Which one is the correct?

Depends on what you actually consider correct. cfg80211_get_station should=
=20
provide a similar value as `batctl tp` for single hop tests with only a
single possible link. The first one is done by the driver (actually the=20
rate control minstrel in many cases) and is hopefully correctly=20
implemented. Unfortunately, some driver do it completely wrong and=20
return the PHY rate and some don't implement it at all.

batctl tp on the other hand is currently not used for the metric. It uses a=
=20
minimal stream protocol to transfer data from the current host to the=20
specified host. It doesn't have to be a neighbor and you cannot specify whi=
ch=20
path it takes. The specified host will acknowledge the received data and th=
e=20
sender can calculate the successfully transmitted bytes using that. In its=
=20
current form, it is not useful for B.A.T.M.A.N. V and can only be used for=
=20
minimal performance tests in the mesh.

> Does it mean the wireless driver does't support expected_throughput?

Cannot say this for sure. The driver has to be checked. But your output=20
suggest that you are using minstrel_ht - which provides an implementation f=
or=20
expected_throughput. But many kernel versions contain a cfg80211_get_statio=
n=20
which isn't correctly initializing the sinfo structure - thus returning
uninitialized expected_throughput values in some situations.

> How to get the correct expected_throughput from wireless driver=EF=BC=9F

In which context? From userspace from a shell maybe?

Check the output of `iw dev wlan0 station dump` and search for
"expected throughput". If it isn't there than either your driver doesn't=20
support it, your 'iw' doesn't support it or it didn't return a valid value
(for unknown reasons).

If you want to get it it via `iw` but instead via nl80211, then please use =
the=20
NL80211_STA_INFO_EXPECTED_THROUGHPUT attribute which is sometimes returned =
for=20
a NL80211_CMD_GET_STATION request [1].

> So I'm wondering that what's the exact definition of expected_throughput?

I hope Antonio or Felix can provide a better definition. But I would say it=
=20
is:

  The expected throughput is the number of kilobits per second a user will=
=20
  probably transfer (measured on the layers above wifi) when sending data=20
  directly to this host. This information is calculated based on the past=20
  experience of the driver (actually the rate control algorithm).

> And what's the difference from tx/rx bitrate?

TX/RX bitrate is the raw wifi bitrate. It is much higher than the expected=
=20
throughput in most cases because it doesn't contains correction factors for=
=20
packet loss, IFS/aggregation and so on. And it is just the info about a=20
single frame which was received/transmitted - not a more complex value=20
calculated based on the statistics gathered from the past transfers.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/tree/stati=
on.c?id=3D6ab936f0458c62b1de3a5af8af8d9a3b092cbfac#n412
[2] https://patchwork.kernel.org/patch/10449857/
--nextPart7790082.9CvXBLSOjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAltyfLAACgkQXYcKB8Em
e0YdIQ//WpPbiBZRgMLButwOmyNkE42WTlAuDzqnN1xDuQgmssGeWP9XHaYmHXn/
lOQmey/WGuUdofOsYhH8eCPnyfrPr65woWXSqTV450eN+Ked95sonRMaePeM/+1u
zYtbWaFDhS0EJu7D7zrrQyjeovx8H1xhzl7rAejlBKwFYwy33iWs7hQNbyZQ/gri
ww0Ex0W6eBrVScJa6PUACpn/RJoej6DZXtLgQCf5j/ly8PxSfegmQixjbrgFhkjW
UmhKLBdXdCt+YZ21495srJ+TRiKFNCi+l76fmrXyGjAbo625Za/1/3ap9qJUV+dg
xvDz7I6Tw4ZQ93IWoje7AwOWbzyiXno9Hy6/5q/mELN1SnbhJPXJYx8yLgVw3knE
f0gcRQcXyBtsvH9k7/2LbVq7ps7Wuibg8J26EflGh0p41VJkJKYFw7ybcLZA6pxc
iFBP9AIiNSYGKXux9wRlJ7HlOoUHfCrm6w9JecRpltAFkNEBpxhpMKZj5mLAsQxG
OIY15F4v2yK1Q6ue6plbljFQF8edGH9Lmdchk6S3R6291N6uhKtJvFTT22T8Puk9
2w038QOaYZVXSwzKgiS969B/1jbbr/F3HKkI8Yz7CPuI7NZenVI2DcU1pg6U4a9P
tsd3IIFWUKv6p9WHkkm1tfKi8qflwWdcoO7/zH2AUeknWiC4Sy8=
=q3vZ
-----END PGP SIGNATURE-----

--nextPart7790082.9CvXBLSOjj--



