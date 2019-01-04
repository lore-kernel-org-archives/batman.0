Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 4 Jan 2019 02:40:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190104014005.GE21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-6-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207135846.6152-6-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 05/19] batman-adv: Add aggregated_ogms
 mesh genl configuration
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

On Fri, Dec 07, 2018 at 02:58:32PM +0100, Sven Eckelmann wrote:
> +	/**
> +	 * @BATADV_ATTR_AGGREGATED_OGMS: whether the batman protocol messages
> +	 *  of the mesh mesh interface shall be aggregated or not.
> +	 */
> +	BATADV_ATTR_AGGREGATED_OGMS,
> +

I'm wondering, would it make sense to take this opportunity to
rename this to BATADV_ATTR_AGGREGATION? In case we were adding
aggregation support to something other than OGMs in the future.

(and maybe even make it a u32 to be able to potentially use it as
a bitfield with a useable length?)

And I know, the generic aggregation patchset was rejected. But on
the other hand I don't think that OGMs are that special that they
will always be the only packet type worth aggregating.
