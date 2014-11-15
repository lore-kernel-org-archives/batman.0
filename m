Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 15 Nov 2014 19:58:23 +0100
Message-ID: <21787558.pbjUVs1b2F@sven-edge>
In-Reply-To: <019301cfff56$b8cb3830$2a61a890$@dslx.net>
References: <069201cffe76$c6b720c0$54256240$@dslx.net>
 <20141112135424.GV9205@medion.lan> <019301cfff56$b8cb3830$2a61a890$@dslx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4372355.oVSyix5AT5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Current OpenWrt build
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
To: b.a.t.m.a.n@lists.open-mesh.org, jay@dslx.net


--nextPart4372355.oVSyix5AT5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 13 November 2014 10:30:14 Jay Brussels wrote:
> I have seen some patches on the listserver  that states certain mesh traffic
> can cause a crash.  This is my primary concern.

Which patches are you referring to? For example my patches for batctl [1] are
related to a recent patch for batctl tcpdump [2]. So it is neither strictly
batman-adv nor for anything in OpenWrt (the affected patch was not yet part of
any batctl release).

But there are things which might affect you depending on what you are doing.
For example, there is an RCU related fix [3] which is quite important when you
are using a Linux kernel < 3.9. But OpenWrt should not use such an old kernel
when compiling a recent OpenWrt version. But maybe you still do and we don't
know about it. So it is hard to guess what to say to your question.

It is also hard to guess whats your batman-adv configuration. For example I would
try to disable network-coding+dat and enable bridge loop avoidance - unless my
specific setup requires something else. I know that this is not the default
behavior but in my subjective experience the default causes more trouble. Just
for reference, this is the default when batman-adv was compiled with all
features:

 * bridge_loop_avoidance: disabled (I prefer "enabled" because it is better to
   be save than sorry after you've killed the network with an broadcast packet
   storm. But don't expect it to be a magical cure for every insane network
   setup you could imagine)
 * network_coding: enabled (I prefer disabled unless proven to be helpful in
   your specific network setup)
 * distributed_arp_table: enabled (I prefer disabled due to some problems I
   had with it)

This might be something which could be seen by some people as "not stable" and
others might disagree. Or they might completely disagree with my (not
science-based) opinion about the better default settings.

Also there is the problem that we don't know which feed you are using. For
example there is a patch [4] in the openwrt-routing feed which fixes the
problem that the batman-adv config file is cleared after and upgrade. This
commit (Hint!!!!) was never merged into the openwrt-feed-batman-adv.git. And
this feed also seems to point to an quite old batman-adv/batctl version by
default. This can be seen as "instability" depending on your personal view
and what you are using to get batman-adv in your firmware. It can affect you
but most likely doesn't affect you at all.

And to your question "Is the current OpenWrt release stable enough for
deployment". Lets first make it clear that I will now talk about software in
general and not batman-adv. Every software has some kind of problems. Many of
them are unknown and will hit you from behind when you expect it the least.
Therefore, making a general statement without knowing anything about your
"deployment" cannot be accurate nor valid. The buggiest software may run fine
in a specific environment and the most polished software may cause problems
when somebody just (accidentally) finds its Achilles heel. And this can even
happen when knowing your "deployment".

But lets just summarize:

 * can it be deployed?: yes, people already do it
 * is it stable enough for deployment?: cannot be answered (see below)
 * was it deployed and then worked stable?: yes
 * are there known problems not fixed in openwrt?: yes
 * are there known problems that affect you?: unknown
 * is it very likely that these known and fixed problems affect you when
   assuming everything done "the right way"?: not really
   (please correct me if there was some change which I missed in maint or ml)
 * is it possible that there are known and fixed problems which affect you
   assuming not everything is done "the right way"?: yes
 * will it work out of the box in every possible environment?: no
 * will it work in many setups?: yes
 * will it work in some other setups after changing the config?: yes
 * would these questions answered the same for many other sw projects?: YES

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-November/012534.html
[2] http://git.open-mesh.org/batctl.git/commit/4c39fb823b86036df40187f8bd342fe5398c28ef
[3] http://git.open-mesh.org/batman-adv.git/commit/1e4a96a4cfdfdf57fecacf1c8fa493345a9fcc03
[4] https://github.com/openwrt-routing/packages/commit/bbcc138fc0bbef5094c3928d892076ae9a56a213

--nextPart4372355.oVSyix5AT5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUZ6JVAAoJEF2HCgfBJntGQtoQANmEQyoasBzYvf5to29XW5Sf
tPyPV615xj6gUCAQrm9Vr8rHgzPuO8uFkzgZi9eUv7pJbbwE3CJT2JCOnFFS+cTr
Yo5x9bBDd+uLNjjIDsbvC29OfGW3pzd415/f4ivmiktBppriZqqdzsa6lbpctrsY
f3tQ+sa5rVrizIRrQOi8rmtjjQ57b8CbEsF+3IeqrW+5i2MuUAb2oUJsm9q57H7Y
fla0B/ao9fvx20K25pULT8bI/U14TRYwDDv+iHGB6Z15lv3/0tOGWKIiH9hwL5OK
j6OzO2safcphZhYhYRPJC9mw9wSkfsbYT5iIRmvzrGXDu6I56fxQLtgkDYSQpGgO
iW77Q58CUNZISYyd67eZySB/UyLQp0OeB04Rq6b7542aWxKton5RxXmRTF15//e+
EvLP+wo5cIp3L9nC5SzdxD29t4dB/u+nSmPofK5XRMCzHbZeyKdPy89DUtDLYNCw
ixAM2730FCbIeGTxjdZLhavgvWF5xZa+Fw8siEat029P/x1KGU4LZz4GS7q9pwGr
ddN+zGQl5CVcxbeUrV1bw9nNp1PR6tSFuoriN85FcJtGG+tkXGvBETzuRVHfy8+b
/a0cjLbekW00AyTkhGIwwCA/mIrbBp04dQamx+jhOwcanuaCt+WBWcYvzeW5OaUR
47ObDLTmxDKnARW7RMMe
=IeHe
-----END PGP SIGNATURE-----

--nextPart4372355.oVSyix5AT5--

