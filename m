Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F77B50B.6030402@codigosur.org>
Date: Sat, 31 Mar 2012 22:53:15 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
	<BBFA727B-FECF-4C04-BCD1-3C76CBD010DE@gmail.com>
	<CAHD-aqLOLFq5LOYa94BffAzzD2uMSeKOtwaa_PG1+d8E2vrriw@mail.gmail.com>
	<CAA_JP8XtADXO=J6rKdQNTz3vGeLr0+a1fJSsyS9Lb=-zttWgug@mail.gmail.com>
	<4F77AFDD.7050909@codigosur.org>
In-Reply-To: <4F77AFDD.7050909@codigosur.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [OT] ruci / Was: link alternation when radios
 are not on batman-adv router?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 03/31/2012 10:31 PM, Nicol=E1s Ech=E1niz wrote:

> This effectively "invisibilizes" some links for batman.
>=20
> You should use this with care, mainly if you are playing with it
> remotely because you may be left out of a portion of your network.

One more thing, not specific to batman, but useful for the kind of
experimentation you might be doing in the near future.

We (QuintanaLibre and DeltaLibre) have designed a tool for "fail-proof"
remote administration of OpenWRT nodes, which Guido (also participating
in this thread) has developed and maintains.

It's called ruci (for remote uci) and it has many useful features:

1) uses a centralized mercurial repository to store all your nodes
configuration.
2) can "pull" configurations from nodes at any time into the repo.
3) can push configuration changes to a node or set of nodes.
4) can compare configuration status between repo and nodes.
5) can always revert nodes or the whole network to any previous state
(provided by mercurial), as long as you keep a useful commit policy.


When new configuration is pushed, the remote router updates and reboots
(we found this to be safer than just restarting services). It then boots
with the new configuration and a 10min. revert timer, which triggers
unless you confirm the changes.

This simple method provides enormous experimentation possibilities. You
can, for example modify your entire network's IP addressing policy in
your local configs repo and then push the change simultaneously. If
something goes wrong, the routers will revert configuration and reboot
in 10 min.; if everythig went well, you can just confirm your changes
during the "revert window" to make them permanent.


You don't need to use uci locally, you may just edit config files by
hand and push them, but uci really comes in handy to avoid human error
when making changes or to implement some modifications programatically.


Guido might like to add some more detail, but that's a short description
of ruci[0].


Anyone who would like to test it, and might need some initial guidance
(mainly to set up things, the rest is self-explanatory), just drop guido
or me an e-mail and we will gladly help you out. There's no list or
forum yet...


Cheers,
NicoEch=E1niz



[0] http://bitbucket.org/guidoi/ruci


