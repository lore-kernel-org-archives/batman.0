Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 4 Jan 2016 19:59:32 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160104185932.GP2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
 <1450617490-3544-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450617490-3544-5-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 05/30] batman-adv: Drop immediate
 batadv_orig_ifinfo free function
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

Generally looks good to me. But seems to do more than the title
says?

It also fixes a nested call_rcu via batadv_nc_purge_orig and a
bogus batadv_neigh_node_free_ref_now call?
