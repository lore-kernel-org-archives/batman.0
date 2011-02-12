Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Sat, 12 Feb 2011 22:21:37 +0100
Message-Id: <1297545698-15850-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102101525.21265.lindner_marek@yahoo.de>
References: <201102101525.21265.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: Make bat_priv->curr_gw
	an rcu protected pointer
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Marek,

Ok, I now reused the gw_list_lock instead of introducing a new spinlock. I've left the
one issue in the beginning of gw_election() you've been mentioning untouched.
The rest should be fixed.

Cheers, Linus
