Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 19 May 2011 10:12:13 +0200
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
	<1305413421-8416-1-git-send-email-sven@narfation.org>
In-Reply-To: <1305413421-8416-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105191012.13744.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/09] batman-adv: Use
	rcu_dereference_protected by update-side
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

On Sunday 15 May 2011 00:50:21 Sven Eckelmann wrote:
> Usually rcu_dereference isn't necessary in situations were the
> RCU-protected data structure cannot change, but sparse and lockdep still
> need a similar functionality for analysis. rcu_dereference_protected
> implements the reduced version which should be used to support the
> dynamic and static analysis.

Applied in revision 26c6ecc.

Thanks,
Marek
