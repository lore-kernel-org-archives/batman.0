Return-Path: <davem@davemloft.net>
Date: Tue, 06 Jan 2015 14:25:14 -0500 (EST)
Message-Id: <20150106.142514.108109720918651317.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
References: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 20150106
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
Date: Tue,  6 Jan 2015 12:09:59 +0100

> here you have some small fixes for your 'net' tree.
> =

> Patch 1 fixes a regression in the "bonding" code introduced while
> implementing the multi-interface optimization feature, by Simon
> Wunderlich.
> =

> Patch 2 ensures that the "last-seen" timestamp for a newly created
> originator object is properly initialised in order to avoid a non-cri=
tical
> race condition, by Linus L=FCssing.
> =

> Patch 3 avoids false positive splats when lockdep is enabled by assig=
ning
> the proper lock class to locks used by the network coding feature, by=

> Martin Hundeb=F8ll.
> =

> Patches 4 and 5 fix the code counting the amount of multicast-disable=
d
> nodes in the network (used to avoid to enable the multicast optimisat=
ion
> when not possible), by Linus L=FCssing.
> =

> Patch 6 fixes a memory leak in the Translation Table code that can be=

> triggered by doubling the current originator interval, by Linus L=FCs=
sing.

Pulled, thanks Antonio.
