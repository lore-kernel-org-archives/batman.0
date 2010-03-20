Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Mar 2010 22:48:52 +0800
References: <1269055908-20369-1-git-send-email-linus.luessing@web.de>
	<1269055908-20369-2-git-send-email-linus.luessing@web.de>
	<20100320093615.GA3753@Linus-Debian>
In-Reply-To: <20100320093615.GA3753@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003202248.52191.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix aggregation
	direct-link bug
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


Hi,

thanks for your patch and for testing mine. I applied both of them.

> And there are two more things I'm wondering about:
> - Why should primary interface OGMs from a different originator
>   which already travelled over 49 hops not be aggregated to other
>   primary interface OGMs?
> - Why should secondary interface OGMs from neighbours not be
>   aggregated on our own, neighboring secondary interface OGMs?
> As far as I can tell, those two combinations are not being
> aggregated at the moment. Is there a reason why they shouldn't?

Well, well - we happily apply more of your patches.  ;-)

Cheers,
Marek
