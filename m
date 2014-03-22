Return-Path: <davem@davemloft.net>
Date: Sat, 22 Mar 2014 15:00:54 -0400 (EDT)
Message-Id: <20140322.150054.1510542767128325330.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
References: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 20140322
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
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 22 Mar 2014 09:56:00 +0100

> here you have our patchset for net-next/linux-3.15.
> They are 16 patches but most of them are just small cleanups and kern=
eldoc
> improvements.
> =

> The only big change is the one from patch 8 to 13 by Linus L=FCssing =
that
> introduces a new multicast packets optimisation. This new component a=
ims to
> reduce the air overhead by sending multicast packets as bat-unicast
> when only one destination exists or by dropping them directly at the =
source if
> the multicast group is totally empty.
> =

> In patch 11 Linus introduces an atomic_t variable, that like others t=
hat we
> already have is only object of write and read, thus making the atomic=

> characteristic totally useless.
> Unfortunately this is part of our sysfs framework, that helps the dev=
eloper to
> introduce new knobs by using few macros only. For this reason we deci=
ded to keep
> Linus' new knob for now, but I'd like to let you know that we are in =
the process
> of re-working such framework in order to convert all the current (use=
less)
> atomic_t to boolean in one go.
> =

> Please pull or let me know of any problem!

Pulled, thanks Antonio.
