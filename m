Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120704140500.GA11212@pandem0nium>
References: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
	<20120704091225.GA10142@pandem0nium>
	<CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
	<CAHD-aqJYXy_Y1vnzHqV6yyrTPAZCHOshGK2HboeYuEzx8i0xNA@mail.gmail.com>
	<20120704140500.GA11212@pandem0nium>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Wed, 4 Jul 2012 15:12:59 -0300
Message-ID: <CAHD-aqJcFYHCEMh66JaR3a_AbkKmNtAkvZ2s6j8Szd=xmvh8jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] BLAII + gw_mode, DHCP sometimes gets dropped
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

On Wed, Jul 4, 2012 at 11:05 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hey Guido,
>
> thanks again for the good debugging, that really helped
> to understand the problem :)
Thanks free software! :D

> I've sent a patch, is it possible for you to apply it
> and retry? it should be enough to update the two
> gateway nodes.
Definitely!
here's the output, tho:

Applying ./patches/9999-batman-adv-check-incoming-packet-type-for-bla.patch
using plaintext:
patching file bridge_loop_avoidance.c
Hunk #1 succeeded at 1351 with fuzz 1 (offset -17 lines).
Hunk #2 FAILED at 1378.
Hunk #3 FAILED at 1423.
2 out of 3 hunks FAILED -- saving rejects to file bridge_loop_avoidance.c.rej
patching file bridge_loop_avoidance.h
Hunk #1 FAILED at 21.
Hunk #2 FAILED at 42.
2 out of 2 hunks FAILED -- saving rejects to file bridge_loop_avoidance.h.rej
patching file soft-interface.c
Hunk #1 FAILED at 274.
Hunk #2 FAILED at 323.
2 out of 2 hunks FAILED -- saving rejects to file soft-interface.c.rej
Patch failed!  Please fix
./patches/9999-batman-adv-check-incoming-packet-type-for-bla.patch!

i'm trying to apply against
openwrt@torvic:~/trunk/feeds/packages/net/batman-adv$ svn info
Path: .
URL: svn://svn.openwrt.org/openwrt/packages/net/batman-adv
Repository Root: svn://svn.openwrt.org/openwrt
Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
Revision: 32587
Node Kind: directory
Schedule: normal
Last Changed Author: marek
Last Changed Rev: 32579
Last Changed Date: 2012-07-02 13:20:20 -0300 (Mon, 02 Jul 2012)


Visually inspecting the rejects, seems my source code still doesn't
have the batadv_ prefix in functions names.
i.e.:

int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)

I've seen many patches flying around dealing with the batadv_ prefix
for dave, but didn't pay much attention to them: which of those should
i grab?

Or, Simon, could you kindly send another patch that i can apply
cleanly to r32587 of
 svn://svn.openwrt.org/openwrt/packages/net/batman-adv

in any case, i see the changes are simple, so i *could* try a manual
apply of the patch....... but last time i tried (with other patch), it
got overwritten by openwrt build system.

Thanks a lot for the support!

Gui



>
> Cheers
>         Simon
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk/0TYwACgkQrzg/fFk7axbznwCg5oyyF4UaWJBV8GXztFSGG8sa
> vnAAoJYcgNuCcdA5fZKrIvaUE888FzSI
> =zd3Q
> -----END PGP SIGNATURE-----
>
