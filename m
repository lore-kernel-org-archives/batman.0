Return-Path: <linus.luessing@web.de>
Date: Wed, 9 Jul 2014 03:17:55 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140709011755.GT2675@Linus-Debian>
References: <1404708673-20135-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1404708673-20135-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH RFC v2] batman-adv: Add multicast
 optimization support for bridged setups
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Jul 07, 2014 at 06:51:13AM +0200, Linus Lüssing wrote:
> * using new, third bridge multicast export (because this export is
>   not upstream yet, I've added the "RFC" in the title):
>   br_multicast_has_querier_anywhere()

Ok, third export is upstream in net-next, so will be in 3.17. I'm
therefore lifting the RFC, from my side could be added to
batman-adv master. Let me know if you'd like a resend without the
"RFC" tag in the title.

Cheers, Linus
