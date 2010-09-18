Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 18 Sep 2010 13:11:02 +0200
References: <1284584976-22596-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284584976-22596-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009181311.02628.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: wait for call_rcu before
	unloading module
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

On Wednesday 15 September 2010 23:09:36 Sven Eckelmann wrote:
> synchronize_rcu respective synchronize_net only waits for the rcu grace
> period to elapse and we may fail to finish the calls which were made to
> call_rcu in that time. In result the module could be unloaded during the
> execution of the RCU callbacks.
> 
> rcu_barrier[1] will now wait for all outstanding RCU callbacks to finish
> before continuing.
> 
> [1] Documentation/RCU/rcubarrier.txt


Applied in revision 1794.

Thanks,
Marek
