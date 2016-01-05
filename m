Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 5 Jan 2016 06:02:08 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160105050208.GX2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 01/30] batman-adv: Fix list removal of
 batadv_hardif_neigh_node
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

The whole patchset looks pretty good to me.

Checked all patches for bugs but couldn't find any - could only
find minor style issues.

Patches 1 to 9 are definitely a must for maint. Nasty bugs...


Did not check:

* Whether "Fixes:" tags match
* How kref compares to atomic_t under the hood, whether it is
  currently basically the same or whether a switch fixes some bugs

Great patchset! :)

Cheers, Linus


PS: Just to clarify, patch 10 is only a style patch, right?
