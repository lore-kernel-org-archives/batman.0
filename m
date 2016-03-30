Return-Path: <are@lihas.de>
Date: Wed, 30 Mar 2016 15:58:42 +0200
From: Adrian Reyer <are@lihas.de>
Message-ID: <20160330135842.GA19985@r2d2.s.lihas.de>
Reply-To: b.a.t.m.a.n@lists.open-mesh.org
References: <56F5AF2F.6060904@t-online.de> <20160328235247.GA4528@otheros>
 <20160329083717.GA32035@r2d2.s.lihas.de>
 <34764958.y3lWsCmXTL@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <34764958.y3lWsCmXTL@prime>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Wed, Mar 30, 2016 at 01:58:31PM +0200, Simon Wunderlich wrote:
> I don't think we have to pull out every possible case here. People will a=
lways=20
> be creative in designing their networks, even if their would be some easi=
er or=20
> better approaches[tm]. Not supporting everything is not a flaw in my opin=
ion,=20
> at least as long as we support sound alternatives.

Sure.

> For example, I don't see why we would need to support not-forwarding/not-=
full=20
> mesh VPNs. We could just require every mesh participant to run batman-adv=
, and=20
> not supporting setups where, for example, the "master" node doesn't speak=
=20
> batman-adv, since that could be easily enabled. If there are multiple=20
> independent VPN links, those could be done in seperate interfaces. Is tha=
t=20
> assumption correct? (Maybe Freifunk people could tell a little bit more).

While I don't expect anyone to support anyone elses strange setups, I
see no reason to explicitly destroy other setups.
batman-adv has an interface, by default bat0, this is similar to a
bridge. Attached to that are the various real interfaces, wlan0, eth0,
tap0, whatever. And we talk about the broadcasts on those
sub-interfaces, not about bat0.
We run batman-adv on every node and requiring batman developers to
support setups that refuse to use their code would seem very strange to
me.
A current setup of a freifunk gateway in my freifunk-community hast 2
interfaces attached to a batman instance, 1 fastd reaching all the
nodes, here we absolutely need rebroadcasts and 1 tinc interface
connecting alle the gateways, there we have full mesh due to tinc
already and don't need rebroadcasts. Both interfaces are just
tap-Devices, e.g. tap0 and tap1.

> So far, I see the following scenarios:
> Broadcast needed:
>  * WiFi Ad-Hoc
>  * WiFi AP
>  * Ethernet to WiFi Ad-Hoc bridges (is that even used?)
> Broadcast not needed
>  * WiFi Point to Point links
>  * Ethernet
>  * VPNs (at least common setups)
> As a very easy rule of thumb, we could say that rebroadcasts on the same=
=20
> interface should always be enabled on WiFi and disabled on everything els=
e.=20
> Even if we still agree to introduce a flag to change that, that could sti=
ll be=20
> a sound default. Would you agree?

No, a sound default is the behaviour we have now. In worst case it
wastes bandwidth, but works. No matter what exact capabilities an
interface has. A changed default would instantly break every
freifunk-community using batman as to my knowledge they all use a vpn to
connect to GWs that *needs* rebroadcasts

> We try to minimize flags and settings in general as a design goal. Other=
=20
> implementations we looked at have too many "tunable" parameters, people=
=20
> writing in forums/mailing lists how and why these settings should be set=
=20
> without really understanding it ... This is why we try to not expose=20
> everything, even if we would leave a little bit of room for improvement.

I understand this concern very much and I am aware of many, many samples
on where things fail due to people just copy&pasting stuff someone else
said in some completly different context.
I appreciate the idea of the developers to do as few tunables as
possible and while I don't regard myself as single-minded, I can't think
of a decent, fail-save method of doing an automated detection of the
thing I expect from this flag.
Be aware, I talk about a single flag only, I want to get rid of the
re-broadcasts on interfaces that don't need it. I don't care if there
are 1 or 100 rebroadcasts on interfaces that need it and a performance
flaw with the latter as batman handles it has not come to my attention
as of now. For the first in contrary, I see the impact all the time.

> I'm not against the flags, but its good to have a discussion to find out =
what=20
> is really needed ...

I appreciate this discussion as it shows the various pros and cons and
enables me to understand how other peoples setups look like, what they
focus on and, no matter what the result is, enables me to improove my
setups.

Regards,
	Adrian
--=20
LiHAS - Adrian Reyer - Hessenwiesenstra=C3=9Fe 10 - D-70565 Stuttgart
Fon: +49 (7 11) 78 28 50 90 - Fax:  +49 (7 11) 78 28 50 91
Mail: lihas@lihas.de - Web: http://lihas.de
Linux, Netzwerke, Consulting & Support - USt-ID: DE 227 816 626 Stuttgart

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVvvbknn8862ZCBs9AQKPMAf9E/ltbgXV6N0pQHhdWeWOcV9FnAjBAE30
Go5uh0zbf/gySTshtw+XuB2nCvjIwD/vDWANzi8aQOW2Q3eNgPdYvo5AjdVjd6WS
WSyXq+7V+iwG3WlKAXJFdEMUR6baBFRaovvDX4foCRHhlUF/UDV2OSaNrDYA2tMR
bc75TcavJjpzmF6jKO8xmPTZubnvflZg4Rc2MuKNtaagzUxeg5fcKeh0L6muXZr9
S7JjOsW2DExDpZQF0iwO0qtiQcnhxI62kqfGVSyrqTnY7jT3pDNy0CQiWUozBLt3
RgSh/NaKoZWVz+2/2QXIrI02+RYDaP618pOsI0ZeHqACzn1H+lNf5Q==
=2WlB
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
