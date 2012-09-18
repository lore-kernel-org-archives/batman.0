Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 18 Sep 2012 10:59:03 +0800
References: <CA+h5VgqHDke=U-dNZ8Z+27Oe2vvbNZmnARMZodFqxLp_PFTH6w@mail.gmail.com>
In-Reply-To: <CA+h5VgqHDke=U-dNZ8Z+27Oe2vvbNZmnARMZodFqxLp_PFTH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201209181059.03866.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] echo counting in batmand
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi,

> if ((has_directlink_flag) && (if_incoming->addr.sin_addr.s_addr ==
> bat_packet->orig) && (bat_packet->seqno - if_incoming->out.seqno + 2
> == 0)) {
> 
> 					debug_output(4, "count own bcast (is_my_orig): old = %i, 
",
> orig_neigh_node->bcast_own_sum[if_incoming->if_num]);
> 
> 					bit_mark((TYPE_OF_WORD
> *)&(orig_neigh_node->bcast_own[if_incoming->if_num * num_words]), 0);
> 					orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
> bit_packet_count((TYPE_OF_WORD
> *)&(orig_neigh_node->bcast_own[if_incoming->if_num * num_words]));
> 
> 					debug_output(4, "new = %i \n",
> orig_neigh_node->bcast_own_sum[if_incoming->if_num]);
> 
> 				}

you may want to look at the corresponding kernel code because it is way 
cleaner and easier to understand.

Cheers,
Marek
