Return-Path: <linus.luessing@web.de>
Date: Wed, 18 Jun 2014 00:44:49 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140617224449.GH29033@Linus-Debian>
References: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: increase default hop penalty
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Simon Wunderlich <simon@open-mesh.com>

On Tue, Jun 17, 2014 at 12:16:03PM +0200, Simon Wunderlich wrote:
> This patch changes the hop penalty to 30, which will give an effective
> penalty of 60 on single band devices (hop penalty + wifi penalty).

"batman-adv: encourage batman to take shorter routes by changing the default hop penalty"
(6a12de1939281dd7fa62a6e22dc2d2c38f82734f)

This patch changed the hop penalty for single (and back then
also dual) band devices from 10 to 30.


If 60 were always the correct value, why wasn't it changed from
10 to 60 back then?

If the reason was not having it measured thoroughly enough
back then, why would your latest measurements be? (For instance
what will prevent the hop penalty being changed again next year?)

Any data for others to check?

Cheers, Linus
