Return-Path: <andrew@lunn.ch>
Date: Wed, 1 Jun 2011 07:41:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110601054111.GB27695@lunn.ch>
References: <1306791458-7891-1-git-send-email-ordex@autistici.org>
	<1306797945-22502-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1306797945-22502-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 2/2] batman-adv: rename and move TT_*
 flags/structs to the proper locations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> -	tt_local_event(bat_priv, TT_CHANGE_ADD, addr, false);
> +	tt_local_event(bat_priv, 0, addr, false);

Hi Antonio

i find TT_CHANGE_ADD much more descriptive than 0. Could you add back
a macro here rather than a hard coded value? TT_NO_FLAGS?

  Andrew
