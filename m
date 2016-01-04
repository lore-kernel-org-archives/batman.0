Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 4 Jan 2016 17:32:15 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160104163215.GN2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
 <1450617490-3544-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450617490-3544-4-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 04/30] batman-adv: Drop immediate
 orig_node free function
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

On Sun, Dec 20, 2015 at 02:17:44PM +0100, Sven Eckelmann wrote:
> But the _now functions ignore this completely. They free the object
> directly even when a different context still tries to access it. This has
> to be avoided and thus these functions must be removed and all functions
> have to use batadv_orig_node_free_ref.

Hrmpf, right, the rcu callback scheduler does not ensure that
everything else is outside of an rcu-read-critical section... My
bad. Your solution looks better :).
