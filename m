Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 11 Feb 2012 19:14:06 +0800
References: <1328872915-31086-1-git-send-email-sven@narfation.org>
In-Reply-To: <1328872915-31086-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202111914.06906.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix daily check regression
	in blaII
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

On Friday, February 10, 2012 19:21:55 Sven Eckelmann wrote:
> 9fd6b0615b5499b270d39a92b8790e206cf75833 introduced some regressions in the
> daily checks on open-mesh.org. Those were only visible when
> CONFIG_BATMAN_ADV_BLA was disabled. The reason was the usage of defines to
> replace the calls for not available functions. The actual c compiler is not
> able to distinguish between the used and unused variables because it
> doesn't see the function call anymore. The second problem was the use of
> simple subscopes where "do {} while(0)" whould have been necessary.

Applied in revision 2c9280e.

Thanks,
Marek
