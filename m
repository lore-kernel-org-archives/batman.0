Return-Path: <joe@perches.com>
Message-ID: <1477689186.23018.1.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Fri, 28 Oct 2016 14:13:06 -0700
In-Reply-To: <20161027190150.7880-18-sw@simonwunderlich.de>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-18-sw@simonwunderlich.de>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 17/17] batman-adv: Avoid precedence
	issues in macros
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Thu, 2016-10-27 at 21:01 +0200, Simon Wunderlich wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> It must be avoided that arguments to a macro are evaluated ungrouped (which
> enforces normal operator precendence). Otherwise the result of the macro
> is not well defined.

Curiosity:

in net/batman-adv/tp_meter.c

static int batadv_tp_send(void *arg)
{
	struct batadv_tp_vars *tp_vars = arg;
	struct batadv_priv *bat_priv = tp_vars->bat_priv;
	struct batadv_hard_iface *primary_if = NULL;
	struct batadv_orig_node *orig_node = NULL;
	size_t payload_len, packet_len;
	int err = 0;

	if (unlikely(tp_vars->role != BATADV_TP_SENDER)) {
		err = BATADV_TP_REASON_DST_UNREACHABLE;
		tp_vars->reason = err;
		goto out;
	}

	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
	if (unlikely(!orig_node)) {
		err = BATADV_TP_REASON_DST_UNREACHABLE;
		tp_vars->reason = err;
		goto out;
	}

	primary_if = batadv_primary_if_get_selected(bat_priv);
	if (unlikely(!primary_if)) {
		err = BATADV_TP_REASON_DST_UNREACHABLE;
		goto out;
	}

err is not used in the out block

Is the last if block supposed to set tp_vars->reason to err?


