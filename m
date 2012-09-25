Return-Path: <ordex@autistici.org>
Date: Tue, 25 Sep 2012 18:01:19 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120925160119.GA31069@ritirata.org>
References: <1348588637-18441-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1348588637-18441-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-09-25
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

here are some instructions to solve the conflict you will hit while merging net
with net-next.

Thank you,
	Antonio




++<<<<<<< HEAD
++=======
+ 	int if_num;
++>>>>>>> 7caf69f... batman-adv: Fix symmetry check / route flapping in multi interface setups


resolves to:
========
	int if_num;
>>>>>>>>




++<<<<<<< HEAD
 +		sum_orig = orig_node_tmp->bcast_own_sum[if_incoming->if_num];
++=======
+ 		if_num = router->if_incoming->if_num;
+ 		sum_orig = orig_node_tmp->bcast_own_sum[if_num];
++>>>>>>> 7caf69f... batman-adv: Fix symmetry check / route flapping in multi interface setups

resolves to:
=======
		if_num = router->if_incoming->if_num;
		sum_orig = orig_node_tmp->bcast_own_sum[if_num];
>>>>>>>





++<<<<<<< HEAD
 +		sum_neigh = orig_node_tmp->bcast_own_sum[if_incoming->if_num];
++=======
+ 		if_num = neigh_node->if_incoming->if_num;
+ 		sum_neigh = orig_node_tmp->bcast_own_sum[if_num];
++>>>>>>> 7caf69f... batman-adv: Fix symmetry check / route flapping in multi interface setups

resolves to:
=======
		if_num = neigh_node->if_incoming->if_num;
		sum_neigh = orig_node_tmp->bcast_own_sum[if_num];
>>>>>>

