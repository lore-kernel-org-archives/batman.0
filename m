Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 5 Jan 2016 05:43:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160105044313.GV2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
 <1450617490-3544-16-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450617490-3544-16-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 16/30] batman-adv: Convert
 batadv_bla_claim to kref
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

On Sun, Dec 20, 2015 at 02:17:56PM +0100, Sven Eckelmann wrote:
>  /**
> - * batadv_claim_free_rcu - free a claim
> + * batadv_claim_free_ref - decrement the claim refcounter and possibly
> + *  release it
>   * @claim: claim to be free'd
>   */
>  static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
>  {

Wrong patch for that function name change
