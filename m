Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 7 Dec 2015 23:36:58 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151207223658.GS27041@otheros>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <1448305042-5806-2-git-send-email-sw@simonwunderlich.de>
 <56591657.6070401@meshcoding.com> <8889525.bHy7H9IMLu@sven-edge>
 <20151207221242.GR27041@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151207221242.GR27041@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when
 doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>

PS: But granted, even if we came to the conclusion, that a
tt.commit_lock were unnecessary from the multicast code,
that would not be very obvious. Something needs to be done
either way.
