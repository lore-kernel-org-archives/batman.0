Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
Date: Sun, 16 Sep 2012 17:17:01 +0200
Message-ID: <CA+h5VgqHDke=U-dNZ8Z+27Oe2vvbNZmnARMZodFqxLp_PFTH6w@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] echo counting in batmand
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
To: b.a.t.m.a.n@lists.open-mesh.org

HI there,

I am trying to trace where the protocol updates its count of echos via
a neighbour. So far this is what I am interpreting: If I know that the
OGM came from this station, then we can record that we got the packet
in bit_mark, and update our neighbour's bcast_own_sum in their
originator entry.

if ((has_directlink_flag) && (if_incoming->addr.sin_addr.s_addr ==
bat_packet->orig) && (bat_packet->seqno - if_incoming->out.seqno + 2
== 0)) {

					debug_output(4, "count own bcast (is_my_orig): old = %i, ",
orig_neigh_node->bcast_own_sum[if_incoming->if_num]);

					bit_mark((TYPE_OF_WORD
*)&(orig_neigh_node->bcast_own[if_incoming->if_num * num_words]), 0);
					orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
bit_packet_count((TYPE_OF_WORD
*)&(orig_neigh_node->bcast_own[if_incoming->if_num * num_words]));

					debug_output(4, "new = %i \n",
orig_neigh_node->bcast_own_sum[if_incoming->if_num]);

				}

What I am trying to see is where the sliding window (of size
local_window_size) for echos is defined. This I cannot locate, and in
my report I am saying that bcast_own_sum is the sliding window for
echos, which I am not sure is correct or incorrect.

Thanks in advance for the help.

Regards
Dominic
UCT, SA
